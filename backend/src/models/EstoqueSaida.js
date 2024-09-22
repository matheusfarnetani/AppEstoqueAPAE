const BaseModel = require("./BaseModel.js");
const knex = require("../data/connection.js");

class EstoqueSaida extends BaseModel {
  constructor() {
    super("estoque_saida"); // Define the table name
  }

  // Fetch all stock exit records (using view or table)
  async findAll() {
    try {
      const result = await knex("view_estoque_saida").select("*");
      return { status: true, values: result };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Fetch a specific stock exit by estoque_saida ID
  async findById(id) {
    try {
      const result = await knex("view_estoque_saida")
        .where("estoque_saida_id", id)
        .first();

      return result
        ? { status: true, values: result }
        : { status: false, message: "Stock exit not found." };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Fetch stock exit records by insumo ID (all exits related to a specific insumo)
  async findByInsumoId(insumos_id) {
    try {
      const result = await knex("view_estoque_saida")
        .where("insumos_id", insumos_id)
        .select("*");

      return result.length > 0
        ? { status: true, values: result }
        : {
            status: false,
            message: "No stock exit records found for this insumo.",
          };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }
}

module.exports = new EstoqueSaida();
