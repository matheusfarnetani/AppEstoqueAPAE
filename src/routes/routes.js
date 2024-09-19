// Define toda a estrutura de rotas.

const express = require("express");
const router = express.Router();

// Middlewares
// const authMiddleware = require("../middlewares/authMiddleware.js");

// Routers
const routerUsers = require("./rt_users.js");
const routerEnderecos = require("./rt_enderecos.js");
const routerTelefone = require("./rt_telefone.js");
const routerPessoas = require("./rt_pessoas.js");
const routerDoacoes = require("./rt_doacoes.js");
const routerPedidos = require("./rt_pedidos.js");

// Controllers
const UsersController = require("../controllers/UsersController");

// Free routes
router.post("/login", UsersController.login);

// API
router.use("/api/users", routerUsers);
router.use("/api/enderecos", routerEnderecos);
router.use("/api/telefones", routerTelefone);
router.use("/api/pessoas", routerPessoas);
router.use("/api/doacoes", routerDoacoes);
router.use("/api/pedidos", routerPedidos);

// Custom 404
router.all("*", (req, res) => {
  res.status(404).send("404. Página não encontrada.");
});

module.exports = router;
