do ($ = jQuery) ->

	appendTodo = (id, content) ->
		content = $('<div/>').text(content).html()
		el = $('<tr></tr>')
		el.attr 'data-todo-id', id
		el.append $('<td></td>').html("<span class=\"col-md-10\">#{content}</span><span class=\"col-md-2 pull-right\"><a href=\"#\" class=\"toggle-completed-todo glyphicon glyphicon-ok btn btn-success\"> </a> <a href=\"#\" class=\"delete-todo glyphicon glyphicon-trash btn btn-danger\"> </a></span>")

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

	$('#todos tbody').delegate 'a.toggle-completed-todo', 'click', (e) ->
		e.preventDefault()

		tr = $(this).parent().parent().parent()
		contentSpan = $(this).parent().parent().children('.col-md-10')
		oldStatus = contentSpan.hasClass 'todo-completed'
		id = tr.data 'todo-id'

		$.ajax {
			url: "/todos/#{id}"
			type: 'PUT'
			data: {
				completed: !oldStatus
			}
			success: =>
				contentSpan.toggleClass 'todo-completed'
				$(this).toggleClass('glyphicon-repeat').toggleClass('glyphicon-ok').toggleClass('btn-success').toggleClass('btn-info')
		}

	$('#todos tbody').delegate 'a.delete-todo', 'click', (e) ->
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