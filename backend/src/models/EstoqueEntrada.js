const BaseModel = require("./BaseModel.js");
const knex = require("../data/connection.js");

class EstoqueEntrada extends BaseModel {
  constructor() {
    super("estoque_entrada"); // Define the table name
  }

  // Custom method to add stock entry
  async addStockEntry(data, user_id) {
    const trx = await knex.transaction();
    try {
      await this.setUserSession(trx, user_id); // Set session

      const result = await trx(this.tableName).insert(data);
      await trx.commit();
      return { status: true, id: result[0] };
    } catch (error) {
      await trx.rollback();
      console.error("Error during stock entry creation:", error.message);
      return { status: false, err: error.message };
    }
  }

  // Method to retrieve all stock entries
  async findAllWithDetails() {
    try {
      const results = await knex(this.tableName)
        .join("insumos", "estoque_entrada.insumos_id", "=", "insumos.id")
        .join(
          "unidades_medida",
          "estoque_entrada.unidades_medida_id",
          "=",
          "unidades_medida.id"
        )
        .select(
          "estoque_entrada.*",
          "insumos.nome as insumo_nome",
          "unidades_medida.nome as unidade_medida_nome"
        );
      return { status: true, values: results };
    } catch (error) {
      console.error("Error fetching stock entries:", error.message);
      return { status: false, err: error.message };
    }
  }
}

module.exports = new EstoqueEntrada();
