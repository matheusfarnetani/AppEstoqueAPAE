const express = require("express");
const router = express.Router();
const authMiddleware = require("../middlewares/authMiddleware.js");
const InsumosController = require("../controllers/InsumosController.js");

// Create a new insumo
router.post("/create", authMiddleware(), InsumosController.create);

// Get all insumos
router.get("/", authMiddleware(), InsumosController.findAll);

// Get insumo by ID
router.get("/:id", authMiddleware(), InsumosController.findById);

// Update insumo by ID
router.put("/:id", authMiddleware(), InsumosController.update);

// Delete insumo by ID
router.delete("/:id", authMiddleware("administrador"), InsumosController.delete);

module.exports = router;
