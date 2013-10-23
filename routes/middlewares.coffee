middlewares =
	userLocale: (req, res, next) ->
		if req.session.userId?
			res.locals.user = req.session.userId
		else
			res.locals.user = false

		next()

	loggedIn: (req, res, next) ->
		if req.session.userId?
			next()
		else
			res.redirect '/account/login'

	loggedOut: (req, res, next) ->
		if req.session.userId?
			res.redirect '/'
		else
			next()

module.exports = middlewares