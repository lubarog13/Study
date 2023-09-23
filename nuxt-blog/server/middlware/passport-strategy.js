const {Strategy, ExtractJwt} = require('passport-jwt')
const {model} = require('mongoose')
const keys = require('../keys')
const User =  model('users')
