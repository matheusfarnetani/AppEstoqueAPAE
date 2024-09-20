const { check } = require("express-validator");

// Validações para criação de um novo usuário
const createUserValidator = [
  check("username")
    .notEmpty()
    .isLength({ min: 3, max: 50 })
    .withMessage("O nome de usuário deve ter entre 3 e 50 caracteres."),
  check("email").isEmail().withMessage("O e-mail fornecido não é válido."),
  check("password")
    .isLength({ min: 6 })
    .withMessage("A senha deve ter no mínimo 6 caracteres."),
  check("funcao")
    .isIn([
      "administrador",
      "nutricionista",
      "cozinheiro",
      "professor",
      "monitor",
    ])
    .withMessage(
      "Função inválida, escolha entre: administrador, nutricionista, cozinheiro, professor, monitor."
    ),
];

// Validações para atualização de um usuário
const updateUserValidator = [
  check("username")
    .optional()
    .isLength({ min: 3, max: 50 })
    .withMessage("O nome de usuário deve ter entre 3 e 50 caracteres."),
  check("email")
    .optional()
    .isEmail()
    .withMessage("O e-mail fornecido não é válido."),
  check("funcao")
    .optional()
    .isIn([
      "administrador",
      "nutricionista",
      "cozinheiro",
      "professor",
      "monitor",
    ])
    .withMessage(
      "Função inválida, escolha entre: administrador, nutricionista, cozinheiro, professor, monitor."
    ),
];

module.exports = {
  createUserValidator,
  updateUserValidator,
};
