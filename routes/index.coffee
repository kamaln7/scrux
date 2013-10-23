# Load express
express = require('express')
app = express()

# Load middlewares
middlewares = require './middlewares'

# Load controllers
HomeController = require '../controllers/HomeController'
AccountController = require '../controllers/AccountController'

# Define routes
# Home
app.get '/', HomeController.getIndex

# Account
app.get '/account/logout', middlewares.loggedIn, AccountController.getLogout
app.get '/account/login', middlewares.loggedOut, AccountController.getLogin
app.post '/account/login', middlewares.loggedOut, AccountController.postLogin
app.get '/account/register', middlewares.loggedOut, AccountController.getRegister
app.post '/account/register', middlewares.loggedOut, AccountController.postRegister
module.exports = app