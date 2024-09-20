const BaseModel = require("./BaseModel.js");

class Endereco extends BaseModel {
  constructor() {
    super("endereco"); // Set the table name for the model
  }

  // Custom create method for Endereco (call BaseModel's create method)
  async create(
    tipo,
    logradouro,
    numero,
    complemento,
    bairro,
    cidade,
    estado,
    cep,
    user_id // Pass user_id to set session variable
  ) {
    const data = {
      tipo,
      logradouro,
      numero,
      complemento,
      bairro,
      cidade,
      estado,
      cep,
    };

    try {
      // Call the create method from BaseModel to avoid recursion
      return await super.create(data, user_id); // Use "super.create" to call BaseModel's method
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Custom update method for Endereco
  async update(
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
  ) {
    const updatedFields = {
      tipo,
      logradouro,
      numero,
      complemento,
      bairro,
      cidade,
      estado,
      cep,
    };

    // Remove undefined fields
    Object.keys(updatedFields).forEach((key) => {
      if (!updatedFields[key]) delete updatedFields[key];
    });

    try {
      // Call the update method from BaseModel to avoid recursion
      return await super.update(id, updatedFields, user_id); // Use "super.update" to call BaseModel's method
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // The other methods (findAll, findById, delete) are inherited from BaseModel
}

module.exports = new Endereco();
