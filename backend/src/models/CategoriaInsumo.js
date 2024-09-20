const BaseModel = require("./BaseModel.js");

class CategoriaInsumo extends BaseModel {
  constructor() {
    super("categoria_insumos"); // Define the table name
  }

  // Additional methods specific to CategoriaInsumo can be added here if needed.
}

module.exports = new CategoriaInsumo();
