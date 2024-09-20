const BaseModel = require("./BaseModel.js"); // Inherit from BaseModel

class Telefone extends BaseModel {
  constructor() {
    super("telefone"); // Define the table name
  }

  // Custom create method for telefone
  async create(tipo, ddi, ddd, numero, user_id) {
    const data = {
      tipo,
      ddi,
      ddd,
      numero,
    };

    try {
      // Use BaseModel's create method
      return await super.create(data, user_id);
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  // Custom update method for telefone
  async update(id, tipo, ddi, ddd, numero, user_id) {
    const updatedFields = {
      tipo,
      ddi,
      ddd,
      numero,
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

  // Other methods (findAll, findById, delete) will be inherited from BaseModel
}

module.exports = new Telefone();
