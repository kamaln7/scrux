###
* TodoController
*
* @module		:: Controller
* @description	:: Contains logic for handling requests.
###

module.exports =

	index: (req, res) ->
		Todo.find().done (err, todos) ->
			return res.json {err: err, todos: todos}

	create: (req, res) ->
		Todo.create(req.body).done (err, todo) ->
			return res.json {err: err, todo: todo}

	destroy: (req, res) ->
		id = req.body.id
		if parseInt(id) is 0
			return res.json {err: 'Invalid todo id'}

		#//TODO: Make it work
		Todo.destroy({id: id}).done (err) ->
			return res.json {err: err}