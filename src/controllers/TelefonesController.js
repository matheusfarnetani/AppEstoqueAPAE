const Telefone = require("../models/Telefone.js");

class TelefonesController {
  // Create a new phone
  async create(req, res) {
    const { tipo, ddi, ddd, numero } = req.body;
    const user_id = req.user_id; // Extract user_id from middleware

    const result = await Telefone.create(tipo, ddi, ddd, numero, user_id);

    if (result.status) {
      res.status(200).json({
        success: true,
        message: "Telefone criado com sucesso!",
        id: result.id,
      });
    } else {
      res.status(400).json({ success: false, message: result.err });
    }
  }

  // Get all phones
  async findAll(req, res) {
    const result = await Telefone.findAll();

    if (result.status) {
      res.status(200).json({ success: true, telefones: result.values });
    } else {
      res.status(400).json({ success: false, message: result.err });
    }
  }

  // Get phone by ID
  async findById(req, res) {
    const { id } = req.params;

    const result = await Telefone.findById(id);

    if (result.status) {
      res.status(200).json({ success: true, telefone: result.values });
    } else {
      res.status(404).json({ success: false, message: result.message });
    }
  }

  // Update phone by ID
  async update(req, res) {
    const { id } = req.params;
    const { tipo, ddi, ddd, numero } = req.body;
    const user_id = req.user_id; // Extract user_id from middleware

    const result = await Telefone.update(id, tipo, ddi, ddd, numero, user_id);

    if (result.status) {
      res.status(200).json({ success: true, message: result.message });
    } else {
      res.status(400).json({ success: false, message: result.err });
    }
  }

  // Delete phone by ID
  async delete(req, res) {
    const { id } = req.params;
    const user_id = req.user_id; // Extract user_id from middleware

    const result = await Telefone.delete(id, user_id); // Pass user_id to set session

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }
}

module.exports = new TelefonesController();
