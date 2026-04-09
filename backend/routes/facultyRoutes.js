const express = require("express");
const router = express.Router();
const Faculty = require("../models/Faculty.js");

// 🔍 GET faculty by ID
router.get("/:id", async (req, res) => {
  try {
    const faculty = await Faculty.findOne({
      facultyId: req.params.id,
    });

    if (!faculty) {
      return res.status(404).json({ message: "Not found" });
    }

    res.json(faculty);
  } catch (err) {
    res.status(500).json({ message: "Error" });
  }
});

module.exports = router;