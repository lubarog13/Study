const Product = require('../modules/prodct')

exports.getAddProduct = (req, res, next) => {
    res.render('admin/edit-product', {
        docTitle: 'Add Product',
        path: '/admin/add-product',
        activeAddProduct: true,
        formCSS: true,
        editing: false
    })
}

exports.postAddProduct = (req, res, next) => {
    const title = req.body.title;
    const imageURL = req.body.imageURL;
    const price = req.body.price;
    const description = req.body.description;
    const product = new Product(null, title, imageURL, description, price)
    product.save()
    res.redirect('/')
}

exports.getEditProduct = (req, res, next) => {
    const editMode = req.query.edit;
    if (!editMode) {
        return res.redirect('/');
    }
    const prodId = req.params.productId;
    Product.findById(prodId, (product) => {
       if(!product) return res.redirect('/')
        res.render('admin/edit-product', {
            docTitle: 'Edit Product',
            path: '/admin/edit-product',
            activeAddProduct: true,
            formCSS: true,
            editing: editMode,
            product: product
        })
    })
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

exports.postEditProduct = (req, res, next) => {
    const prodId = req.body.productId;
    const title = req.body.title;
    const imageURL = req.body.imageURL;
    const price = req.body.price;
    const description = req.body.description;
    const product = new Product(prodId, title, imageURL, description, price)
    product.save()
    res.redirect('/admin/products')
}

exports.deleteProduct = (req, res, next) => {
    const prodId = req.params.productId;
    Product.findById(prodId, (product) => {
        if(!product) return res.redirect('/')
        let prod = Object.assign(new Product(), product);
        prod.remove()
        res.redirect('/admin/products')
    })
}