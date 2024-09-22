const Estoque = require("../models/Estoque.js");

class EstoqueController {
  // Fetch all stock items by a specific view (fechado, aberto, vencendo_hoje)
  async findByView(req, res) {
    const { view } = req.params; // e.g., view_estoque_fechado, view_estoque_aberto
    const validViews = [
      "view_estoque_completo",
      "view_estoque_fechado",
      "view_estoque_aberto",
      "view_estoque_vencendo_hoje",
    ];

    if (!validViews.includes(view)) {
      return res
        .status(400)
        .json({ success: false, message: "Invalid view name." });
    }

    const result = await Estoque.findAllByView(view);

    if (result.status) {
      return res.status(200).json({ success: true, estoque: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch a single stock item by ID using the view
  async findById(req, res) {
    const { id } = req.params;

    const result = await Estoque.findById(id);

    if (result.status) {
      return res.status(200).json({ success: true, estoque: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Update stock by calling the stored procedure
  async update(req, res) {
    const { id } = req.params;
    const { novo_status, observacao } = req.body;
    const user_id = req.user_id; // Get user_id from middleware

    if (!novo_status) {
      return res
        .status(400)
        .json({ success: false, message: "Status is required." });
    }

    const result = await Estoque.updateStockUsingProcedure(
      id,
      novo_status,
      observacao,
      user_id
    );

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }
}

module.exports = new EstoqueController();
