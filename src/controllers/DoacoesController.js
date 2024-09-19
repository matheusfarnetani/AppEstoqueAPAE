const Doacoes = require("../models/Doacoes");

class DoacoesController {
  // Create a new donation
  async create(req, res) {
    const { pessoas_id, descricao, data_doacao } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await Doacoes.create(
      { pessoas_id, descricao, data_doacao }, // No "valor" field
      user_id
    );

    if (result.status) {
      return res.status(200).json({
        success: true,
        message: "Doação criada com sucesso!",
        id: result.id,
      });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Get all donations
  async findAll(req, res) {
    const result = await Doacoes.findAll();

    if (result.status) {
      return res.status(200).json({ success: true, doacoes: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Get a specific donation by ID
  async findById(req, res) {
    const { id } = req.params;

    const result = await Doacoes.findById(id);

    if (result.status) {
      return res.status(200).json({ success: true, doacao: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Update a donation by ID
  async update(req, res) {
    const { id } = req.params;
    const { pessoas_id, descricao, data_doacao } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await Doacoes.update(
      id,
      pessoas_id,
      descricao,
      data_doacao,
      user_id
    );

    if (result.status) {
      return res
        .status(200)
        .json({ success: true, message: "Doação atualizada com sucesso!" });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Delete a donation by ID (using BaseModel's delete)
  async delete(req, res) {
    const { id } = req.params;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await Doacoes.delete(id, user_id);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Fetch all pedidos related to a specific doacao
  async findPedidosByDoacao(req, res) {
    const { doacao_id } = req.params;

    const result = await Doacoes.findPedidosByDoacao(doacao_id);

    if (result.status) {
      return res.status(200).json({ success: true, pedidos: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Link a pedido to a doacao
  async linkPedido(req, res) {
    const { doacoes_id, pedidos_id } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await Doacoes.linkPedido(doacoes_id, pedidos_id, user_id);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Unlink a pedido from a doacao
  async unlinkPedido(req, res) {
    const { doacoes_id, pedidos_id } = req.body;
    const user_id = req.user_id; // Get user_id from the middleware

    const result = await Doacoes.unlinkPedido(doacoes_id, pedidos_id, user_id);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }
}

module.exports = new DoacoesController();
