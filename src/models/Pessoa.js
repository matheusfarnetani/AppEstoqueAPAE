const BaseModel = require("./BaseModel.js");

class Pessoa extends BaseModel {
  constructor() {
    super("pessoas"); // Define the table name
  }

  // Custom create method for Pessoa
  async create(
    tipo_pessoa,
    nome,
    documento,
    data_nascimento,
    email,
    endereco_id,
    user_id
  ) {
    const data = {
      tipo_pessoa,
      nome,
      documento,
      data_nascimento,
      email,
      endereco_id,
    };

    try {
      // Use BaseModel's create method
      return await super.create(data, user_id);
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Custom update method for Pessoa
  async update(
    id,
    tipo_pessoa,
    nome,
    documento,
    data_nascimento,
    email,
    endereco_id,
    user_id
  ) {
    const updatedFields = {
      tipo_pessoa,
      nome,
      documento,
      data_nascimento,
      email,
      endereco_id,
    };

    // Remove undefined fields
    Object.keys(updatedFields).forEach((key) => {
      if (!updatedFields[key]) delete updatedFields[key];
    });

    try {
      // Use BaseModel's update method
      return await super.update(id, updatedFields, user_id);
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Other methods (findAll, findById, delete) are inherited from BaseModel
}

module.exports = new Pessoa();
