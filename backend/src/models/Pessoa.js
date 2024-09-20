const knex = require("../data/connection.js");
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

  // Get all details for a Pessoa, including Endereco and Telefones
  async getPessoaWithDetails(id) {
    try {
      // Fetch the basic pessoa details
      const pessoa = await knex("pessoas").where({ id }).first();
      if (!pessoa) {
        return { status: false, message: "Pessoa not found." };
      }

      // Fetch the associated Endereco
      const endereco = await this.getEndereco(pessoa.endereco_id);

      // Fetch the associated Telefones
      const telefones = await this.getTelefones(id);

      // Return the full details, including endereco and telefones
      return {
        status: true,
        pessoa: pessoa,
        endereco: endereco,
        telefones: telefones,
      };
    } catch (err) {
      return { status: false, message: err.message };
    }
  }

  // Get the Endereco associated with a Pessoa
  async getEndereco(endereco_id) {
    try {
      const endereco = await knex("endereco")
        .where({ id: endereco_id })
        .first();
      return endereco || null;
    } catch (err) {
      console.error("Error fetching endereco:", err.message);
      return null;
    }
  }

  // Get all Telefones associated with a Pessoa
  async getTelefones(pessoa_id) {
    try {
      // Fetch all telefones related to the pessoa via pessoa_has_telefone
      const telefones = await knex("pessoa_has_telefone")
        .join("telefone", "pessoa_has_telefone.telefone_id", "=", "telefone.id")
        .where("pessoa_has_telefone.pessoa_id", pessoa_id)
        .select("telefone.*");

      return telefones || [];
    } catch (err) {
      console.error("Error fetching telefones:", err.message);
      return [];
    }
  }
}

module.exports = new Pessoa();
