const express = require("express");
const router = express.Router();
const authMiddleware = require("../middlewares/authMiddleware");
const ValoresNutricionaisController = require("../controllers/ValoresNutricionaisController");

// Update valores_nutricionais for an insumo
router.put("/:insumos_id", authMiddleware(), ValoresNutricionaisController.update);

// Get all valores_nutricionais
router.get("/", authMiddleware(), ValoresNutricionaisController.findAll);

// Get valores_nutricionais by insumos_id
router.get("/:insumos_id", authMiddleware(), ValoresNutricionaisController.findByInsumo);

// Delete valores_nutricionais by insumos_id (if needed)
router.delete("/:insumos_id", authMiddleware("administrador"), ValoresNutricionaisController.delete);

module.exports = router;
