/* const Sequelize = require('sequelize');

const sequelize = new Sequelize('nodecomplete', 'root', '1234', {dialect: 'mysql', host: 'localhost'});

module.exports = sequelize; */
const mongodb = require('mongodb');
const MongoClient = mongodb.MongoClient;
let _db;
const mongoConnect = (callback) => {
MongoClient.connect('mongodb+srv://lubarog13:CustomPassword@cluster0.z52nid3.mongodb.net/?retryWrites=true&w=majority')
.then((client) => {
    console.log('Connected')
    _db = client.db();
    callback();
}).catch((err) =>  {console.error(err); throw err});
}

const getDb = () => {
    if(_db ) {
        return _db;
    }
    throw 'No database FOUND'
}

exports.mongoConnect = mongoConnect;
exports.getDb = getDb