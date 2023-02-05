const express = require('express');
const path = require('path')
const bodyParser = require('body-parser')
const errorController = require('./controllers/error');
const mongoConnect = require('./util/database');
const console = require('console');
const Product = require('./models/prodct');
const User = require('./models/user');
/*const Cart = require('./models/cart');
const CartItem = require('./models/cart-item');
const Order = require('./models/order');
const OrderItem = require('./models/order-item');
 */
//const expressHbs = require('express-handlebars');

const app = express()

//app.engine('hbs', expressHbs.engine({layoutsDir: 'views/layouts/', defaultLayout: 'main-layout', extname: 'hbs'}))
// app.set('view engine', 'pug');
//app.set('view engine', 'hbs')
app.set('view engine', 'ejs')
app.set('views', 'views')

const adminRoutes = require('./routes/admin')
const shopRoutes = require('./routes/shop')

/* app.use((req, res, next) => {
    User.findByPk(1).then( user => {
            req.user = user;
            next();
    }).catch(err => console.log(err));
})
 */
app.use(bodyParser.urlencoded({extended: false}))

app.use('/admin', adminRoutes)
app.use(shopRoutes)
app.use(express.static(path.join(__dirname, 'public')));

app.use(errorController.default)
mongoConnect.mongoConnect(() => {
    app.listen(3000);
})
/* 
Product.belongsTo(User, {constraints: true, onDelete: 'CASCADE'});
User.hasMany(Product);
User.hasOne(Cart);
Cart.belongsTo(User);
Cart.belongsToMany(Product, {through: CartItem});
Product.belongsToMany(Cart, {through: CartItem});
Order.belongsTo(User);
User.hasMany(Order);
Order.belongsToMany(Product, {through: OrderItem});
Product.belongsToMany(Order, {through: OrderItem});

sequelize.sync({ force: false , alter : true }).then(result => {
   // console.log(result)
   return User.findByPk(1);
})
.then(user => {
    if(!user) {
        return User.create({name: 'admin', email: 'test@example.com'});
    }
    return Promise.resolve(user)
})
.then(user => {
    if(!user.cart) {
    return user.createCart();
    }
}).then(cart=> {
    app.listen(3000);
})
.catch(err => {
    console.error(err);
}); */

