const express = require('express')
const path = require('path')
const router = express.Router();
const adminData = require('./admin')
const rootdir = require('../util/path')

router.get('/',(req, res, next) => {
    const products = adminData.products
    res.render('shop', {prods: products, docTitle: "Shop", path: '/'})
})
module.exports = router
