mongoose = require 'mongoose'
troop = require 'mongoose-troop'
bcrypt = require 'bcrypt'

userSchema = mongoose.Schema {
	username: String
	hashed_password: String
	email: String
}

userSchema.methods.setPassword = (password, cb) ->
	bcrypt.hash password, 10, (err, hash) =>
		if err?
			cb(err)
			return

		@hashed_password = hash
		cb(null)

userSchema.plugin troop.timestamp

User = mongoose.model 'User', userSchema

module.exports = User