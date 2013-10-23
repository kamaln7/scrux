express = require 'express'
http = require 'http'
path = require 'path'

app = express()
config = require './config'

middlewares = require './routes/middlewares'
routes = require './routes'
database = require './database'

app.configure ->
	app.set 'port', config.port || 3000
	app.set 'views', __dirname + '/views'
	app.set 'view engine', 'ejs'
	app.use require('express-partials')()
	app.use express.favicon()
	app.use express.logger()
	app.use express.bodyParser()
	app.use require('express-validator')()
	app.use express.methodOverride()
	app.use express.cookieParser(config.secret)
	app.use express.session()
	app.use require('connect-flash')()
	app.use require('connect-assets')()
	app.use express.static(path.join __dirname, 'public')
	app.use app.router
	null

app.configure 'development', ->
	app.use express.logger 'dev'
	app.use express.errorHandler()
	null

app.configure 'production', ->
	app.disable 'x-powered-by'
	null

app.use middlewares.userLocale

app.use routes

http.createServer(app).listen (app.get 'port'), ->
	console.log 'Scrux listening on port ' + app.get 'port'