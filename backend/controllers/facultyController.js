const Faculty = require('../models/Faculty.js');

// GET ALL FACULTY
exports.getFaculty = async (req, res) => {
  try {
    const faculty = await Faculty.find();
    res.json(faculty);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};