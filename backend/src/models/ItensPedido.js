const BaseModel = require("./BaseModel.js");
const knex = require("../data/connection.js");

class ItensPedido extends BaseModel {
  constructor() {
    super("itens_pedido"); // Define the table name
  }

  // Fetch all items related to a specific pedido using the view
  async findByPedido(pedidos_id) {
    try {
      const itens = await knex("view_itens_pedido")
        .where("pedidos_id", pedidos_id)
        .select("item_id", "insumo_nome", "quantidade", "unidade_medida_nome");

      return { status: true, values: itens };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Fetch a specific item by its item_id using the view
  async findById(item_id) {
    try {
      const item = await knex("view_itens_pedido")
        .where("item_id", item_id)
        .first();

      return item
        ? { status: true, values: item }
        : { status: false, message: "Item not found" };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Custom update method for ItensPedido
  async update(id, insumos_id, quantidade, unidades_medida_id, user_id) {
    const updatedFields = {
      insumos_id,
      quantidade,
      unidades_medida_id,
    };

    // Remove undefined fields
    Object.keys(updatedFields).forEach((key) => {
      if (!updatedFields[key]) delete updatedFields[key];
    });

    try {
      // Use BaseModel's update method
      return await super.update(id, updatedFields, user_id);
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Link a new item to a pedido
  async createItem(
    pedidos_id,
    insumos_id,
    quantidade,
    unidades_medida_id,
    user_id
  ) {
    const trx = await knex.transaction();
    try {
      // Set the session for the user ID
      await this.setUserSession(trx, user_id);

      const result = await trx("itens_pedido").insert({
        pedidos_id,
        insumos_id,
        quantidade,
        unidades_medida_id,
      });

      await trx.commit(); // Commit the transaction
      return { status: true, id: result[0] };
    } catch (err) {
      await trx.rollback();
      return { status: false, err: err.message };
    }
  }

  // Delete an item from a pedido
  async deleteItem(id, user_id) {
    const trx = await knex.transaction();
    try {
      // Set the session for the user ID
      await this.setUserSession(trx, user_id);

      const result = await trx("itens_pedido").where({ id }).del();

      await trx.commit(); // Commit the transaction
      return { status: true, message: "Item deleted successfully!" };
    } catch (err) {
      await trx.rollback();
      return { status: false, err: err.message };
    }
  }
}

module.exports = new ItensPedido();
