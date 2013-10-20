middlewares =
	loggedIn: (req, res, next) ->
		if req.session.userId?
			res.locals.user =
				username: 'temp'
				email: 'temp@temp.com'
		else
			res.locals.user = false

		next()

module.exports = middlewares