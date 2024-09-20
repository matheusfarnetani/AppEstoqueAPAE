const BaseModel = require("./BaseModel.js");

class UnidadeMedida extends BaseModel {
  constructor() {
    super("unidades_medida"); // Define the table name
  }

  // Additional methods for UnidadeMedida can be added here if needed.
}

module.exports = new UnidadeMedida();
