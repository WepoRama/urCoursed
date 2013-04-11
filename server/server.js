// Generated by CoffeeScript 1.6.2
var addComment, addLecture, comments, getComments, host, lectures, mongo, pass, port, restify, saveComment, saveLecture, serveComments, server, teachers, user;

restify = require('restify');

mongo = require('mongodb');

host = process.env['DOTCLOUD_DB_MONGODB_HOST'] || 'localhost';

port = process.env['DOTCLOUD_DB_MONGODB_PORT'] || 27017;

port = parseInt(port);

user = process.env['DOTCLOUD_DB_MONGODB_LOGIN'] || void 0;

pass = process.env['DOTCLOUD_DB_MONGODB_PASSWORD'] || void 0;

/*
mongoServer = new mongo.Server host, port, {}
db = new mongo.Db
    "urCoursed", mongoServer, {
        auto_reconnect:true
        w:'majority'}
dbInit = ()->
    lectures = []
    db.collection('lectures', (err, collection) ->
        collection.find (err, collection) ->
            while collection.hasNext
                lectures.push collection.next
    if lectures.length == 0
        db.lectures.insert
            url: 'http://www.youtube.com/watch?v=WuiHuZq_cg4'
            name: 'one'
            author:'us'
dbInit()
*/


server = restify.createServer({
  name: 'urCoursed',
  version: '1.0.0'
});

server.use(restify.acceptParser(server.acceptable));

server.use(restify.queryParser());

server.use(restify.bodyParser());

server.use(restify.jsonp());

teachers = ['danielbsig@gmail.com', 'haralkar@gmail.com'];

comments = [
  {
    lecture: 'one',
    text: 'fine this one',
    author: 'him'
  }, {
    lecture: 'one',
    text: 'fine this two',
    author: 'me'
  }, {
    lecture: 'one',
    text: 'fine this three',
    author: 'other'
  }, {
    lecture: 'one',
    text: 'fine this four',
    author: 'somebody'
  }, {
    lecture: 'two',
    text: 'two this one',
    author: 'him'
  }, {
    lecture: 'two',
    text: 'two this two',
    author: 'me'
  }, {
    lecture: 'two',
    text: 'two this three',
    author: 'other'
  }, {
    lecture: 'two',
    text: 'two this four',
    author: 'somebody'
  }
];

lectures = [
  {
    url: 'http://www.youtube.com/watch?v=WuiHuZq_cg4',
    name: 'one',
    author: 'us',
    id: 1
  }, {
    url: 'http://www.youtube.com/watch?v=1OALSkJGsRw',
    name: 'two',
    author: 'us',
    id: 2
  }
];

server.get('/api/', function(req, res, next) {
  console.log('api call');
  res.send({
    api: ['dbstatus', 'lectures', 'lecture', 'comments']
  });
  return next();
});

server.get('/api/dbstatus/', function(req, res, next) {
  console.log('checking status');
  res.send({
    status: 'static',
    detail: 'mongodb soon we hope'
  });
  return next();
});

/*
#   Data serves and manipulation
*/


saveLecture = function(data) {
  console.log('saving lecture');
  console.log(data.url);
  return lectures.push(data);
};

saveComment = function(data) {
  console.log('saving comment');
  console.log(data.text);
  return comments.push(data);
};

getComments = function(lecture) {
  var failed, passed, _ref;

  console.log('Getting comments ' + lecture);
  console.log('All is ' + comments);
  _ref = comments.reduce((function(p, c) {
    p[+(c.lecture === lecture)].push(c);
    return p;
  }), [[], []]), failed = _ref[0], passed = _ref[1];
  console.log('will serve: ' + passed);
  return passed;
};

addLecture = function(req, res, next) {
  console.log('Adding new lecture');
  console.log(req.params.data);
  saveLecture(req.params.data);
  res.send(200);
  return next();
};

addComment = function(req, res, next) {
  var comms;

  saveComment(req.params.data);
  comms = getComments(req.params.lecture);
  res.send({
    data: comms
  });
  return next();
};

serveComments = function(req, res, next) {
  var comms;

  comms = getComments(req.params.lecture);
  if (!req.params.comment || req.params.comment === 'all') {
    res.send({
      data: comms
    });
  } else {
    res.send({
      data: comms[req.params.comment]
    });
  }
  return next();
};

server.post('/api/lecture', addLecture);

server.post('/api/lecture/', addLecture);

server.get('/api/lecture', function(req, res, next) {
  res.send({
    data: lectures
  });
  return next();
});

server.post('/api/lecture/:lecture/comment', addComment);

server.put('/api/lecture/:lecture/comment', addComment);

server.get('/api/lecture/:lecture/comment', serveComments);

server.get('/api/lecture/:lecture/comment/:comment', serveComments);

/*
#   Static content and server beyond this point
*/


server.get(/\/web\/?.*/, restify.serveStatic({
  directory: '.'
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

