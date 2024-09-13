const Endereco = require("../models/Endereco");

class EnderecosController {
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

    let result = await Endereco.create(
      tipo,
      logradouro,
      numero,
      complemento,
      bairro,
      cidade,
      estado,
      cep
    );

    if (result.status) {
      return res
        .status(200)
        .json({
          success: true,
          message: "Endereço criado com sucesso!",
          id: result.id,
        });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  async findAll(req, res) {
    let result = await Endereco.findAll();

    if (result.status) {
      return res.status(200).json({ success: true, enderecos: result.values });
    } else {
      return res.status(400).json({ success: false, message: result.err });
    }
  }

  async findById(req, res) {
    let { id } = req.params;

    let result = await Endereco.findById(id);

    if (result.status) {
      return res.status(200).json({ success: true, endereco: result.values });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }

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

    let result = await Endereco.update(
      id,
      tipo,
      logradouro,
      numero,
      complemento,
      bairro,
      cidade,
      estado,
      cep
    );

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(400).json({ success: false, message: result.message });
    }
  }

  async delete(req, res) {
    let { id } = req.params;

    let result = await Endereco.delete(id);

    if (result.status) {
      return res.status(200).json({ success: true, message: result.message });
    } else {
      return res.status(404).json({ success: false, message: result.message });
    }
  }
}

module.exports = new EnderecosController();
