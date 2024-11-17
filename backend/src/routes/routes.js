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
router.use("/users", routerUsers);
router.use("/enderecos", routerEnderecos);
router.use("/telefones", routerTelefone);
router.use("/pessoas", routerPessoas);
router.use("/doacoes", routerDoacoes);
router.use("/pedidos", routerPedidos);
router.use("/itens_pedidos", routerItensPedidos);
router.use("/unidade_medida", routerUnidadeMedida);
router.use("/categoria_insumo", routerCategoriaInsumo);
router.use("/valores_nutricionais", routerValoresNutricionais);
router.use("/insumos", routerInsumos);
router.use("/estoque_entrada", routerEstoqueEntrada);
router.use("/estoque", routerEstoque);
router.use("/estoque_saida", routerEstoqueSaida);
router.use("/estoque_vencido", routerEstoqueVencido);

// Custom 404
router.all("*", (req, res) => {
  res.status(404).send("404. Página não encontrada.");
});

module.exports = router;
