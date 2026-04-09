const express = require('express');
const cors = require('cors');
const foodRoutes = require('./routes/foodRoutes');
const authRoutes = require('./routes/authRoutes');
const facultyRoutes = require('./routes/facultyRoutes');
const visitorRoutes = require('./routes/visitorRoutes');
const bookingRoutes = require('./routes/bookingRoutes');

const app = express();

app.use(cors());
app.use(express.json());
app.use('/api/auth', authRoutes);
app.use('/api/faculty', facultyRoutes);
app.use('/api/visitor', visitorRoutes);
app.use('/api/food', foodRoutes);
app.use('/api/booking', bookingRoutes);

app.get('/', (req, res) => {
  res.send('CampusConnect AR API Running');
});

module.exports = app;