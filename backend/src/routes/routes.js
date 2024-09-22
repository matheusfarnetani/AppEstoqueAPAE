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
const routerItensPedidos = require("./rt_itensPedidos.js");
const routerUnidadeMedida = require("./rt_unidadeMedida.js");
const routerCategoriaInsumo = require("./rt_categoriaInsumo.js");
const routerValoresNutricionais = require("./rt_valoresNutricionais.js");
const routerInsumos = require("./rt_insumos.js");
const routerEstoqueEntrada = require("./rt_estoqueEntrada.js");
const routerEstoque = require("./rt_estoque.js");
const routerEstoqueSaida = require("./rt_estoqueSaida.js");
const routerEstoqueVencido = require("./rt_estoqueVencido.js");

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
router.use("/api/itens_pedidos", routerItensPedidos);
router.use("/api/unidade_medida", routerUnidadeMedida);
router.use("/api/categoria_insumo", routerCategoriaInsumo);
router.use("/api/valores_nutricionais", routerValoresNutricionais);
router.use("/api/insumos", routerInsumos);
router.use("/api/estoque_entrada", routerEstoqueEntrada);
router.use("/api/estoque", routerEstoque);
router.use("/api/estoque_saida", routerEstoqueSaida);
router.use("/api/estoque_vencido", routerEstoqueVencido);

// Custom 404
router.all("*", (req, res) => {
  res.status(404).send("404. Página não encontrada.");
});

module.exports = router;
