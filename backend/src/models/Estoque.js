const BaseModel = require("./BaseModel.js");
const knex = require("../data/connection.js");

class Estoque extends BaseModel {
  constructor() {
    super("estoque"); // Define the table name
  }

  // Fetch stock by ID using the view
  async findById(id) {
    try {
      const result = await knex("view_estoque_completo")
        .where("estoque_id", id)
        .first();

      return result
        ? { status: true, values: result }
        : { status: false, message: "Stock item not found." };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Fetch all stock entries using views (fechado, aberto, vencendo hoje)
  async findAllByView(viewName) {
    try {
      const result = await knex(viewName).select("*");
      return { status: true, values: result };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Update stock by calling the stored procedure
  async updateStockUsingProcedure(id, novo_status, observacao, user_id) {
    const trx = await knex.transaction();
    try {
      await this.setUserSession(trx, user_id); // Set session for auditing

      // Call the stored procedure for updating and moving stock
      await trx.raw("CALL proc_atualizar_e_mover_estoque(?, ?, ?)", [
        id,
        novo_status,
        observacao,
      ]);

      await trx.commit();
      return { status: true, message: "Stock updated and moved successfully." };
    } catch (err) {
      await trx.rollback();
      console.error("Error during stock update:", err.message);
      return { status: false, err: err.message };
    }
  }
}

module.exports = new Estoque();
