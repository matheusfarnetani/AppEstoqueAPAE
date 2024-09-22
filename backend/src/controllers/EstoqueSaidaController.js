const EstoqueSaida = require("../models/EstoqueSaida.js");

class EstoqueSaidaController {
  // Fetch all stock exit records
  async findAll(req, res) {
    const result = await EstoqueSaida.findAll();

    if (result.status) {
      return res
        .status(200)
        .json({ success: true, estoque_saida: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch stock exit record by estoque_saida ID
  async findById(req, res) {
    const { id } = req.params;

    const result = await EstoqueSaida.findById(id);

    if (result.status) {
      return res
        .status(200)
        .json({ success: true, estoque_saida: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Fetch stock exit records by insumo ID
  async findByInsumoId(req, res) {
    const { insumos_id } = req.params;

    const result = await EstoqueSaida.findByInsumoId(insumos_id);

    if (result.status) {
      return res
        .status(200)
        .json({ success: true, estoque_saida: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }
}

module.exports = new EstoqueSaidaController();
