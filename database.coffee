fs = require 'fs'
path = require 'path'
mongoose = require 'mongoose'
config = require './config'

mongoose.connect(config.database.url)


fs.readdir './models', (err, files) ->
	files.forEach (file) ->
		if ~file.indexOf '.coffee'
			require './models/' + file

module.exports = mongoose