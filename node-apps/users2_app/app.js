const express = require('express');
const app = express()
app.get('/',(req, res, next) => {
    console.log('hello');
    res.send('<h1>Hello from app 2</h1>');
})
app.get('/users', (req, res, next) => {
    console.log('hi');
    res.send('<h1>Users</h1>');
})
app.listen(3001);