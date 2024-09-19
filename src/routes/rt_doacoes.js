const express = require("express");
const router = express.Router();
const DoacoesController = require("../controllers/DoacoesController.js");
const authMiddleware = require("../middlewares/authMiddleware.js"); // Middleware to check authentication and authorization

// Create a new donation
router.post("/create", authMiddleware(), DoacoesController.create);

// Link a pedido to a doacao
router.post("/linkPedido", authMiddleware(), DoacoesController.linkPedido);

// Unlink a pedido from a doacao
router.post("/unlinkPedido", authMiddleware(), DoacoesController.unlinkPedido);

// Get all donations
router.get("/", authMiddleware(), DoacoesController.findAll);

// Get a specific donation by ID
router.get("/:id", authMiddleware(), DoacoesController.findById);

// Fetch all pedidos related to a specific doacao
router.get("/:doacao_id/pedidos", authMiddleware(), DoacoesController.findPedidosByDoacao);

// Update a donation by ID
router.put("/:id", authMiddleware(), DoacoesController.update);

// Delete a donation by ID
router.delete("/:id", authMiddleware("administrador"), DoacoesController.delete);

module.exports = router;
