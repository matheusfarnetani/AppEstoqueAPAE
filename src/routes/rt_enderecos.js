// Define as rotas CRUD para Endereços

const express = require("express");
const router = express.Router();

const EnderecosController = require("../controllers/EnderecosController");
const {
  createEnderecoValidator,
  updateEnderecoValidator,
} = require("../validators/val_enderecos");
const validate = require("../middlewares/validate");

// Create Endereços
router.post(
  "/create",
  createEnderecoValidator,
  validate,
  EnderecosController.create
);

// Read Endereços
router.get("/", EnderecosController.findAll);
router.get("/:id", EnderecosController.findById);

// Update Endereços
router.put(
  "/:id",
  updateEnderecoValidator,
  validate,
  EnderecosController.update
);

// Delete Endereços
router.delete("/:id", EnderecosController.delete);

module.exports = router;
