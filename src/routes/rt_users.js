// Define as rotas CRUD para Users

const express = require("express");
const UsersController = require("../controllers/UsersController");
const router = express.Router();

// Create Users
router.post("/create", UsersController.create);

// Read Users
router.get("/", UsersController.findAll);
router.get("/:id", UsersController.findById);

// Update Users
router.put("/:id", UsersController.update);

// Delete Users
router.delete("/:id", UsersController.delete);

module.exports = router;
