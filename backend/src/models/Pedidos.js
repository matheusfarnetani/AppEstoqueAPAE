const BaseModel = require("./BaseModel.js");
const knex = require("../data/connection.js");

class Pedidos extends BaseModel {
  constructor() {
    super("pedidos"); // Define the table name for create, update, delete
  }

  // Fetch all pedidos, including related pessoa and usuario info
  async findAll() {
    try {
      const pedidos = await knex("view_pedidos").select("*"); // Query the view
      return { status: true, values: pedidos };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Fetch a specific pedido by ID, using the view
  async findById(id) {
    try {
      const pedido = await knex("view_pedidos").where("pedido_id", id).first();
      return pedido
        ? { status: true, values: pedido }
        : { status: false, message: "Pedido não encontrado." };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Custom update method for Pedidos
  async update(id, usuarios_id, pessoas_id, descricao, data_pedido, user_id) {
    const updatedFields = {
      usuarios_id,
      pessoas_id,
      descricao,
      data_pedido,
    };

    // Remove undefined fields
    Object.keys(updatedFields).forEach((key) => {
      if (!updatedFields[key]) delete updatedFields[key];
    });

    try {
      return await super.update(id, updatedFields, user_id); // Call BaseModel's update method
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Fetch all doacoes related to a specific pedido (using the view)
  async findDoacoesByPedido(pedido_id) {
    try {
      const doacoes = await knex("view_doacoes_by_pedido")
        .where("pedidos_id", pedido_id)
        .select("doacao_id", "doacao_descricao", "data_doacao");

      return { status: true, values: doacoes };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Link a pedido with a doacao (set the user_id using a transaction)
  async linkDoacao(pedidos_id, doacoes_id, user_id) {
    const trx = await knex.transaction(); // Start transaction
    try {
      // Set the session for the user ID
      await trx.raw("SET @user_id = ?", [user_id]);

      // Insert the link into doacoes_has_pedidos with a transaction
      await trx("doacoes_has_pedidos").insert({
        pedidos_id,
        doacoes_id,
      });

      await trx.commit(); // Commit the transaction
      return { status: true, message: "Doacao linked to Pedido successfully!" };
    } catch (err) {
      await trx.rollback(); // Rollback in case of error
      return { status: false, err: err.message };
    }
  }

  // Unlink a pedido from a doacao (set the user_id using a transaction)
  async unlinkDoacao(pedidos_id, doacoes_id, user_id) {
    const trx = await knex.transaction(); // Start transaction
    try {
      // Set the session for the user ID
      await trx.raw("SET @user_id = ?", [user_id]);

      // Delete the link from doacoes_has_pedidos with a transaction
      await trx("doacoes_has_pedidos").where({ pedidos_id, doacoes_id }).del();

      await trx.commit(); // Commit the transaction
      return {
        status: true,
        message: "Doacao unlinked from Pedido successfully!",
      };
    } catch (err) {
      await trx.rollback(); // Rollback in case of error
      return { status: false, err: err.message };
    }
  }
}

module.exports = new Pedidos();
