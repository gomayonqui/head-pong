// Generated by CoffeeScript 1.3.3
(function() {
  var app, express, http, io, server;

  express = require("express");

  app = express();

  http = require('http');

  app.configure(function() {
    app.set('port', process.env.PORT || 3000);
    app.use(express.bodyParser());
    app.use(app.router);
    app.use(express["static"]("" + __dirname + "/public"));
    app.set("views", "" + __dirname + "/views");
    return app.set("view engine", "jade");
  });

  app.get("/", function(req, res) {
    return res.render("index");
  });

  app.get("/camera", function(req, res) {
    return res.render("camera");
  });

  server = http.createServer(app).listen(app.get('port'), function() {
    return console.log("Express server listening on port " + app.get('port'));
  });

  io = require('socket.io').listen(server, app);

  io.sockets.on('connection', function(socket) {
    console.log('you have connected');
    socket.emit('news', {
      hello: 'world'
    });
    return socket.on('movement', function(x) {
      return console.log(x);
    });
  });

}).call(this);
