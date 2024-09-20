const ValoresNutricionais = require("../models/ValoresNutricionais");

class ValoresNutricionaisController {
  // Update valores_nutricionais by insumos_id
  async update(req, res) {
    const { insumos_id } = req.params; // Extract the insumo ID from the request
    const data = req.body; // Get the nutritional values from the request body
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await ValoresNutricionais.update(insumos_id, data, user_id);

    if (result.status) {
      return res.status(200).json({
        success: true,
        message: "Valores nutricionais atualizados com sucesso!",
      });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch all valores_nutricionais
  async findAll(req, res) {
    const result = await ValoresNutricionais.findAll();

    if (result.status) {
      return res.status(200).json({ success: true, valores: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch valores_nutricionais by insumo ID
  async findByInsumo(req, res) {
    const { insumos_id } = req.params;

    const result = await ValoresNutricionais.findById(insumos_id);

    if (result.status) {
      return res.status(200).json({ success: true, valor: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Delete valores_nutricionais by insumos_id
  async delete(req, res) {
    const { insumos_id } = req.params;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await ValoresNutricionais.delete(insumos_id, user_id);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }
}

module.exports = new ValoresNutricionaisController();
