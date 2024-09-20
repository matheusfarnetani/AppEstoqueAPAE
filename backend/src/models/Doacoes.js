const BaseModel = require("./BaseModel");
const knex = require("../data/connection");

class Doacoes extends BaseModel {
  constructor() {
    super("doacoes"); // Define the table name
  }

  // Fetch all donations, using the view to join data from pessoas
  async findAll() {
    try {
      // Query the view instead of the original tables
      const doacoes = await knex("view_doacoes_pessoas").select("*");

      return { status: true, values: doacoes };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Fetch a specific donation by ID, using the view
  async findById(id) {
    try {
      // Query the view instead of the original tables
      const doacao = await knex("view_doacoes_pessoas")
        .where("doacao_id", id)
        .first();

      return doacao
        ? { status: true, values: doacao }
        : { status: false, message: "Doação não encontrada." };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Custom update method for Doacoes
  async update(id, pessoas_id, descricao, data_doacao, user_id) {
    const updatedFields = {
      pessoas_id,
      descricao,
      data_doacao,
    };

    // Remove undefined fields
    Object.keys(updatedFields).forEach((key) => {
      if (!updatedFields[key]) delete updatedFields[key];
    });

    try {
      // Use BaseModel's update method
      return await super.update(id, updatedFields, user_id); // Call BaseModel's update method
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Delete donation by ID (no need to recreate, just use BaseModel's delete)

  // Fetch all pedidos related to a specific doacao (using the view)
  async findPedidosByDoacao(doacao_id) {
    try {
      const pedidos = await knex("view_pedidos_by_doacao")
        .where("doacoes_id", doacao_id)
        .select("pedido_id", "pedido_descricao", "data_pedido");

      return { status: true, values: pedidos };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Link a doacao with a pedido (set the criado_por using transaction)
  async linkPedido(doacoes_id, pedidos_id, user_id) {
    const trx = await knex.transaction(); // Start transaction
    try {
      // Set the session for the user ID (who's performing the operation)
      await trx.raw("SET @user_id = ?", [user_id]);

      // Insert the link into doacoes_has_pedidos table with a transaction
      await trx("doacoes_has_pedidos").insert({
        doacoes_id,
        pedidos_id,
      });

      await trx.commit(); // Commit the transaction
      return { status: true, message: "Pedido linked to Doacao successfully!" };
    } catch (err) {
      await trx.rollback(); // Rollback in case of error
      return { status: false, err: err.message };
    }
  }

  // Unlink a doacao from a pedido (set the user performing the action)
  async unlinkPedido(doacoes_id, pedidos_id, user_id) {
    const trx = await knex.transaction(); // Start transaction
    try {
      // Set the session for the user ID (who's performing the operation)
      await trx.raw("SET @user_id = ?", [user_id]);

      // Delete the link from doacoes_has_pedidos with a transaction
      await trx("doacoes_has_pedidos").where({ doacoes_id, pedidos_id }).del();

      await trx.commit(); // Commit the transaction
      return {
        status: true,
        message: "Pedido unlinked from Doacao successfully!",
      };
    } catch (err) {
      await trx.rollback(); // Rollback in case of error
      return { status: false, err: err.message };
    }
  }
}

module.exports = new Doacoes();
