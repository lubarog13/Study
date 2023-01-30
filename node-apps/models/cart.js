/* const Sequelize = require('sequelize');

const sequelize = require('../util/database'); */

const getDb = require('../util/database').getDb;

class Cart {}

/* const Cart = sequelize.define('cart', {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: true,
    primaryKey: true
  }
});
 */
module.exports = Cart;

