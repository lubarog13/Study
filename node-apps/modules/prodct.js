const fs = require('fs')
const path = require('path')
const Cart = require('./cart');

const p = path.join(path.dirname(require.main.filename), 'data', 'products.json')

const getProductsFromFile = cb => {
        fs.readFile(p, (err, fileContent) => {
            if (err) {
                cb([]);
            }
            cb(JSON.parse(fileContent));
        });
}

module.exports = class Product {
    constructor(id, title, imageUrl, description, price) {
        this.id = id;
        this.title = title
        this.imageUrl = imageUrl
        this.description=description
        this.price = price
    }

    save() {
        getProductsFromFile(products => {
            if (this.id) {
                const existingProductIndex = products.findIndex(product => product.id === this.id);
                const updatedProducts = [...products];
                updatedProducts[existingProductIndex] = this;
                fs.writeFile(p, JSON.stringify(updatedProducts), (err) => {
                    console.log(err)
                });
            } else  {
                this.id = Math.random().toString();
                products.push(this)
                fs.writeFile(p, JSON.stringify(products), (err) => {
                    console.log(err)
                })
            }
        });
    
    }

    remove() {
        getProductsFromFile(products => {
                    products.splice(products.findIndex(product => product.id === this.id), 1);
                    fs.writeFile(p, JSON.stringify(products), (err) => {
                        console.log(err)    
                        if(!err) {
                            Cart.deleteProduct(this.id, this.price)
                        }
                    })
                }
        )
    }

    static fetchAll(cb) {
        getProductsFromFile(cb);
    }

    static findById(id, cb) {
        getProductsFromFile(products => {
            const product = products.find(p => p.id === id);
            cb(product);
        })
    }
}
