app = require('express')()

app.get '/', (req, res) ->
	res.render 'index', {
		title: 'scrux'
	}

module.exports = app