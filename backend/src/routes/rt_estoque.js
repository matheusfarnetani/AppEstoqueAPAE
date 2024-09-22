const express = require("express");
const router = express.Router();
const authMiddleware = require("../middlewares/authMiddleware.js");
const EstoqueController = require("../controllers/EstoqueController.js");

// Fetch all stock by view (fechado, aberto, vencendo_hoje)
router.get("/view/:view", authMiddleware(), EstoqueController.findByView);

// Fetch stock item by ID (uses view_estoque_completo)
router.get("/:id", authMiddleware(), EstoqueController.findById);

// Update stock by ID
router.put("/:id", authMiddleware(), EstoqueController.update);

module.exports = router;
