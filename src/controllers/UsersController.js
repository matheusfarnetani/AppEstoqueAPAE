require("dotenv").config();
var User = require("../models/Users");
var bcrypt = require("bcryptjs");
var jwt = require("jsonwebtoken");

class UsersController {
  async create(req, res) {
    let { username, email, password, funcao } = req.body;
    let result = await User.new(username, email, password, funcao);
    if (result.status) {
      res
        .status(200)
        .json({ success: true, message: "Usuário cadastrado com sucesso!" });
    } else {
      res.status(400).json({ success: false, message: result.err });
    }
  }

  async findAll(req, res) {
    let users = await User.findAll();
    if (users.status) {
      res.status(200).json({ success: true, values: users.values });
    } else {
      res.status(404).json({ success: false, message: users.err });
    }
  }

  async findUser(req, res) {
    let id = parseInt(req.params.id);
    if (!Number.isInteger(id)) {
      return res
        .status(400)
        .json({ success: false, message: "Parâmetros inválidos." });
    } else {
      let user = await User.findById(id);
      if (user.status === undefined) {
        res
          .status(404)
          .json({ success: false, message: "Usuário não encontrado." });
      } else if (!user.status) {
        res.status(404).json({ success: false, message: user.err });
      } else {
        res.status(200).json({ success: true, message: user.values });
      }
    }
  }

  async remove(req, res) {
    let id = parseInt(req.params.id);
    if (!Number.isInteger(id)) {
      return res
        .status(400)
        .json({ success: false, message: "Parâmetro inválido." });
    } else {
      let result = await User.delete(id);
      if (result.status) {
        res
          .status(200)
          .json({ success: result.status, message: result.message });
      } else {
        res.status(406).json({ success: result.status, message: result.err });
      }
    }
  }

  async editUser(req, res) {
    let id = parseInt(req.params.id);
    let { username, email, funcao } = req.body;
    if (!Number.isInteger(id)) {
      return res
        .status(400)
        .json({ success: false, message: "Parâmetro inválido." });
    } else {
      let result = await User.update(id, username, email, funcao);
      if (result.status) {
        res
          .status(200)
          .json({ success: result.status, message: result.message });
      } else {
        res.status(406).json({ success: result.status, message: result.err });
      }
    }
  }

  async login(req, res) {
    let { email, password } = req.body;

    try {
      let user = await User.findByEmail(email);

      // Verifica se o usuário foi encontrado
      if (user.status === undefined) {
        return res
          .status(404)
          .json({ success: false, message: "Usuário não encontrado." });
      } else if (!user.status) {
        return res.status(400).json({ success: false, message: user.err });
      }

      // Verifica se a senha está correta
      let checkPassword = await bcrypt.compare(password, user.values.senha);

      // Senha incorreta
      if (!checkPassword) {
        return res
          .status(406)
          .json({ success: false, message: "Senha inválida." });
      }

      // Gera token para o usuário
      if (!process.env.JWT_SECRET) {
        throw new Error("JWT_SECRET não está definido no ambiente.");
      }

      let token = jwt.sign(
        { email: user.values.email, funcao: user.values.funcao },
        process.env.JWT_SECRET,
        { expiresIn: "1h" }
      );

      res.status(200).json({ success: true, token: token });
    } catch (error) {
      console.error("Erro no login:", error.message);
      res
        .status(500)
        .json({ success: false, message: "Erro interno no servidor." });
    }
  }
}

module.exports = new UsersController();
