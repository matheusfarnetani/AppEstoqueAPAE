const Pessoa = require("../models/Pessoa.js");

class PessoasController {
  // Create a new person
  async create(req, res) {
    const {
      tipo_pessoa,
      nome,
      documento,
      data_nascimento,
      email,
      endereco_id,
    } = req.body;
    const user_id = req.user_id; // Extract user_id from middleware

    const result = await Pessoa.create(
      tipo_pessoa,
      nome,
      documento,
      data_nascimento,
      email,
      endereco_id,
      user_id
    );

    if (result.status) {
      res.status(200).json({
        success: true,
        message: "Pessoa criada com sucesso!",
        id: result.id,
      });
    } else {
      res.status(400).json({ success: false, message: result.err });
    }
  }

  // Get all people
  async findAll(req, res) {
    const result = await Pessoa.findAll();

    if (result.status) {
      res.status(200).json({ success: true, pessoas: result.values });
    } else {
      res.status(400).json({ success: false, message: result.err });
    }
  }

  // Get a person by ID
  async findById(req, res) {
    const { id } = req.params;

    const result = await Pessoa.findById(id);

    if (result.status) {
      res.status(200).json({ success: true, pessoa: result.values });
    } else {
      res.status(404).json({ success: false, message: result.message });
    }
  }

  // Update a person by ID
  async update(req, res) {
    const { id } = req.params;
    const {
      tipo_pessoa,
      nome,
      documento,
      data_nascimento,
      email,
      endereco_id,
    } = req.body;
    const user_id = req.user_id; // Extract user_id from middleware

    const result = await Pessoa.update(
      id,
      tipo_pessoa,
      nome,
      documento,
      data_nascimento,
      email,
      endereco_id,
      user_id
    );

    if (result.status) {
      res.status(200).json({ success: true, message: result.message });
    } else {
      res.status(400).json({ success: false, message: result.err });
    }
  }

  // Delete a person by ID
  async delete(req, res) {
    const { id } = req.params;
    const user_id = req.user_id; // Extract user_id from middleware

    const result = await Pessoa.delete(id, user_id);

    if (result.status) {
      res.status(200).json({ success: true, message: result.message });
    } else {
      res.status(404).json({ success: false, message: result.message });
    }
  }

  // Get all details of a pessoa, including endereco and telefones
  async getDetails(req, res) {
    const { id } = req.params;

    const result = await Pessoa.getPessoaWithDetails(id);

    if (result.status) {
      return res.status(200).json({ success: true, details: result });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }
}

module.exports = new PessoasController();
