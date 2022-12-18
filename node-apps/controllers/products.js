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

exports.getOrders = (req, res, next) => {
    res.render('shop/orders', {
        path: '/orders',
        docTitle: 'Your Orders'
    });
}

exports.getProduct = (req, res, next) => {
    const prodId = req.params.productId;
    Product.findById(prodId, product => {
        res.render('shop/product-detail', {
            docTitle: 'Product',
            path: '/products',
            product: product,
            activeShop: true,
            productCSS: true,
        })
    })
}