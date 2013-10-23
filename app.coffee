http = require 'http'
path = require 'path'

express = require 'express'
app = express()
MongoStore = require('connect-mongo') express

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
	app.use express.cookieParser()
	app.use express.session {
		secret: config.secret
		store: new MongoStore {
			mongoose_connection: database.connections[0]
		}
	}
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