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

user.pre 'save', (next) ->
	user = this
	
	if !user.isModiefied 'password'
		next()
		
	bcrypt.genSalt(10, (err, salt) ->
		if err
			next(err)
		
		bcrypt.hash(user.password, salt, (err, hash) ->
			if err
				next(err)
				
			user.password = hash
			next()

module.exports = mongoose.model 'User', userSchema
