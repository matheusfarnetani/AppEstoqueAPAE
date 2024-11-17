const express = require("express");
const api = express();
const routes = require("./routes/routes");
const cors = require("cors");

const corsOptions = {
  origin: "*", // Allow all origins
//   origin: ['https://your-app.com', 'http://localhost:4200'],
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"], // Allowed HTTP methods
  allowedHeaders: ["Content-Type", "Authorization"], // Allowed headers
};

api.use(express.urlencoded({ extended: false }));
api.use(express.json());

api.use("/api", routes);
api.use(cors(corsOptions));

module.exports = api;
