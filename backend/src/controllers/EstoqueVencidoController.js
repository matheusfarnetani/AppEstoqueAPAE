const EstoqueVencido = require("../models/EstoqueVencido.js");

class EstoqueVencidoController {
  // Fetch all non-discarded expired items
  async findAllNonDescartados(req, res) {
    const result = await EstoqueVencido.findAllNonDescartados();

    if (result.status) {
      return res
        .status(200)
        .json({ success: true, estoque_vencido: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch all discarded expired items
  async findAllDescartados(req, res) {
    const result = await EstoqueVencido.findAllDescartados();

    if (result.status) {
      return res
        .status(200)
        .json({ success: true, estoque_vencido: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch a non-discarded expired item by its ID
  async findByIdNonDescartado(req, res) {
    const { id } = req.params;

    const result = await EstoqueVencido.findByIdNonDescartado(id);

    if (result.status) {
      return res
        .status(200)
        .json({ success: true, estoque_vencido: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Fetch a discarded expired item by its ID
  async findByIdDescartado(req, res) {
    const { id } = req.params;

    const result = await EstoqueVencido.findByIdDescartado(id);

    if (result.status) {
      return res
        .status(200)
        .json({ success: true, estoque_vencido: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Fetch non-discarded expired items by Insumo ID
  async findByInsumoIdNonDescartado(req, res) {
    const { insumos_id } = req.params;

    const result = await EstoqueVencido.findByInsumoIdNonDescartado(insumos_id);

    if (result.status) {
      return res
        .status(200)
        .json({ success: true, estoque_vencido: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Fetch discarded expired items by Insumo ID
  async findByInsumoIdDescartado(req, res) {
    const { insumos_id } = req.params;

    const result = await EstoqueVencido.findByInsumoIdDescartado(insumos_id);

    if (result.status) {
      return res
        .status(200)
        .json({ success: true, estoque_vencido: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Update 'descartado' status
  async updateDescartado(req, res) {
    const { id } = req.params;
    const { descartado } = req.body;

    const result = await EstoqueVencido.updateDescartado(id, descartado);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }
}

module.exports = new EstoqueVencidoController();
