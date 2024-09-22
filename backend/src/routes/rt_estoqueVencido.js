const express = require("express");
const router = express.Router();
const authMiddleware = require("../middlewares/authMiddleware");
const EstoqueVencidoController = require("../controllers/EstoqueVencidoController");

// Fetch all non-discarded expired items
router.get("/", authMiddleware(), EstoqueVencidoController.findAllNonDescartados);

// Fetch all discarded expired items
router.get("/descartados", authMiddleware(), EstoqueVencidoController.findAllDescartados);

// Fetch non-discarded expired item by ID
router.get("/:id", authMiddleware(), EstoqueVencidoController.findByIdNonDescartado);

// Fetch discarded expired item by ID
router.get("/descartados/:id", authMiddleware(), EstoqueVencidoController.findByIdDescartado);

// Fetch non-discarded expired items by Insumo ID
router.get("/insumo/:insumos_id", authMiddleware(), EstoqueVencidoController.findByInsumoIdNonDescartado);

// Fetch discarded expired items by Insumo ID
router.get("/descartados/insumo/:insumos_id", authMiddleware(), EstoqueVencidoController.findByInsumoIdDescartado);

// Update 'descartado' field for an expired item
router.put("/:id", authMiddleware(), EstoqueVencidoController.updateDescartado);

module.exports = router;
