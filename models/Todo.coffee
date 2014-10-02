mongoose = require 'mongoose'
bcrypt = require 'bcrypt'
ObjectId = mongoose.Schema.ObjectId

todoSchema = mongoose.Schema {
	_userId: ObjectId
	content: String
	completed:
		type: Boolean
		default: false
	active:
		type: Boolean
		default: true
	createdAt:
		type: Date
		default: Date.now
	updatedAt:
		type: Date
		default: Date.now
}

module.exports = mongoose.model 'Todo', todoSchema
