const knex = require("../data/connection.js");

class BaseModel {
  constructor(tableName) {
    this.tableName = tableName;
  }

  // Set user session
  async setUserSession(trx, user_id) {
    if (!user_id) {
      console.error("User ID is undefined when setting session variable.");
    } else {
      console.log("Setting session variable for user_id:", user_id);
    }

    await trx.raw("SET @user_id = ?", [user_id]);
  }

  // Create new record with transaction
  async create(data, user_id) {
    const trx = await knex.transaction();
    try {
      await this.setUserSession(trx, user_id); // Set session
      const result = await trx(this.tableName).insert(data);
      await trx.commit();
      return { status: true, id: result[0] };
    } catch (error) {
      await trx.rollback();
      console.error("Error during create:", error.message); // Debugging log
      return { status: false, error: error.message };
    }
  }

  // Find all records
  async findAll(columns = ["*"]) {
    try {
      const result = await knex(this.tableName).select(columns);
      return { status: true, values: result };
    } catch (error) {
      console.error("Error during findAll:", error.message); // Debugging log
      return { status: false, error: error.message };
    }
  }

  // Find one record by ID
  async findById(id, columns = ["*"]) {
    try {
      const result = await knex(this.tableName)
        .select(columns)
        .where({ id })
        .first();
      if (!result) {
        return {
          status: false,
          message: `${this.tableName.slice(0, -1)} not found`,
        };
      }
      return { status: true, values: result };
    } catch (error) {
      console.error("Error during findById:", error.message); // Debugging log
      return { status: false, error: error.message };
    }
  }

  // Update record by ID with transaction
  async update(id, data, user_id) {
    const trx = await knex.transaction();
    try {
      // Debugging: Log user_id being set for session
      console.log("Setting session for user_id:", user_id);

      await this.setUserSession(trx, user_id); // Set session

      // Debugging: Log the updated fields
      console.log("Updating:", { id, data });

      const result = await trx(this.tableName).where({ id }).update(data);
      await trx.commit();

      if (result === 0) {
        return {
          status: false,
          message: `${this.tableName.slice(0, -1)} not found`,
        };
      }
      return {
        status: true,
        message: `${this.tableName.slice(0, -1)} updated successfully`,
      };
    } catch (error) {
      await trx.rollback();
      console.error("Error during update:", error.message); // Debugging log
      return { status: false, error: error.message };
    }
  }

  // Delete record by ID with transaction
  async delete(id, user_id) {
    const trx = await knex.transaction();
    try {
      // Set the user session with user_id
      await this.setUserSession(trx, user_id);

      // Debugging: Log the ID to be deleted and user_id
      console.log("Deleting record with ID:", id);
      console.log("User ID for session:", user_id);

      const result = await trx(this.tableName).where({ id }).del(); // Delete the record
      await trx.commit();

      if (result === 0) {
        return {
          status: false,
          message: `${this.tableName.slice(0, -1)} not found`,
        };
      }
      return {
        status: true,
        message: `${this.tableName.slice(0, -1)} deleted successfully`,
      };
    } catch (error) {
      await trx.rollback();
      console.error("Error during delete:", error.message); // Debugging log
      return { status: false, error: error.message };
    }
  }
}

module.exports = BaseModel;
