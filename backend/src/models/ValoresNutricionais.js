const BaseModel = require("./BaseModel.js");
const knex = require("../data/connection.js");

class ValoresNutricionais extends BaseModel {
  constructor() {
    super("valores_nutricionais"); // Define the table name
  }

  // Find by insumo_id
  async findById(insumos_id, columns = ["*"]) {
    try {
      const result = await knex(this.tableName)
        .select(columns)
        .where({ insumos_id }) // Use insumos_id instead of id
        .first();
      if (!result) {
        return {
          status: false,
          message: `Valores nutricionais not found for insumo_id: ${insumos_id}`,
        };
      }
      return { status: true, values: result };
    } catch (error) {
      console.error("Error during findById:", error.message);
      return { status: false, err: error.message };
    }
  }

  // Update by insumo_id
  async update(insumos_id, data, user_id) {
    const trx = await knex.transaction();
    try {
      await this.setUserSession(trx, user_id); // Set session for user actions

      const result = await trx(this.tableName)
        .where({ insumos_id })
        .update(data);
      await trx.commit();

      if (result === 0) {
        return {
          status: false,
          message: `Valores nutricionais not found for insumo_id: ${insumos_id}`,
        };
      }
      return {
        status: true,
        message: `Valores nutricionais updated successfully for insumo_id: ${insumos_id}`,
      };
    } catch (error) {
      await trx.rollback();
      console.error("Error during update:", error.message);
      return { status: false, err: error.message };
    }
  }

  // Delete by insumo_id
  async delete(insumos_id, user_id) {
    const trx = await knex.transaction();
    try {
      await this.setUserSession(trx, user_id); // Set session for user actions

      const result = await trx(this.tableName).where({ insumos_id }).del();
      await trx.commit();

      if (result === 0) {
        return {
          status: false,
          message: `Valores nutricionais not found for insumo_id: ${insumos_id}`,
        };
      }
      return {
        status: true,
        message: `Valores nutricionais deleted successfully for insumo_id: ${insumos_id}`,
      };
    } catch (error) {
      await trx.rollback();
      console.error("Error during delete:", error.message);
      return { status: false, err: error.message };
    }
  }
}

module.exports = new ValoresNutricionais();
