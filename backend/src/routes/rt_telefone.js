const express = require("express");
const router = express.Router();
const TelefonesController = require("../controllers/TelefonesController.js");
const authMiddleware = require("../middlewares/authMiddleware.js"); // Auth middleware for checking user roles

// Create a new phone
router.post("/create", authMiddleware(), TelefonesController.create);

// Get all phones
router.get("/", authMiddleware(), TelefonesController.findAll);

// Get a phone by ID
router.get("/:id", authMiddleware(), TelefonesController.findById);

// Update a phone by ID
router.put("/:id", authMiddleware(), TelefonesController.update);

// Delete a phone by ID
router.delete("/:id", authMiddleware("administrador"), TelefonesController.delete);

module.exports = router;
