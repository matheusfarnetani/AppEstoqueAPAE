const express = require("express");
const router = express.Router();
const authMiddleware = require("../middlewares/authMiddleware.js");
const CategoriaInsumoController = require("../controllers/CategoriaInsumoController.js");

// Create a new categoria_insumo
router.post("/create", authMiddleware(), CategoriaInsumoController.create);

// Get all categoria_insumos
router.get("/", authMiddleware(), CategoriaInsumoController.findAll);

// Get categoria_insumo by ID
router.get("/:id", authMiddleware(), CategoriaInsumoController.findById);

// Update categoria_insumo by ID
router.put("/:id", authMiddleware(), CategoriaInsumoController.update);

// Delete categoria_insumo by ID
router.delete("/:id", authMiddleware("administrador"), CategoriaInsumoController.delete);

module.exports = router;
