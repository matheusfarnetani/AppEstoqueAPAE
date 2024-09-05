const knex = require("../data/connection");
const bcrypt = require("bcryptjs");

class User {
  async new(username, email, password, funcao) {
    let salt = bcrypt.genSaltSync(10);
    let hashedPassword = bcrypt.hashSync(password, salt);

    try {
      // Verifica se o email ou username já existe
      let existingUser = await knex("usuarios")
        .where({ email })
        .orWhere({ username })
        .first();
      if (existingUser) {
        return {
          status: false,
          err: "E-mail ou nome de usuário já cadastrado.",
        };
      }

      await knex("usuarios").insert({
        username,
        email,
        senha: hashedPassword,
        funcao,
      });

      return { status: true, message: "Usuário cadastrado com sucesso!" };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  async findAll() {
    try {
      let users = await knex("usuarios").select([
        "id",
        "username",
        "email",
        "funcao",
      ]);
      return { status: true, values: users };
    } catch (err) {
      console.error(err);
      return { status: false, err: err.message };
    }
  }

  async findById(id) {
    try {
      let user = await knex("usuarios")
        .select(["id", "username", "email", "funcao"])
        .where({ id })
        .first();
      return user
        ? { status: true, values: user }
        : { status: false, message: "Usuário inexistente!" };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  async delete(id) {
    let user = await this.findById(id);

    if (user.status) {
      try {
        await knex("usuarios").where({ id }).del();
        return { status: true, message: "Usuário excluído com sucesso!" };
      } catch (err) {
        return { status: false, err: err.message };
      }
    } else {
      return {
        status: false,
        err: "Usuário não existe, portanto não pode ser excluído.",
      };
    }
  }

  async update(id, username, email, funcao) {
    let user = await this.findById(id);

    if (user.status) {
      let updatedFields = {};
      if (username) updatedFields.username = username;
      if (email) updatedFields.email = email;
      if (funcao) updatedFields.funcao = funcao;

      if (Object.keys(updatedFields).length === 0) {
        return { status: false, err: "Nenhuma alteração foi fornecida." };
      }

      try {
        await knex("usuarios").where({ id }).update(updatedFields);
        return { status: true, message: "Usuário editado com sucesso!" };
      } catch (err) {
        return { status: false, err: err.message };
      }
    } else {
      return {
        status: false,
        err: "Usuário não existe, portanto não pode ser editado.",
      };
    }
  }

  async findByEmail(email) {
    try {
      let user = await knex("usuarios")
        .select(["email", "senha", "funcao"])
        .where({ email })
        .first();
      return user
        ? { status: true, values: user }
        : { status: false, message: "E-mail não encontrado." };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }
}

module.exports = new User();
