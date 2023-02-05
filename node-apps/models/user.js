/*const Sequelize = require('sequelize');

const sequelize = require('../util/database');*/

const getDb = require('../util/database').getDb;
const mongodb = require('mongodb');

class User {
    constructor(username, email, cart) {
        this.username = username;
        this.email = email;
        this.cart = cart;
    }

    save() {
        const db = getDb();
        return db.collection('users').insertOne(this)
        .then((res) => {
            console.log(res);
        })
        .catch((err) => {
            console.log(err);
        });
    }

    addToCard(product) {
        const cartProduct = this.cart.items.findIndex(cp => {
            return cp._id == product._id;
        })

        const updatedCart = {items: [product]}
    }

    static findById(userId) {
        const db = getDb();
        return db.collection('users').findOne({_id: new mongodb.ObjectId(userId)})
        .then(user => {
            return user;
        })
        .catch(err => {
            console.error(err);
        })
    }
}

/*const User = sequelize.define('user', {
    id: {
        type: Sequelize.INTEGER,
        autoIncrement: true,
        allowNull: false,
        primaryKey: true,
    },
    name: {
        type: Sequelize.STRING,
        allowNull: false,
    },
    email: {
        type: Sequelize.STRING,
        allowNull: false
    }
})*/

module.exports = User;