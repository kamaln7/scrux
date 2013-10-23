mongoose = require 'mongoose'
troop = require 'mongoose-troop'
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
}

todoSchema.plugin troop.timestamp

Todo = mongoose.model 'Todo', todoSchema

module.exports = Todo