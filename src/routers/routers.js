const express = require("express");
const router = express.Router();
const UsersController = require("../controllers/UsersController.js");
const authAdmin = require("../middlewares/authAdmin.js");

router.post("/user", UsersController.create);
router.post("/login", UsersController.login);

router.get("/users", authAdmin, UsersController.findAll);
router.get("/user/:id", authAdmin, UsersController.findUser);

router.delete("/user/:id", authAdmin, UsersController.remove);

router.put("/user/:id", authAdmin, UsersController.editUser);

router.all("*", (req, res) => {
  res.status(404).send("404. Página não encontrada.");
});

module.exports = router;
