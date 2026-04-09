const express = require('express');
const router = express.Router();
const { getFood } = require('../controllers/foodController');

router.get('/', getFood);

module.exports = router;