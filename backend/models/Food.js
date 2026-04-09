const mongoose = require('mongoose');

const foodSchema = new mongoose.Schema({
  shopName: String,   
  name: String,
  price: Number,
});

module.exports = mongoose.model('Food', foodSchema);