// Test script to verify database connection and basic functionality
require("dotenv").config();
const sequelize = require("./config/database");
const User = require("./models/User");

async function testDatabase() {
  try {
    console.log("Testing database connection...");

    // Test connection
    await sequelize.authenticate();
    console.log("✅ Database connection successful");

    // Sync models (in development)
    if (process.env.NODE_ENV === "development") {
      await sequelize.sync({ force: false });
      console.log("✅ Database synchronization successful");
    }

    // Test User model
    console.log("✅ User model loaded successfully");

    console.log("\n🎉 All tests passed! Your Node.js MySQL app is ready.");
    console.log("\nNext steps:");
    console.log("1. Update .env with your MySQL credentials");
    console.log("2. Run: npm run migrate");
    console.log("3. Run: npm run dev");
    console.log("4. Test the API at http://localhost:3000");
  } catch (error) {
    console.error("❌ Test failed:", error);
    process.exit(1);
  } finally {
    await sequelize.close();
  }
}

testDatabase();
