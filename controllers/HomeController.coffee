controller =
	getIndex: (req, res) ->
		res.render 'index', {
			page: 'Home'
		}

module.exports = controller;