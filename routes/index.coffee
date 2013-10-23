# Load express
express = require 'express'
app = express()

# Load middlewares
middlewares = require './middlewares'

# Load controllers
HomeController = require '../controllers/HomeController'
AccountController = require '../controllers/AccountController'
TodosController = require '../controllers/TodosController'

# Define routes
# Home
app.get '/', HomeController.getIndex

# Account
app.get '/account/logout', middlewares.loggedIn, AccountController.getLogout
app.get '/account/login', middlewares.loggedOut, AccountController.getLogin
app.post '/account/login', middlewares.loggedOut, AccountController.postLogin
app.get '/account/register', middlewares.loggedOut, AccountController.getRegister
app.post '/account/register', middlewares.loggedOut, AccountController.postRegister

# Todos
app.get '/todos', middlewares.loggedIn, TodosController.getIndex
app.post '/todos', middlewares.loggedIn, TodosController.postIndex
app.put '/todos/:id([0-9a-f]{24})', middlewares.loggedIn, TodosController.putTodo
app.delete '/todos/:id([0-9a-f]{24})', middlewares.loggedIn, TodosController.deleteTodo

module.exports = app