const Endereco = require("../models/Endereco.js");

class EnderecosController {
  // Create a new address
  async create(req, res) {
    const {
      tipo,
      logradouro,
      numero,
      complemento,
      bairro,
      cidade,
      estado,
      cep,
    } = req.body;
    const user_id = req.user_id; // Extract user_id from middleware

    let result = await Endereco.create(
      tipo,
      logradouro,
      numero,
      complemento,
      bairro,
      cidade,
      estado,
      cep,
      user_id // Pass user_id to set session variable
    );

    if (result.status) {
      return res.status(200).json({
        success: true,
        message: "Endereço criado com sucesso!",
        id: result.id,
      });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Get all addresses
  async findAll(req, res) {
    let result = await Endereco.findAll();

    if (result.status) {
      return res.status(200).json({ success: true, enderecos: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  // Get address by ID
  async findById(req, res) {
    let { id } = req.params;

    let result = await Endereco.findById(id);

    if (result.status) {
      return res.status(200).json({ success: true, endereco: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

  // Update address by ID
  async update(req, res) {
    let { id } = req.params;
    const {
      tipo,
      logradouro,
      numero,
      complemento,
      bairro,
      cidade,
      estado,
      cep,
    } = req.body;
    const user_id = req.user_id; // Extract user_id from middleware

    let result = await Endereco.update(
      id,
      tipo,
      logradouro,
      numero,
      complemento,
      bairro,
      cidade,
      estado,
      cep,
      user_id // Pass user_id to set session variable
    );

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.message });
    }
  }

  // Delete address by ID
  async delete(req, res) {
    const { id } = req.params;
    const user_id = req.user_id; // Extract user_id from middleware

    const result = await Endereco.delete(id, user_id); // Pass user_id to set session

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }
}

module.exports = new EnderecosController();
