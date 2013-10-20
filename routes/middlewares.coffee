middlewares = (app) ->
	return {
		loggedIn: (req, res, next) ->
			res.locals.user = 'derp'
			next()
			return null

			if false
				User = require('../models/User')(app)
				res.locals.user ->
					return {
						username: 'temp',
						email: 'temp@temp.com'
					}
			else
				res.locals.user = 'derp'

			next()
	}

module.exports = middlewares