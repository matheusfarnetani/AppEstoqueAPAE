const UnidadeMedida = require("../models/UnidadeMedida");

class UnidadeMedidaController {
  // Create a new unidade_medida
  async create(req, res) {
    const { nome } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await UnidadeMedida.create({ nome }, user_id);

    if (result.status) {
      return res.status(200).json({
        success: true,
        message: "Unidade de medida criada com sucesso!",
        id: result.id,
      });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch all unidades_medida
  async findAll(req, res) {
    const result = await UnidadeMedida.findAll(["id", "nome"]);

    if (result.status) {
      return res.status(200).json({ success: true, unidades: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch unidade_medida by ID
  async findById(req, res) {
    const { id } = req.params;

    const result = await UnidadeMedida.findById(id, ["id", "nome"]);

    if (result.status) {
      return res.status(200).json({ success: true, unidade: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Update unidade_medida by ID
  async update(req, res) {
    const { id } = req.params;
    const { nome } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await UnidadeMedida.update(id, { nome }, user_id);

    if (result.status) {
      return res
        .status(200)
        .json({
          success: true,
          message: "Unidade de medida atualizada com sucesso!",
        });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Delete unidade_medida by ID
  async delete(req, res) {
    const { id } = req.params;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await UnidadeMedida.delete(id, user_id);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }
}

module.exports = new UnidadeMedidaController();
