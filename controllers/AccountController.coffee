mongoose = require 'mongoose'
bcrypt = require 'bcrypt'

controller =
	getLogout: (req, res) ->
		req.session.destroy()
		res.redirect '/'

	getLogin: (req, res) ->
		res.render 'account/login', {
			page: 'Login'
			errors: req.flash 'errors'
		}

	postLogin: (req, res) ->
		input = req.body

		req.checkBody('username', 'Invalid username').notEmpty()
		req.checkBody('password', 'Invalid password').notEmpty()

		errors = req.validationErrors()

		if errors
			req.flash 'errors', errors
			res.redirect req.url
		else
			User = mongoose.model 'User'
			User.findOne { username: input.username }, (err, user) ->
				if err?
					req.flash 'errors', [{ msg: 'Invalid username/password.' }]
					res.redirect req.url
					return

				bcrypt.compare input.password, user.hashed_password, (err, result) ->
					if err?
						error = 'An unknown error occurred.'
					else if not result
						error = 'Invalid username/password.'

					if error
						req.flash 'errors', [{ msg: error }]
						res.redirect req.url
						return

					req.session.userId = user._id
					res.redirect '/'

	getRegister: (req, res) ->
		res.render 'account/register', {
			page: 'Register'
			errors: req.flash 'errors'
		}

	postRegister: (req, res) ->
		input = req.body

		req.checkBody('username', 'Invalid username').notEmpty().isAlphanumeric()
		req.checkBody('email', 'Invalid email address').notEmpty().isEmail()
		req.checkBody('password', 'Invalid password').notEmpty()
		req.checkBody('repeatpassword', 'Repeat password field does not match the password field').notEmpty().equals(input.password)

		errors = req.validationErrors()

		if errors
			req.flash 'errors', errors
			res.redirect req.url
		else
			User = mongoose.model 'User'
			User.count({ username: input.username }).exec (err, count) ->
				if err?
					req.flash 'errors', [{ msg: 'An unknown error occurred.' }]
					res.redirect req.url
					return

				if count > 0
					req.flash 'errors', [{ msg: 'Username is already taken.' }]
					res.redirect req.url
					return

				user = new User
				user.username = input.username
				user.email = input.email
				user.setPassword input.password, (err) ->
					if err?
						req.flash 'errors', [{ msg: 'An unknown error occurred.' }]
						res.redirect req.url
						return

					user.save (err) ->
						if err?
							req.flash 'errors', [{ msg: 'An unknown error occurred.' }]
							res.redirect req.url
							return

						req.session.userId = user._id
						res.redirect '/'


module.exports = controller;