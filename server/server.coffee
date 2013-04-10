#/* Express quick setup */

restify = require('restify')

#/* mongodb setup */
mongo = require('mongodb')

host = process.env['DOTCLOUD_DB_MONGODB_HOST'] || 'localhost'
port = process.env['DOTCLOUD_DB_MONGODB_PORT'] ||  27017
port = parseInt(port)
user = process.env['DOTCLOUD_DB_MONGODB_LOGIN'] || undefined
pass = process.env['DOTCLOUD_DB_MONGODB_PASSWORD'] || undefined

###
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

###
# restify setup:
server = restify.createServer
  name: 'urCourse'
  version: '1.0.0'
server.use restify.acceptParser(server.acceptable)
server.use restify.queryParser()
server.use restify.bodyParser()
server.use restify.jsonp()

comments = [
    {text: 'fine this one', author: 'him'}
    {text: 'fine this two', author: 'me'}
    {text: 'fine this three', author: 'other'}
    {text: 'fine this four', author: 'somebody'}
]

lectures = [
    {url: 'http://www.youtube.com/watch?v=WuiHuZq_cg4', name: 'one', author: 'us', id: 1}
    {url: 'http://www.youtube.com/watch?v=1OALSkJGsRw', name: 'two', author: 'us', id: 2}
]

server.get '/api/',  (req, res, next) ->
  console.log 'api call'
  res.send api: ['dbstatus', 'lectures', 'lecture', 'comments']
  next()
server.get '/api/dbstatus/',  (req, res, next) ->
  console.log('checking status')
  res.send
    status: 'mongodb'
    detail: 'we hope'
  next()
    
server.get '/api/lectures/:course',  (req, res, next) ->
  #there can be only one course, ignore course
  console.log('Reading lectures:')
  console.log lectures
  res.send data: lectures
  next()
server.get '/api/comments/:lecture',  (req, res, next) ->
  console.log 'Reading comments'
  console.log req.params.lecture
  console.log comments
  res.send data: comments
  next()
server.post '/api/comments/:lecture',  (req, res, next) ->
  console.log 'Putting lecture in comments only'
  console.log req
  res.send data:comments
  #console.log
  next()

serveComments = (req, res, next) ->
  console.log 'Serving comments for lecture'
  console.log req.params
  if not req.params.comment or req.params.comment == 'all'
    res.send data:comments
  else
    res.send data:comments[req.params.comment]
  #console.log
  next()
server.get '/api/lecture/:lecture/comment',  serveComments
server.get '/api/lecture/:lecture/comment/:comment', serveComments


saveComment = (req, res, next) ->
  console.log 'Putting comment in (alc)'
  console.log req.params.data
  comments.push req.param.data
  console.log "resulting in:"
  console.log comments
  res.send data:comments
  next()
server.post '/api/lecture/:lecture/comment/:comment', saveComment
server.put '/api/lecture/:lecture/comment/:comment', saveComment

server.put  '/api/lecture/:lecture', saveComment
#            /api/lecture/:lecture'
server.post '/api/lecture/:lecture', saveComment
server.get  '/api/lecture/:lecture',  serveComments

logActivity = (req, res, next) ->
  console.log 'LOggin Actgivitiy comment in (alc)'
  console.log req
  console.log req.params
  console.log req.params.data
  res.send data:comments

server.put  '/api/lecture/', logActivity

server.put  '/api/lecture', logActivity


###
#   In proper use; upto but excluding next comment
###
saveLecture = ( data ) ->
  console.log 'saving lecture'
  console.log data.url
  lectures.push data
addLecture = (req, res, next) ->
  console.log 'Adding new lecture'
  console.log req.params.data
  saveLecture req.params.data
  ##res.send data:comments
  res.send 200
  next()
server.post '/api/lecture',  addLecture
server.post '/api/lecture/', addLecture
server.get  '/api/lecture', (req, res, next) ->
    res.send data:lectures
    next()

server.get(/\/web\/?.*/, restify.serveStatic({
directory: '.'
}))

server.listen 8080, () ->
  console.log '%s listening at %s', server.name, server.url

#sendAllLectures
###
lectures = []
db.collection('lectures', (err, collection) ->
    collection.find (err, collection) ->
        while collection.hasNext
            lectures.push collection.next
###

###
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
###
