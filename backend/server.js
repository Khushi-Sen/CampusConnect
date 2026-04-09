const app = require('./app');
const connectDB = require('./config/db');
// const facultyRoutes = require("./routes/facultyRoutes");

require('dotenv').config();

// app.use("/api/faculty", facultyRoutes);
connectDB();

const PORT = process.env.PORT || 5000;

app.listen(PORT, "0.0.0.0", () => {
  console.log(`Server running on port ${PORT}`);
}); 