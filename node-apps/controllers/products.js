const Product = require('../modules/prodct')
exports.getAddProduct = (req, res, next) => {
    res.render('add-product', {
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
    res.render('shop', {
        docTitle: 'Shop',
        path: '/',
        prods: Product.fetchAll(),
        hasProducts: Product.fetchAll().length > 0,
        activeShop: true,
        productCSS: true,
    })
}
