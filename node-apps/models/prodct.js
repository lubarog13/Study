const getDb = require('../util/database').getDb;
const mongodb = require('mongodb');

class Product {
    constructor(title, price, description, imageUrl, id = null) {
        if (id) {
        this._id = new mongodb.ObjectId(id);
        }
        this.title = title;
        this.price = price;
        this.description = description;
        this.imageUrl   = imageUrl;
    }
    save() {
        const db = getDb();
        let dbOp;
        if (this._id) {
            dbOp = db.collection('products').updateOne({_id: this._id}, {$set: this})
        } else {
            dbOp = db.collection('products').insertOne(this)
        }
        return dbOp.then(result => {
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
        return db.collection('products').find({_id: new mongodb.ObjectId(productId)}).next()
        .then(product => {
            console.log(product);
            return product;
        })
        .catch(err => {
            console.error(err);
        })
    }

    static deleteById(productId) {
        const db = getDb();
        return db
            .collection('products')
            .deleteOne({_id: new mongodb.ObjectId(productId)})
            .then(res => {
                console.log(res, productId);
                console.log('Deleted')
            })
            .catch(err => console.log(err));
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