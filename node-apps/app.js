const express = require('express');
const path = require('path')
const bodyParser = require('body-parser')
const errorController = require('./controllers/error')
//const expressHbs = require('express-handlebars');

const app = express()

//app.engine('hbs', expressHbs.engine({layoutsDir: 'views/layouts/', defaultLayout: 'main-layout', extname: 'hbs'}))
// app.set('view engine', 'pug');
//app.set('view engine', 'hbs')
app.set('view engine', 'ejs')
app.set('views', 'views')

const adminRoutes = require('./routes/admin')
const shopRoutes = require('./routes/shop')


app.use(bodyParser.urlencoded({extended: false}))

app.use('/admin', adminRoutes)
app.use(shopRoutes)
app.use(express.static(path.join(__dirname, 'public')));

app.use(errorController.default)

app.listen(3000);
