const express = require("express");
const router = express.Router();
const authMiddleware = require("../middlewares/authMiddleware.js");
const EstoqueEntradaController = require("../controllers/EstoqueEntradaController.js");

// Add new stock entry
router.post("/create", authMiddleware(), EstoqueEntradaController.create);

// Get all stock entries
router.get("/", authMiddleware(), EstoqueEntradaController.findAll);

// Get stock entry by ID
router.get("/:id", authMiddleware(), EstoqueEntradaController.findById);

// Update stock entry by ID
router.put("/:id", authMiddleware(), EstoqueEntradaController.update);

// Delete stock entry by ID
router.delete("/:id", authMiddleware(), EstoqueEntradaController.delete);

module.exports = router;
