const Visitor = require('../models/Visitor.js');
const { v4: uuidv4 } = require('uuid');

// CREATE VISITOR (GENERATE QR)
exports.createVisitor = async (req, res) => {
  try {
    const { visitorName, hostName, date } = req.body;

    const qrCode = uuidv4();

    const visitor = await Visitor.create({
      visitorName,
      hostName,
      date,
      qrCode,
    });

    res.status(201).json(visitor);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};

// VALIDATE QR
exports.validateVisitor = async (req, res) => {
  try {
    const { qrCode } = req.params;

    const visitor = await Visitor.findOne({ qrCode });

    if (!visitor) {
      return res.status(404).json({ message: "Invalid QR" });
    }

    visitor.status = "Approved";
    await visitor.save();

    res.json(visitor);
  } catch (error) {
    res.status(500).json({ error: error.message });
  }
};