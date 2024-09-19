// Define as rotas CRUD para Users

const express = require("express");
const router = express.Router();
const authMiddleware = require("../middlewares/authMiddleware.js");

const UsersController = require("../controllers/UsersController.js");

// Create Users
router.post("/create", authMiddleware(), UsersController.create);

// Read Users
router.get("/", authMiddleware(), UsersController.findAll);
router.get("/:id", authMiddleware(), UsersController.findById);

// Update Users
router.put("/:id", authMiddleware(), UsersController.update);

// Delete Users
router.delete("/:id", authMiddleware("administrador"), UsersController.delete);

module.exports = router;
