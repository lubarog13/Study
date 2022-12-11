const Product = require('../modules/prodct')

exports.getAddProduct = (req, res, next) => {
    res.render('admin/add-product', {
        docTitle: 'Add Product',
        path: '/admin/add-product',
        activeAddProduct: true,
        formCSS: true
    })
}

exports.postAddProduct = (req, res, next) => {
    const product = new Product(req.body.title)
    product.save()
    res.redirect('/')
}

exports.getProducts = (req, res, next) => {
    Product.fetchAll((products) => {
        res.render('admin/products', {
            docTitle: 'Shop',
            path: '/admin/products',
            prods: products,
            hasProducts: products.length > 0,
            activeShop: true,
            productCSS: true,
        })
    })
}