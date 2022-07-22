const express = require('express')
const path = require('path')
const router = express.Router();
const adminData = require('./admin')
const rootdir = require('../util/path')

router.get('/',(req, res, next) => {
    
    res.sendFile(path.join(rootdir, 'views', 'shop.html'))
})
module.exports = router
