const express = require("express");
const router = express.Router();
const authMiddleware = require("../middlewares/authMiddleware.js");
const EstoqueSaidaController = require("../controllers/EstoqueSaidaController.js");

// Fetch all stock exits
router.get("/", authMiddleware(), EstoqueSaidaController.findAll);

// Fetch stock exits by estoque_saida ID
router.get("/:id", authMiddleware(), EstoqueSaidaController.findById);

// Fetch stock exits by insumo (material) ID
router.get("/insumo/:insumos_id", authMiddleware(), EstoqueSaidaController.findByInsumoId);

module.exports = router;
