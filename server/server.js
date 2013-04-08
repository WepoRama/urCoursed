// Generated by CoffeeScript 1.6.2
var comments, host, lectures, pass, port, restify, server, user;

restify = require('restify');

host = process.env['DOTCLOUD_DB_MONGODB_HOST'] || 'localhost';

port = process.env['DOTCLOUD_DB_MONGODB_PORT'] || 27017;

port = parseInt(port);

user = process.env['DOTCLOUD_DB_MONGODB_LOGIN'] || void 0;

pass = process.env['DOTCLOUD_DB_MONGODB_PASSWORD'] || void 0;

server = restify.createServer({
  name: 'chattycat',
  version: '1.0.0'
});

server.use(restify.acceptParser(server.acceptable));

server.use(restify.queryParser());

server.use(restify.bodyParser());

server.use(restify.jsonp());

comments = [
  {
    text: 'fine this one',
    author: 'him'
  }, {
    text: 'fine this two',
    author: 'me'
  }, {
    text: 'fine this three',
    author: 'him'
  }, {
    text: 'fine this four',
    author: 'me'
  }
];

lectures = [
  {
    url: 'fine_this_one',
    author: 'us'
  }, {
    url: 'fine_this_two',
    author: 'us'
  }, {
    url: 'fine_this_tree',
    author: 'us'
  }, {
    url: 'fine_this_four',
    author: 'us'
  }
];

server.get('/api/dbstatus/', function(req, res, next) {
  console.log('checking status');
  res.send({
    comments: comments
  });
  return next();
});

server.get('/api/lectures/', function(req, res, next) {
  console.log('Reading lectures');
  res.send({
    data: lectures
  });
  return next();
});

server.get('/api/comments/', function(req, res, next) {
  console.log('Reading comments');
  console.log(comments);
  res.send({
    data: comments
  });
  return next();
});

/*
server.get(//, restify.serveStatic({
  directory: './public/web'
  }))
*/


server.get(/\/web\/?.*/, restify.serveStatic({
  directory: '../'
}));

server.listen(8080, function() {
  return console.log('%s listening at %s', server.name, server.url);
});

/*
app.get("/", function(req, res){
    var html = '<div id="content" data-stack="node" data-appname="' + process.env['DOTCLOUD_PROJECT'] + '">';
    html += 'Hello World, from Express!';
    html += '<script type="text/javascript" src="https://helloapp.dotcloud.com/inject.min.js"></script>';

    db.collection("test", function(err, collection){
        if(err) console.log(err);
        collection.find(function(err, cursor){
            if(err) console.log(err);
            res.send(html);
        });
    })
});
*/

