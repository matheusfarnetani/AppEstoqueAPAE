const CategoriaInsumo = require("../models/CategoriaInsumo.js");

class CategoriaInsumoController {
  // Create a new categoria_insumo
  async create(req, res) {
    const { nome } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await CategoriaInsumo.create({ nome }, user_id);

    if (result.status) {
      return res.status(200).json({
        success: true,
        message: "Categoria de insumo criada com sucesso!",
        id: result.id,
      });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch all categoria_insumos
  async findAll(req, res) {
    const result = await CategoriaInsumo.findAll(["id", "nome"]);

    if (result.status) {
      return res.status(200).json({ success: true, categorias: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch categoria_insumo by ID
  async findById(req, res) {
    const { id } = req.params;

    const result = await CategoriaInsumo.findById(id, ["id", "nome"]);

    if (result.status) {
      return res.status(200).json({ success: true, categoria: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Update categoria_insumo by ID
  async update(req, res) {
    const { id } = req.params;
    const { nome } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await CategoriaInsumo.update(id, { nome }, user_id);

    if (result.status) {
      return res.status(200).json({
        success: true,
        message: "Categoria de insumo atualizada com sucesso!",
      });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Delete categoria_insumo by ID
  async delete(req, res) {
    const { id } = req.params;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await CategoriaInsumo.delete(id, user_id);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }
}

module.exports = new CategoriaInsumoController();
