express = require 'express'
http = require 'http'
path = require 'path'

app = express()

app.configure ->
	app.set 'port', process.env.PORT || 3000
	app.set 'views', __dirname + '/views'
	app.set 'view engine', 'ejs'
	app.use express.favicon()
	app.use express.logger()
	app.use express.bodyParser()
	app.use express.methodOverride()
	app.use app.router
	app.use require('stylus').middleware __dirname + '/public'
	app.use express.static(path.join __dirname, 'public')
	null

app.configure 'development', ->
	app.use express.logger 'dev'
	app.use express.errorHandler()
	null

app.configure 'production', ->
	app.disable 'x-powered-by'
	null

app.use require('./routes')

http.createServer(app).listen (app.get 'port'), ->
	console.log 'Scrux listening on port ' + app.get 'port'