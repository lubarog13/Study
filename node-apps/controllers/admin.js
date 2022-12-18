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
    const title = req.body.title;
    const imageURL = req.body.imageURL;
    const price = req.body.price;
    const description = req.body.description;
    const product = new Product(title, imageURL, description, price)
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