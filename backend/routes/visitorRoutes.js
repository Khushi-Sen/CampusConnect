const express = require('express');
const router = express.Router();

const {
  createVisitor,
  validateVisitor,
} = require('../controllers/visitorController');

router.post('/create', createVisitor);
router.get('/validate/:qrCode', validateVisitor);

module.exports = router;