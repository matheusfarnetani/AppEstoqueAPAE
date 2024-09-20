var jwt = require("jsonwebtoken");

module.exports = function (requiredRole) {
  return function (req, res, next) {
    const authToken = req.headers["authorization"];

    // Debugging: Log the received Authorization header
    console.log("Received Authorization header:", authToken);

    if (!authToken) {
      return res.status(401).json({
        success: false,
        message: "Token de autenticação não fornecido.",
      });
    }

    const bearerToken = authToken.split(" ");
    if (bearerToken.length !== 2 || bearerToken[0] !== "Bearer") {
      return res.status(400).json({
        success: false,
        message: "Formato do token de autenticação inválido.",
      });
    }

    const jwtToken = bearerToken[1];

    try {
      const decoded = jwt.verify(jwtToken, process.env.JWT_SECRET);

      // Debugging: Log the decoded JWT payload
      console.log("Decoded JWT in middleware:", decoded);

      req.user_id = decoded.id; // Ensure id is correctly extracted

      if (requiredRole && decoded.funcao !== requiredRole) {
        return res.status(403).json({
          success: false,
          message: `Usuário não autorizado. Acesso reservado a ${requiredRole}.`,
        });
      }

      next(); // Proceed to the next middleware/controller
    } catch (err) {
      console.error("JWT verification error:", err.message); // Debugging log
      return res.status(403).json({
        success: false,
        message: "Token de autenticação inválido ou expirado.",
      });
    }
  };
};
