# Load express
express = require 'express'
fs = require 'fs'
app = express()

# Load middlewares
middlewares = require './middlewares'

# Load controllers
controllers = {}
files = fs.readdirSync './controllers'
files.forEach (file) ->
  if ~file.indexOf '.coffee'
    controllers[file.replace '\.coffee', ''] = require '../controllers/' + file

# Define routes
# Home
app.get '/', controllers['HomeController'].getIndex

# Account
app.get '/account/logout', middlewares.loggedIn, controllers['AccountController'].getLogout
app.get '/account/login', middlewares.loggedOut, controllers['AccountController'].getLogin
app.post '/account/login', middlewares.loggedOut, controllers['AccountController'].postLogin
app.get '/account/register', middlewares.loggedOut, controllers['AccountController'].getRegister
app.post '/account/register', middlewares.loggedOut, controllers['AccountController'].postRegister

# Todos
app.get '/todos', middlewares.loggedIn, controllers['TodosController'].getIndex
app.post '/todos', middlewares.loggedIn, controllers['TodosController'].postIndex
app.put '/todos/:id([0-9a-f]{24})', middlewares.loggedIn, controllers['TodosController'].putTodo
app.delete '/todos/:id([0-9a-f]{24})', middlewares.loggedIn, controllers['TodosController'].deleteTodo

module.exports = app
