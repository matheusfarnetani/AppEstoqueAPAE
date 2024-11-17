const express = require("express");
const cors = require("cors");

const app = express();

const corsOptions = {
  origin: "*", // Allow all origins
  methods: ["GET", "POST", "PUT", "DELETE", "OPTIONS"], // Allowed HTTP methods
  allowedHeaders: ["Content-Type", "Authorization"], // Allowed headers
};

app.use(cors(corsOptions)); // Apply CORS middleware
app.use(express.json()); // Parse JSON bodies

// Example route
app.post("/api/users/login", (req, res) => {
  res.json({ message: "Login successful!" });
});

// Start the server
const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
  console.log(`Server is running on port ${PORT}`);
});
