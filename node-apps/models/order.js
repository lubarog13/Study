/* const Sequelize = require('sequelize');

const sequelize = require('../util/database'); */

/* const Order = sequelize.define('order', {
  id: {
    type: Sequelize.INTEGER,
    autoIncrement: true,
    allowNull: true,
    primaryKey: true
  }
});
 */
const getDb = require('../util/database').getDb;
class Order {}
module.exports = Order;
