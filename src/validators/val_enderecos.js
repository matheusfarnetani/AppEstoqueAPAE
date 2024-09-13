const { check } = require("express-validator");

// Validações para criação de um novo endereço
const createEnderecoValidator = [
  check("tipo").optional().isString().withMessage("Tipo deve ser uma string"),
  check("logradouro")
    .notEmpty()
    .isLength({ min: 5, max: 60 })
    .withMessage("Logradouro deve ter entre 5 e 60 caracteres"),
  check("numero")
    .notEmpty()
    .isLength({ max: 10 })
    .withMessage("Número deve ter no máximo 10 caracteres"),
  check("complemento")
    .optional()
    .isLength({ max: 30 })
    .withMessage("Complemento deve ter no máximo 30 caracteres"),
  check("bairro")
    .notEmpty()
    .isLength({ min: 3, max: 60 })
    .withMessage("Bairro deve ter entre 3 e 60 caracteres"),
  check("cidade")
    .notEmpty()
    .isLength({ min: 3, max: 60 })
    .withMessage("Cidade deve ter entre 3 e 60 caracteres"),
  check("estado")
    .notEmpty()
    .isLength({ min: 2, max: 2 })
    .withMessage("Estado deve ter exatamente 2 caracteres"),
  check("cep")
    .notEmpty()
    .isLength({ min: 8, max: 8 })
    .withMessage("CEP deve ter exatamente 8 caracteres"),
];

// Validações para atualização de um endereço existente
const updateEnderecoValidator = [
  check("tipo").optional().isString().withMessage("Tipo deve ser uma string"),
  check("logradouro")
    .optional()
    .isLength({ min: 5, max: 60 })
    .withMessage("Logradouro deve ter entre 5 e 60 caracteres"),
  check("numero")
    .optional()
    .isLength({ max: 10 })
    .withMessage("Número deve ter no máximo 10 caracteres"),
  check("complemento")
    .optional()
    .isLength({ max: 30 })
    .withMessage("Complemento deve ter no máximo 30 caracteres"),
  check("bairro")
    .optional()
    .isLength({ min: 3, max: 60 })
    .withMessage("Bairro deve ter entre 3 e 60 caracteres"),
  check("cidade")
    .optional()
    .isLength({ min: 3, max: 60 })
    .withMessage("Cidade deve ter entre 3 e 60 caracteres"),
  check("estado")
    .optional()
    .isLength({ min: 2, max: 2 })
    .withMessage("Estado deve ter exatamente 2 caracteres"),
  check("cep")
    .optional()
    .isLength({ min: 8, max: 8 })
    .withMessage("CEP deve ter exatamente 8 caracteres"),
];

module.exports = {
  createEnderecoValidator,
  updateEnderecoValidator,
};
