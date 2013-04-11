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
  name: 'urCoursed'
  version: '1.0.0'
server.use restify.acceptParser(server.acceptable)
server.use restify.queryParser()
server.use restify.bodyParser()
server.use restify.jsonp()

#teachers = ['danielbsig@gmail.com','haralkar@gmail.com']
teachers = ['Daníel', 'Haraldur']
comments = [
        {lecture: 'one', text: 'fine this one', author: 'him'}
        {lecture: 'one', text: 'fine this two', author: 'me'}
        {lecture: 'one', text: 'fine this three', author: 'other'}
        {lecture: 'one', text: 'fine this four', author: 'somebody'}
        {lecture: 'two', text: 'two this one', author: 'him'}
        {lecture: 'two', text: 'two this two', author: 'me'}
        {lecture: 'two', text: 'two this three', author: 'other'}
        {lecture: 'two', text: 'two this four', author: 'somebody'}
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
    status: 'static'
    detail: 'mongodb soon we hope'
  next()
    
###
#   Data serves and manipulation
###
saveLecture = ( data ) ->
  console.log 'saving lecture'
  console.log data.url
  lectures.push data
saveComment = ( data ) ->
  console.log 'saving comment'
  console.log data.text
  comments.push data
getComments = (lecture) ->
    console.log 'Getting comments ' + lecture
    console.log 'All is ' + comments
    # this wonderful piece of coffescript one-liner is adapted from:
    #   http://ricardo.cc/2011/06/02/10-CoffeeScript-One-Liners-to-Impress-Your-Friends.html
    [failed, passed ] = comments.reduce ((p,c) -> p[+(c.lecture == lecture)].push c; p), [[],[]]
    console.log 'will serve: ' + passed
    passed
addLecture = (req, res, next) ->
  console.log 'Adding new lecture'
  console.log req.params.data
  saveLecture req.params.data
  ##res.send data:comments
  res.send 200
  next()
addComment = (req, res, next) ->
  ##console.log 'Adding neW commet'
  #console.log req.params
  #console.log req.params.data
  saveComment req.params.data
  comms = getComments req.params.lecture
  res.send
    data: comms
  next()
serveComments = (req, res, next) ->
  #console.log 'Serving comments for lecture'
  #console.log req.params
  comms = getComments req.params.lecture
  if not req.params.comment or req.params.comment == 'all'
    #console.log 'We Serve All'
    #console.log req.params.lecture
    #console.log "Now serving: " + comms
    res.send data: comms
  else
    res.send data:comms[req.params.comment]
  #console.log
  next()

server.post '/api/lecture',  addLecture
server.post '/api/lecture/', addLecture
server.get  '/api/lecture', (req, res, next) ->
    res.send data:lectures
    next()

server.post '/api/lecture/:lecture/comment', addComment
server.put  '/api/lecture/:lecture/comment', addComment
server.get  '/api/lecture/:lecture/comment',  serveComments
server.get  '/api/lecture/:lecture/comment/:comment', serveComments

server.get  '/api/teachers', (req, res, next) ->
    res.send data:teachers
    next()
server.get  '/api/teachers/:teacher', (req, res, next) ->
    t = teachers.map (m)-> if req.params.teacher == m 1 else 0
    isT = t.reduce (x,y)-> x+y
    res.send data: isT > 0
    next()
###
#   Static content and server beyond this point
###
server.get(/\/web\/?.*/, restify.serveStatic({
directory: '.'
}))

server.listen 8080, () ->
  console.log '%s listening at %s', server.name, server.url

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
