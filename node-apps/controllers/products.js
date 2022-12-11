const Product = require('../modules/prodct')

exports.getProducts = (req, res, next) => {
    Product.fetchAll((products) => {
        res.render('shop/product-list', {
            docTitle: 'All Products',
            path: '/products',
            prods: products,
            hasProducts: products.length > 0,
            activeShop: true,
            productCSS: true,
        })
    })
}

exports.getIndex = (req, res, next) => {
    Product.fetchAll((products) => {
        res.render('shop/index', {
            docTitle: 'Shop',
            path: '/',
            prods: products,
            hasProducts: products.length > 0,
            activeShop: true,
            productCSS: true,
        })
    })
}

exports.getCard = (req, res, next) => {
    res.render('shop/card', {
        path: '/card',
        docTitle: 'Your Card'
    });
}

exports.getCheckout = (req, res, next) => {
    res.render('shop/checkout', {
        path: '/checkout',
        docTitle: 'Checkout'
    })
}