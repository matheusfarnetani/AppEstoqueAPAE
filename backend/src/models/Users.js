const bcrypt = require("bcryptjs");
const knex = require("../data/connection.js");
const BaseModel = require("./BaseModel.js");

class User extends BaseModel {
  constructor() {
    super("usuarios"); // Pass the table name
  }

  // Override the 'create' method to handle password hashing and unique checks
  async new(username, email, password, funcao, user_id) {
    let salt = bcrypt.genSaltSync(10);
    let hashedPassword = bcrypt.hashSync(password, salt);

    // Check if email or username already exists
    let existingUser = await knex(this.tableName)
      .where({ email })
      .orWhere({ username })
      .first();

    if (existingUser) {
      return {
        status: false,
        err: "E-mail ou nome de usuário já cadastrado.",
      };
    }

    // Use the BaseModel's 'create' method to insert the new user
    return await this.create(
      {
        username,
        email,
        senha: hashedPassword,
        funcao,
      },
      user_id
    );
  }

  // Find a user by their email (specific to users)
  async findByEmail(email) {
    try {
      // Make sure to select the 'id' along with other fields
      let user = await knex(this.tableName)
        .select(["id", "username", "email", "senha", "funcao"]) // Include 'id' here
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
