// Define as rotas CRUD para Endereços

const express = require("express");
const router = express.Router();
const authMiddleware = require("../middlewares/authMiddleware.js")

const EnderecosController = require("../controllers/EnderecosController.js");

// Create Endereços
router.post("/create", authMiddleware(), EnderecosController.create);

// Read Endereços
router.get("/", authMiddleware(), EnderecosController.findAll);
router.get("/:id", authMiddleware(), EnderecosController.findById);

// Update Endereços
router.put("/:id", authMiddleware(), EnderecosController.update);

// Delete Endereços
router.delete("/:id", authMiddleware("administrador"), EnderecosController.delete);

module.exports = router;
