const Booking = require('../models/Booking');

// CREATE BOOKING
exports.createBooking = async (req, res) => {
  try {
    const { roomName, userName, date, time } = req.body;

    const booking = await Booking.create({
      roomName,
      userName,
      date,
      time,
    });

    res.status(201).json(booking);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};

// GET BOOKINGS
exports.getBookings = async (req, res) => {
  try {
    const data = await Booking.find();
    res.json(data);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};