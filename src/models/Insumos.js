const BaseModel = require("./BaseModel.js");

class Insumos extends BaseModel {
  constructor() {
    super("insumos"); // Define the table name
  }

  // Custom methods specific to Insumos can be added if needed
}

module.exports = new Insumos();
