const express = require('express');
const path = require('path')
const router = express.Router();
const adminController = require('../controllers/admin')


router.get('/add-product', adminController.getAddProduct)

router.post('/add-product', adminController.postAddProduct)

router.get('/edit-product/:productId', adminController.getEditProduct);

router.get('/products', adminController.getProducts);

router.post('/edit-product', adminController.postEditProduct);

router.post('/delete-product/:productId', adminController.deleteProduct);

module.exports = router;