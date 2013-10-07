do ($ = jQuery, window) ->
	do (io = window.io) ->
		appendTodo = (id, content) ->
			content = $('<div/>').text(content).html()
			el = $('<tr></tr>')
			el.attr 'data-todo-id', id
			el.append $('<td></td>').html("#{content} <div class=\"pull-right\"><a href=\"#\" data-todo-id=\"#{id}\" class=\"delete-todo glyphicon glyphicon-trash\"></span></div>")

			$('#todos tbody').append el

		socket = io.connect()

		socket.on 'connect', ->
			socket.get '/todo', (response) ->
				if response.err?
					$('#error').html('Oh no! An unknown error occurred.').slideDown()
					console.log response.err
				else
					for todo in response.todos then do (todo) ->
						appendTodo(todo.id, todo.content)

			$('#newTodoItem').on 'submit', (e) ->
				e.preventDefault()
				$('#error').slideUp().html('')

				content = $('#newTodoItemContent').val()
				if content
					socket.post '/todo', { content: content }, (response) ->
						if response.err?
							if not response.err.ValidationError?
								$('#error').html('Oh no! An unknown error occurred.').slideDown()
								console.log response.err
							else
								$('#error').html(response.err.ValidationError.content[0].message).slideDown()
						else
							$('#newTodoItemContent').val('')
							appendTodo(response.todo.id, response.todo.content)

			$('#todos tbody').delegate 'a.delete-todo', 'click', (e) ->
				e.preventDefault()

				id = $(this).data('todo-id')
				socket.delete "/todo/{#id}", (response) ->
					console.log response
				return false