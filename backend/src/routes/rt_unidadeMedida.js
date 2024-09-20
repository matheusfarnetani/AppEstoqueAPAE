const express = require("express");
const router = express.Router();
const authMiddleware = require("../middlewares/authMiddleware.js");
const UnidadeMedidaController = require("../controllers/UnidadeMedidaController.js");

// Create a new unidade_medida
router.post("/create", authMiddleware(), UnidadeMedidaController.create);

// Get all unidades_medida
router.get("/", authMiddleware(), UnidadeMedidaController.findAll);

// Get unidade_medida by ID
router.get("/:id", authMiddleware(), UnidadeMedidaController.findById);

// Update unidade_medida by ID
router.put("/:id", authMiddleware(), UnidadeMedidaController.update);

// Delete unidade_medida by ID
router.delete("/:id", authMiddleware("administrador"), UnidadeMedidaController.delete);

module.exports = router;
