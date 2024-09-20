const knex = require("./connection"); // Adjust the path as necessary to your database connection
const bcrypt = require("bcryptjs");

async function createFirstUser() {
  // Define the first user's details
  const username = "Admin";
  const email = "admin@app.com";
  const password = "admin";
  const funcao = "administrador";

  // Hash the password
  const salt = bcrypt.genSaltSync(10);
  const hashedPassword = bcrypt.hashSync(password, salt);

  try {
    // Check if the user already exists
    const existingUser = await knex("usuarios").where({ email }).first();
    if (existingUser) {
      console.log("Admin user already exists.");
      return;
    }

    // Insert the new user into the database
    await knex("usuarios").insert({
      username: username,
      email: email,
      senha: hashedPassword, // Store the hashed password
      funcao: funcao
    });

    console.log("Admin user created successfully!");
  } catch (error) {
    console.error("Error creating first user:", error.message);
  } finally {
    knex.destroy(); // Close the database connection
  }
}

createFirstUser();
