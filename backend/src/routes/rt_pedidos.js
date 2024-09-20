const express = require("express");
const router = express.Router();
const PedidosController = require("../controllers/PedidosController.js");
const authMiddleware = require("../middlewares/authMiddleware.js");

// Create a new pedido
router.post("/create", authMiddleware(), PedidosController.create);

// Link a doacao to a pedido
router.post("/linkDoacao", authMiddleware(), PedidosController.linkDoacao);

// Unlink a doacao from a pedido
router.post("/unlinkDoacao", authMiddleware(), PedidosController.unlinkDoacao);

// Get all pedidos
router.get("/", authMiddleware(), PedidosController.findAll);

// Get a specific pedido by ID
router.get("/:id", authMiddleware(), PedidosController.findById);

// Fetch all doacoes related to a specific pedido
router.get("/:pedido_id/doacoes", authMiddleware(), PedidosController.findDoacoesByPedido);

// Update a pedido by ID
router.put("/:id", authMiddleware(), PedidosController.update);

// Delete a pedido by ID
router.delete("/:id", authMiddleware("administrador"), PedidosController.delete);

module.exports = router;
