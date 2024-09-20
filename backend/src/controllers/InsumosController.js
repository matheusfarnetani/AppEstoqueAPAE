const Insumos = require("../models/Insumos.js");

class InsumosController {
  // Create a new insumo
  async create(req, res) {
    const { nome, categoria_insumos_id, observacoes } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await Insumos.create(
      { nome, categoria_insumos_id, observacoes },
      user_id
    );

    if (result.status) {
      return res
        .status(200)
        .json({
          success: true,
          message: "Insumo criado com sucesso!",
          id: result.id,
        });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch all insumos
  async findAll(req, res) {
    const result = await Insumos.findAll();

    if (result.status) {
      return res.status(200).json({ success: true, insumos: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch insumo by ID
  async findById(req, res) {
    const { id } = req.params;

    const result = await Insumos.findById(id);

    if (result.status) {
      return res.status(200).json({ success: true, insumo: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Update an insumo by ID
  async update(req, res) {
    const { id } = req.params;
    const { nome, categoria_insumos_id, observacoes } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await Insumos.update(
      id,
      { nome, categoria_insumos_id, observacoes },
      user_id
    );

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Delete an insumo by ID
  async delete(req, res) {
    const { id } = req.params;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await Insumos.delete(id, user_id);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }
}

module.exports = new InsumosController();
