const BaseModel = require("./BaseModel.js");
const knex = require("../data/connection.js");

class EstoqueVencido extends BaseModel {
  constructor() {
    super("estoque_vencido");
  }

  // Fetch all non-discarded expired items
  async findAllNonDescartados() {
    try {
      const result = await knex("view_insumos_vencidos_nao_descartados").select(
        "*"
      );
      return { status: true, values: result };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Fetch all discarded expired items
  async findAllDescartados() {
    try {
      const result = await knex("view_insumos_vencidos_descartados").select(
        "*"
      );
      return { status: true, values: result };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Fetch a specific non-discarded item by its ID
  async findByIdNonDescartado(id) {
    try {
      const result = await knex("view_insumos_vencidos_nao_descartados")
        .where("estoque_vencido_id", id)
        .first();

      return result
        ? { status: true, values: result }
        : {
            status: false,
            message: "Expired item (não descartado) not found.",
          };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Fetch a specific discarded item by its ID
  async findByIdDescartado(id) {
    try {
      const result = await knex("view_insumos_vencidos_descartados")
        .where("estoque_vencido_id", id)
        .first();

      return result
        ? { status: true, values: result }
        : { status: false, message: "Expired item (descartado) not found." };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Fetch non-discarded expired items by Insumo ID
  async findByInsumoIdNonDescartado(insumos_id) {
    try {
      const result = await knex("view_insumos_vencidos_nao_descartados")
        .where("insumos_id", insumos_id)
        .select("*");

      return result.length > 0
        ? { status: true, values: result }
        : {
            status: false,
            message: "No non-discarded expired items found for this insumo.",
          };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Fetch discarded expired items by Insumo ID
  async findByInsumoIdDescartado(insumos_id) {
    try {
      const result = await knex("view_insumos_vencidos_descartados")
        .where("insumos_id", insumos_id)
        .select("*");

      return result.length > 0
        ? { status: true, values: result }
        : {
            status: false,
            message: "No discarded expired items found for this insumo.",
          };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Update the 'descartado' field for an expired item
  async updateDescartado(id, descartado) {
    const trx = await knex.transaction();
    try {
      await this.setUserSession(trx, null); // Use the session method
      await trx("estoque_vencido").where({ id }).update({ descartado });
      await trx.commit();
      return {
        status: true,
        message: "Descartado field updated successfully!",
      };
    } catch (err) {
      await trx.rollback();
      return { status: false, err: err.message };
    }
  }
}

module.exports = new EstoqueVencido();
