const Product = require("../models/prodct");
const Cart = require("../models/cart");

exports.getProducts = (req, res, next) => {
  Product.findAll()
    .then(products => {
      res.render("shop/product-list", {
        docTitle: "All Products",
        path: "/products",
        prods: products,
        hasProducts: products.length > 0,
        activeShop: true,
        productCSS: true,
      });
    })
    .catch((err) => console.log(err));
};

exports.getIndex = (req, res, next) => {
    Product.findAll()
    .then((products) => {
      res.render("shop/index", {
        docTitle: "Shop",
        path: "/",
        prods: products,
        hasProducts: products.length > 0,
        activeShop: true,
        productCSS: true,
      });
    })
    .catch((err) => console.log(err));
};

exports.getCard = (req, res, next) => {
  Cart.getCart((cart) => {
    Product.fetchAll((products) => {
      const cardProducts = [];
      for (let product of products) {
        const cartProductData = cart.products.find((p) => p.id === product.id);
        if (cardProducts) {
          cardProducts.push({ productData: product, qty: cartProductData.qty });
        }
      }
      res.render("shop/card", {
        path: "/card",
        docTitle: "Your Card",
        products: cardProducts,
      });
    });
  });
};

exports.postCard = (req, res, next) => {
  const prodId = req.body.productId;
  Product.findById(prodId, (product) => {
    Cart.addProduct(prodId, product.price);
  });
  res.redirect("/card");
};

exports.getCheckout = (req, res, next) => {
  res.render("shop/checkout", {
    path: "/checkout",
    docTitle: "Checkout",
  });
};

exports.getOrders = (req, res, next) => {
  res.render("shop/orders", {
    path: "/orders",
    docTitle: "Your Orders",
  });
};

exports.getProduct = (req, res, next) => {
  const prodId = req.params.productId;
  // Product.findAll({where: {id: prodId});
  Product.findByPk(prodId)
    .then((product) => {
        res.render("shop/product-detail", {
            docTitle: "Product",
            path: "/products",
            product: product,
            activeShop: true,
            productCSS: true,
          });
    })
    .catch((err) => console.log(err));
};

exports.deleteCartItem = (req, res, next) => {
  const prodId = req.body.productId;
  Product.findById(prodId, (product) => {
    Cart.deleteProduct(prodId, product.price);
    res.redirect("/cart");
  });
};
