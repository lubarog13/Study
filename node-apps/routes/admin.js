const express = require('express');
const path = require('path')
const router = express.Router();
const productsContoller = require('../controllers/products')


router.get('/add-product', productsContoller)

router.post('/add-product', productsContoller.postAddProduct)

module.exports = router;