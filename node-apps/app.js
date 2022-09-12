const express = require('express');
const path = require('path')
const bodyParser = require('body-parser')
const expressHbs = require('express-handlebars');

const adminRoutes = require('./routes/admin')
const shopRoutes = require('./routes/shop')
const errorController = require('./controllers/error')

const app = express()

app.engine('hbs', expressHbs.engine())
//app.set('view engine', 'pug');
app.set('view engine', 'hbs')
app.set('views', 'views')

app.use(bodyParser.urlencoded({extended: false}))

app.use('/admin', adminRoutes)
app.use(shopRoutes)
app.use(express.static(path.join(__dirname, 'public')));

app.use(errorController.default)

app.listen(3000);