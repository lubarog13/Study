const express = require('express')
const router = express.Router();
const shopController = require('../controllers/products')


router.get('/', shopController.getIndex)
router.get('/products', shopController.getProducts);
router.get('/products/:productId', shopController.getProduct)
router.get('/card', shopController.getCard);
router.post('/card', shopController.postCard);
router.get('/orders', shopController.getOrders);
router.get('/checkout', shopController.getCheckout);
router.post('/cart-delete-item', shopController.deleteCartItem);
router.post('/create-order', shopController.postOrder);
module.exports = router
