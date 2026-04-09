const Food = require('../models/Food');

// GET ALL FOOD ITEMS
exports.getFood = async (req, res) => {
  try {
    const items = await Food.find();
    res.json(items);
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
};