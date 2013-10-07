// Generated by CoffeeScript 1.6.3
/*
* TodoController
*
* @module		:: Controller
* @description	:: Contains logic for handling requests.
*/


(function() {
  module.exports = {
    index: function(req, res) {
      return Todo.find().done(function(err, todos) {
        return res.json({
          err: err,
          todos: todos
        });
      });
    },
    create: function(req, res) {
      return Todo.create(req.body).done(function(err, todo) {
        return res.json({
          err: err,
          todo: todo
        });
      });
    },
    destroy: function(req, res) {
      var id;
      id = req.body.id;
      if (parseInt(id) === 0) {
        return res.json({
          err: 'Invalid todo id'
        });
      }
      return Todo.destroy({
        id: id
      }).done(function(err) {
        return res.json({
          err: err
        });
      });
    }
  };

}).call(this);
