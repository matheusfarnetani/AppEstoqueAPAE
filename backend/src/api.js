const express = require("express");
const cors = require("cors");
const routes = require("./routes/routes");

const api = express();

// Configure CORS
const corsOptions = {
  origin: "*", // Allow all origins
  // If you want to restrict origins, uncomment and use the following:
  // origin: ['https://your-app.com', 'http://localhost:4200'],
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"], // Allowed HTTP methods
  allowedHeaders: ["Content-Type", "Authorization"], // Allowed headers
};

// Apply middleware
api.use(cors(corsOptions)); // Apply CORS globally
api.use(express.urlencoded({ extended: false })); // Parse URL-encoded bodies
api.use(express.json()); // Parse JSON bodies

// Preflight OPTIONS request handler (optional but recommended for smooth CORS handling)
api.options("*", cors(corsOptions));

// Define routes
api.use("/api", routes);

// Export the API object
module.exports = api;
