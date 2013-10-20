app = require('express')()

# Load middlewares
middlewares = require('./middlewares')

# Load controllers
HomeController = require('../controllers/HomeController');

# Define routes
app.get '/', HomeController.getIndex

module.exports = app