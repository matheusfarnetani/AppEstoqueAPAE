// Define toda a estrutura de rotas.

const express = require("express");
const router = express.Router();

// Controllers
const UsersController = require("../controllers/UsersController");

// Middlewares
const authAdmin = require("../middlewares/authAdmin.js");

// Routers
const routerUsers = require("./rt_users.js");
const routerEnderecos = require("./rt_enderecos.js");

// Rotas Comuns
router.post("/login", UsersController.login);

// API
router.use("/api/users", authAdmin, routerUsers);
router.use("/api/enderecos", authAdmin, routerEnderecos);

router.all("*", (req, res) => {
  res.status(404).send("404. Página não encontrada.");
});

module.exports = router;
