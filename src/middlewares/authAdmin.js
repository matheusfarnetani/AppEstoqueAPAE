require("dotenv").config();
const jwt = require("jsonwebtoken");

module.exports = function (req, res, next) {
  const authToken = req.headers["authorization"];

  // Verifica se o token de autorização está presente
  if (!authToken) {
    return res.status(401).json({
      success: false,
      message: "Token de autenticação não fornecido.",
    });
  }

  // Verifica se o token segue o formato "Bearer <token>"
  const bearerToken = authToken.split(" ");
  if (bearerToken.length !== 2 || bearerToken[0] !== "Bearer") {
    return res.status(400).json({
      success: false,
      message: "Formato do token de autenticação inválido.",
    });
  }

  const jwtToken = bearerToken[1];

  try {
    // Verifica e decodifica o token JWT
    const decoded = jwt.verify(jwtToken, process.env.JWT_SECRET);

    // Verifica se a função do usuário é "administrador"
    if (decoded.funcao === "administrador") {
      return next(); // Usuário autorizado, segue para a próxima função
    } else {
      return res.status(403).json({
        success: false,
        message:
          "Usuário não autorizado. Somente administradores podem acessar.",
      });
    }
  } catch (err) {
    // Token inválido ou outro erro
    return res.status(403).json({
      success: false,
      message: "Token de autenticação inválido ou expirado.",
    });
  }
};
