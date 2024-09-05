const express = require("express");
const api = express();
const routers = require("./routers/routers");

api.use(express.urlencoded({ extended: false }));
api.use(express.json());

api.use("/", routers);

module.exports = api;
