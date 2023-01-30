const getDb = require('../util/database').getDb;

class Product {
    constructor(title, price, description, imageUrl) {
        this.title = title;
        this.price = price;
        this.description = description;
        this.imageUrl   = imageUrl;
    }
    save() {
        const db = getDb();
        return db.collection('products').insertOne(this).then(result => {
            console.log(result);
        })
        .catch(err => {
            console.error(err);
        })
    }
    static fetchAll() {
        const db = getDb();
        return db.collection('products').find().toArray()
        .then(products => {
            console.log(products);
            return products;
        })
        .catch(err => {
            console.error(err);
        })
    }

    static findById(productId) {
        const db = getDb();
        console.log(productId);
        return db.collection('products').find({_id: productId}).next()
        .then(product => {
            console.log(product);
            return product;
        })
        .catch(err => {
            console.error(err);
        })
    }
}

/* const Product = sequelize.define('product', {
    id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        allowNull: false,
        primaryKey: true
    },
    title: Sequelize.STRING,
    price: {
        type: Sequelize.DOUBLE,
        allowNull: false,
    },
    imageUrl: {
        type: Sequelize.STRING,
        allowNull: false,
    },
    description: {
        type: Sequelize.STRING,
        allowNull: false,
    }
});
 */

module.exports = Product;