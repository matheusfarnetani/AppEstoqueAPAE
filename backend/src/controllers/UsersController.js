require("dotenv").config();
var bcrypt = require("bcryptjs");
var jwt = require("jsonwebtoken");
var User = require("../models/Users.js");

class UsersController {
  async create(req, res) {
    const user_id = req.user_id; // Obtain user_id from middleware
    const { username, email, password, funcao } = req.body;

    const result = await User.new(username, email, password, funcao, user_id);
    if (result.status) {
      res
        .status(200)
        .json({ success: true, message: "Usuário cadastrado com sucesso!", id: result.id });
    } else {
      res.status(400).json({ success: false, message: result.err });
    }
  }

  async findAll(req, res) {
    const users = await User.findAll(["id", "username", "email", "funcao"]);
    if (users.status) {
      res.status(200).json({ success: true, values: users.values });
    } else {
      res.status(404).json({ success: false, message: users.err });
    }
  }

  async findById(req, res) {
    const id = parseInt(req.params.id);
    if (!Number.isInteger(id)) {
      return res
        .status(400)
        .json({ success: false, message: "Parâmetro inválido." });
    }

    const user = await User.findById(id);
    if (!user.status) {
      res
        .status(404)
        .json({ success: false, message: user.message || user.err });
    } else {
      res.status(200).json({ success: true, message: user.values });
    }
  }

  async delete(req, res) {
    const user_id = req.user_id; // Obtain user_id from middleware
    const id = parseInt(req.params.id);

    if (!Number.isInteger(id)) {
      return res
        .status(400)
        .json({ success: false, message: "Parâmetro inválido." });
    }

    const result = await User.delete(id, user_id); // Delete using BaseModel method
    if (result.status) {
      res.status(200).json({ success: true, message: result.message });
    } else {
      res.status(406).json({ success: false, message: result.err });
    }
  }

  async update(req, res) {
    const user_id = req.user_id; // Extracted from middleware
    const id = parseInt(req.params.id); // User ID to update
    const { username, email, funcao } = req.body; // Fields to update

    if (!Number.isInteger(id)) {
      return res
        .status(400)
        .json({ success: false, message: "Parâmetro inválido." });
    }

    // Debugging: Log user_id and id to be updated
    console.log("User ID from middleware:", user_id);
    console.log("Updating user with ID:", id);

    // Pass user_id to the User.update method
    const result = await User.update(id, { username, email, funcao }, user_id);

    if (result.status) {
      res.status(200).json({ success: true, message: result.message });
    } else {
      res.status(400).json({ success: false, message: result.err });
    }
  }
  async login(req, res) {
    const { email, password } = req.body;

    try {
      const user = await User.findByEmail(email);
      if (!user.status) {
        return res
          .status(404)
          .json({ success: false, message: user.message || user.err });
      }

      // Debugging: Log user values to check if id is present
      console.log("User values in login:", user.values);

      const checkPassword = await bcrypt.compare(password, user.values.senha);
      if (!checkPassword) {
        return res
          .status(406)
          .json({ success: false, message: "Senha inválida." });
      }

      // Ensure user ID is included in JWT token
      const token = jwt.sign(
        {
          id: user.values.id, // Ensure user.id exists
          email: user.values.email,
          funcao: user.values.funcao,
        },
        process.env.JWT_SECRET,
        { expiresIn: "1h" }
      );

      res.status(200).json({ success: true, token: token , id: user.values.id, username: user.values.username, email: user.values.email, funcao: user.values.funcao});
    } catch (error) {
      console.error("Login error:", error.message);
      res
        .status(500)
        .json({ success: false, message: "Erro interno no servidor." });
    }
  }
}

module.exports = new UsersController();
