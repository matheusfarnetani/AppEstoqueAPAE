const ItensPedido = require("../models/ItensPedido.js");

class ItensPedidoController {
  // Create a new item for a pedido
  async create(req, res) {
    const { pedidos_id, insumos_id, quantidade, unidades_medida_id } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await ItensPedido.createItem(
      pedidos_id,
      insumos_id,
      quantidade,
      unidades_medida_id,
      user_id
    );

    if (result.status) {
      return res
        .status(200)
        .json({
          success: true,
          message: "Item created successfully!",
          id: result.id,
        });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch all items related to a specific pedido
  async findByPedido(req, res) {
    const { pedidos_id } = req.params;

    const result = await ItensPedido.findByPedido(pedidos_id);

    if (result.status) {
      return res.status(200).json({ success: true, itens: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch a specific item by its item_id
  async findById(req, res) {
    const { item_id } = req.params;

    const result = await ItensPedido.findById(item_id);

    if (result.status) {
      return res.status(200).json({ success: true, item: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Update an item
  async update(req, res) {
    const { id } = req.params;
    const { insumos_id, quantidade, unidades_medida_id } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await ItensPedido.update(
      id,
      insumos_id,
      quantidade,
      unidades_medida_id,
      user_id
    );

    if (result.status) {
      return res
        .status(200)
        .json({ success: true, message: "Item updated successfully!" });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Delete an item
  async delete(req, res) {
    const { id } = req.params;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await ItensPedido.deleteItem(id, user_id);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }
}

module.exports = new ItensPedidoController();
