const express = require("express");
const router = express.Router();
const authMiddleware = require("../middlewares/authMiddleware.js");
const ItensPedidoController = require("../controllers/ItensPedidoController.js");

// Create a new item for a pedido
router.post("/create", authMiddleware(), ItensPedidoController.create);

// Get all items related to a specific pedido
router.get("/pedido/:pedidos_id", authMiddleware(), ItensPedidoController.findByPedido);

// Get a specific item by its item_id
router.get("/item/:item_id", authMiddleware(), ItensPedidoController.findById);

// Update an item for a pedido
router.put("/:id", authMiddleware(), ItensPedidoController.update);

// Delete an item from a pedido
router.delete("/:id", authMiddleware("administrador"), ItensPedidoController.delete);

module.exports = router;
