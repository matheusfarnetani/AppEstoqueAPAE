const express = require("express");
const api = express();
const routes = require("./routes/routes");

api.use(express.urlencoded({ extended: false }));
api.use(express.json());

api.use("/", routes);

module.exports = api;
