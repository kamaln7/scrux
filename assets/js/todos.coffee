do ($ = jQuery) ->

	appendTodo = (id, content) ->
		content = $('<div/>').text(content).html()
		el = $('<tr></tr>')
		el.attr 'data-todo-id', id
		el.append $('<td></td>').html("<span class=\"col-md-11\">#{content}</span><span class=\"col-md-1 pull-right\"><a href=\"#\" class=\"delete-todo glyphicon glyphicon-trash btn btn-danger\"> </a></span>")

		$('#todos tbody').append el

	$('#newTodoItem').on 'submit', (e) ->
		e.preventDefault()
		$('#error').slideUp().html('')

		content = $('#newTodoItemContent').val()
		if content
			$.post '/todos', { content: content }, (response) ->
				console.log response
				if response.err?
					if typeof response.err not 'array'
						$('#error').html('Oh no! An unknown error occurred.').slideDown()
						console.log response.err
					else
						errors = $('<ul></ul>')
						for error in response.err
							error = response.err[error]
							errors.append "<li>#{error.msg}</li>"

						$('#error').html(errors).slideDown()
				else
					$('#newTodoItemContent').val ''
					appendTodo response.todo._id, response.todo.content

		false

	$('#todos tbody a.delete-todo').on 'click', (e) ->
		e.preventDefault()

		tr = $(this).parent().parent().parent()
		id = tr.data 'todo-id'
		$.ajax {
			url: "/todos/#{id}"
			type: 'DELETE'
			success: ->
				tr.remove()
		}

		false