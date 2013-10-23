mongoose = require 'mongoose'
ObjectId = mongoose.Schema.ObjectId

controller =
	getIndex: (req, res) ->
		Todo = mongoose.model 'Todo'
		Todo.find {
			user_id: ObjectId req.session.userId
		}, (err, todos) ->
			res.render 'todos/index', {
				page: 'Todos'
				err: err
				todos: todos
			}

	postIndex: (req, res) ->
		input = req.body

		req.checkBody('content', 'Invalid todo content').notEmpty().min(5)

		errors = req.validationErrors()

		if errors
			res.json {
				err: errors
			}
			return

		Todo = mongoose.model 'Todo'
		todo = new Todo {
			user_id: ObjectId req.session.userId
			content: input.content
		}

		todo.save (err, todo) ->
			if err?
				res.json {
					err: 'An unknown error occurred'
				}
			else
				res.json {
					todo:
					  _id: todo._id
					  content: todo.content
				}

	putTodo: (req, res) ->
		input = req.body
		#// TODO: Update todo

	deleteTodo: (req, res) ->
		_id = req.params.id

		if not _id?
			res.status 404
			res.end()

		Todo = mongoose.model 'Todo'
		Todo.remove {
			user_id: ObjectId req.session.userId
			_id: _id
		}, (err, numRemoved) ->
			if err?
				res.status 500
			else if numRemoved is 0
				res.status 404
			else
				res.status 200

			res.end()

module.exports = controller