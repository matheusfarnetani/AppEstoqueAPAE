const EstoqueEntrada = require("../models/EstoqueEntrada.js");

class EstoqueEntradaController {
  // Add new stock entry
  async create(req, res) {
    const {
      insumos_id,
      doacoes_id,
      quantidade,
      unidades_medida_id,
      data_validade,
    } = req.body;
    const user_id = req.user_id; // Get user_id from middleware

    const result = await EstoqueEntrada.addStockEntry(
      { insumos_id, doacoes_id, quantidade, unidades_medida_id, data_validade },
      user_id
    );

    if (result.status) {
      return res.status(200).json({
        success: true,
        message: "Stock entry created successfully!",
        id: result.id,
      });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Get all stock entries with details
  async findAll(req, res) {
    const result = await EstoqueEntrada.findAllWithDetails();

    if (result.status) {
      return res.status(200).json({ success: true, estoque: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Get a single stock entry by ID
  async findById(req, res) {
    const { id } = req.params;
    const result = await EstoqueEntrada.findById(id);

    if (result.status) {
      return res.status(200).json({ success: true, estoque: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Update stock entry by ID
  async update(req, res) {
    const { id } = req.params;
    const {
      insumos_id,
      doacoes_id,
      quantidade,
      unidades_medida_id,
      data_validade,
    } = req.body;
    const user_id = req.user_id;

    const result = await EstoqueEntrada.update(
      id,
      { insumos_id, doacoes_id, quantidade, unidades_medida_id, data_validade },
      user_id
    );

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Delete stock entry by ID
  async delete(req, res) {
    const { id } = req.params;
    const user_id = req.user_id;

    const result = await EstoqueEntrada.delete(id, user_id);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }
}

module.exports = new EstoqueEntradaController();
