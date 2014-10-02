mongoose = require 'mongoose'
bcrypt = require 'bcrypt'

userSchema = mongoose.Schema {
	username: String
	hashed_password: String
	email: String
	createdAt:
		type: Date
		default: Date.now
	updatedAt:
		type: Date
		default: Date.now
}

userSchema.methods.setPassword = (password, cb) ->
	bcrypt.hash password, 10, (err, hash) =>
		if err?
			cb(err)
			return

		@hashed_password = hash
		cb(null)

module.exports = mongoose.model 'User', userSchema
