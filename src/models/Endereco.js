const knex = require("../data/connection");

class Endereco {
  async create(
    tipo,
    logradouro,
    numero,
    complemento,
    bairro,
    cidade,
    estado,
    cep
  ) {
    try {
      const [id] = await knex("endereco").insert({
        tipo,
        logradouro,
        numero,
        complemento,
        bairro,
        cidade,
        estado,
        cep,
      });

      return { status: true, id: id };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  async findAll() {
    try {
      const enderecos = await knex("endereco").select("*");
      return { status: true, values: enderecos };
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  async findById(id) {
    try {
      const endereco = await knex("endereco").where({ id }).first();
      if (endereco) {
        return { status: true, values: endereco };
      } else {
        return { status: false, message: "Endereço não encontrado." };
      }
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  async update(
    id,
    tipo,
    logradouro,
    numero,
    complemento,
    bairro,
    cidade,
    estado,
    cep
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

    Object.keys(updatedFields).forEach((key) => {
      if (!updatedFields[key]) delete updatedFields[key];
    });

    try {
      const affectedRows = await knex("endereco")
        .where({ id })
        .update(updatedFields);

      if (affectedRows) {
        return { status: true, message: "Endereço atualizado com sucesso!" };
      } else {
        return { status: false, message: "Endereço não encontrado." };
      }
    } catch (err) {
      return { status: false, err: err.message };
    }
  }

  async delete(id) {
    try {
      const affectedRows = await knex("endereco").where({ id }).del();

      if (affectedRows) {
        return { status: true, message: "Endereço excluído com sucesso!" };
      } else {
        return { status: false, message: "Endereço não encontrado." };
      }
    } catch (err) {
      return { status: false, err: err.message };
    }
  }
}

module.exports = new Endereco();
