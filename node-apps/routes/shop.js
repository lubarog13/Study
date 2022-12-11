const express = require('express')
const router = express.Router();
const shopController = require('../controllers/products')


router.get('/', shopController.getIndex)
router.get('/products', shopController.getProducts);
router.get('/card', shopController.getCard);
router.get('/checkout', shopController.getCheckout);
module.exports = router
