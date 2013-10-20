routes = (app) ->
	# Load middlewares
	middlewares = app.get 'middlewares'

	# Load controllers
	HomeController = require('../controllers/HomeController')(app);

	# Define routes
	app.get '/', HomeController.getIndex

module.exports = routes