express = require 'express'
http = require 'http'
path = require 'path'

app = express()
middlewares = require('./routes/middlewares')
routes = require('./routes')
config = require('./config')

app.configure ->
	app.set 'port', config.port || 3000
	app.set 'views', __dirname + '/views'
	app.set 'view engine', 'ejs'
	app.use require('express-partials')()
	app.use express.favicon()
	app.use express.logger()
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use express.cookieParser(config.secret)
	app.use express.session()
	app.use app.router
	app.use require('connect-assets')()
	app.use express.static(path.join __dirname, 'public')
	null

app.configure 'development', ->
	app.use express.logger 'dev'
	app.use express.errorHandler()
	null

app.configure 'production', ->
	app.disable 'x-powered-by'
	null

app.use middlewares.loggedIn

app.use routes

http.createServer(app).listen (app.get 'port'), ->
	console.log 'Scrux listening on port ' + app.get 'port'