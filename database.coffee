database = (config) ->
	mongoose = require('mongoose')
	mongoose.connect(config.database.url)

	return mongoose

module.exports = database