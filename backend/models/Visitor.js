const mongoose = require('mongoose');

const visitorSchema = new mongoose.Schema({
  visitorName: String,
  hostName: String,
  date: String,
  qrCode: String,
  status: {
    type: String,
    enum: ['Pending', 'Approved'],
    default: 'Pending',
  },
});

module.exports = mongoose.model('Visitor', visitorSchema);