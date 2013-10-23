mongoose = require 'mongoose'
ObjectId = mongoose.Schema.ObjectId

controller =
	getIndex: (req, res) ->
		Todo = mongoose.model 'Todo'
		Todo.find {
			_userId: req.session.userId
			active: true
		}, (err, todos) ->
			res.render 'todos/index', {
				page: 'Todos'
				err: err
				todos: todos
			}

	postIndex: (req, res) ->
		input = req.body

		req.checkBody('content', 'Invalid todo content').notEmpty().min(1)

		errors = req.validationErrors()

		if errors
			res.json {
				err: errors
			}
			return

		Todo = mongoose.model 'Todo'
		todo = new Todo {
			_userId: req.session.userId
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
		update = {}

		if req.body.completed?
			req.sanitize('completed').toBooleanStrict()
			update.completed = req.body.completed

		if req.body.content?
			req.checkBody('content', 'Invalid todo content').notEmpty().min(1)
			update.content = req.body.content

		errors = req.validationErrors()

		if errors
			res.status 400
			res.json errors
			return

		Todo = mongoose.model 'Todo'
		Todo.update {
			_id: req.params.id
			_userId: req.session.userId
			active: true
		}, {
			$set: update
		}, (err, numAffected) ->
			if err?
				res.status 500
			else if numAffected is 0
				res.status 404
			else
				res.status 200

			res.end()

	deleteTodo: (req, res) ->
		_id = req.params.id

		if not _id?
			res.status 404
			res.end()

		Todo = mongoose.model 'Todo'
		Todo.update {
			_userId: req.session.userId
			_id: _id
			active: true
		}, {
			$set: {
				active: false
			}
		}, (err, numAffected) ->
			if err?
				res.status 500
			else if numAffected is 0
				res.status 404
			else
				res.status 200

			res.end()

module.exports = controller