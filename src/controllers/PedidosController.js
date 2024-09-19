const Pedidos = require("../models/Pedidos.js");

class PedidosController {
  // Create a new pedido
  async create(req, res) {
    const { usuarios_id, pessoas_id, descricao, data_pedido } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await Pedidos.create(
      { usuarios_id, pessoas_id, descricao, data_pedido },
      user_id
    );

    if (result.status) {
      return res.status(200).json({
        success: true,
        message: "Pedido criado com sucesso!",
        id: result.id,
      });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Get all pedidos
  async findAll(req, res) {
    const result = await Pedidos.findAll();

    if (result.status) {
      return res.status(200).json({ success: true, pedidos: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Get a specific pedido by ID
  async findById(req, res) {
    const { id } = req.params;

    const result = await Pedidos.findById(id);

    if (result.status) {
      return res.status(200).json({ success: true, pedido: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Update a pedido by ID
  async update(req, res) {
    const { id } = req.params;
    const { usuarios_id, pessoas_id, descricao, data_pedido } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await Pedidos.update(
      id,
      usuarios_id,
      pessoas_id,
      descricao,
      data_pedido,
      user_id
    );

    if (result.status) {
      return res
        .status(200)
        .json({ success: true, message: "Pedido atualizado com sucesso!" });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Delete a pedido by ID
  async delete(req, res) {
    const { id } = req.params;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await Pedidos.delete(id, user_id);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch all doacoes related to a specific pedido
  async findDoacoesByPedido(req, res) {
    const { pedido_id } = req.params;

    const result = await Pedidos.findDoacoesByPedido(pedido_id);

    if (result.status) {
      return res.status(200).json({ success: true, doacoes: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Link a doacao to a pedido
  async linkDoacao(req, res) {
    const { pedidos_id, doacoes_id } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await Pedidos.linkDoacao(pedidos_id, doacoes_id, user_id);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Unlink a doacao from a pedido
  async unlinkDoacao(req, res) {
    const { pedidos_id, doacoes_id } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await Pedidos.unlinkDoacao(pedidos_id, doacoes_id, user_id);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }
}

module.exports = new PedidosController();
