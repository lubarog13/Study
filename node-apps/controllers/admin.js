const Product = require('../models/prodct')


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
    const imageUrl = req.body.imageURL;
    const price = req.body.price;
    const description = req.body.description;
    //Product.create({title, price, imageUrl, description, userId: req.user.id})
    const product = new Product(title, price, description, imageUrl);
    product.save()
    .then(result => {
        //console.log(result);
        res.redirect('/');
    }).catch(err => {
        console.log(err);
    })
}

exports.getEditProduct = (req, res, next) => {
    const editMode = req.query.edit;
    if (!editMode) {
        return res.redirect('/');
    }
    const prodId = req.params.productId;
    Product.findById(prodId).then((product) => {
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
    //Product.findAll()
    Product.fetchAll()
    .then((products) => {
      res.render("admin/products", {
        docTitle: "Shop",
        path: '/admin/products',
        prods: products,
        hasProducts: products.length > 0,
        activeShop: true,
        productCSS: true,
      });
    })
    .catch((err) => console.log(err));
}

exports.postEditProduct = (req, res, next) => {
    const prodId = req.body.productId;
    const title = req.body.title;
    const imageURL = req.body.imageURL;
    const price = req.body.price;
    const description = req.body.description;
    const product = new Product(title, price, description, imageURL, prodId)

    return product.save()
    .then(result => {
        res.redirect('/admin/products')
    })
}

exports.deleteProduct = (req, res, next) => {
    const prodId = req.params.productId;
    /*Product.findByPk(prodId).then(product => {
        return product.destroy();
    })*/
    Product.deleteById(prodId)
    .then(() =>
        res.redirect('/admin/products')
    )
    .catch(err => {
        console.error(err);
    });
}