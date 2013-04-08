#/* Express quick setup */

restify = require('restify')
#express = require('express')
#app = express()

#/* mongodb setup */
#mongo = require('mongodb')

host = process.env['DOTCLOUD_DB_MONGODB_HOST'] || 'localhost'
port = process.env['DOTCLOUD_DB_MONGODB_PORT'] ||  27017
port = parseInt(port)
user = process.env['DOTCLOUD_DB_MONGODB_LOGIN'] || undefined
pass = process.env['DOTCLOUD_DB_MONGODB_PASSWORD'] || undefined

#mongoServer = new mongo.Server(host, port, {})
#db = new mongo.Db("test", mongoServer, {auto_reconnect:true,w:'majority'})


server = restify.createServer
  name: 'chattycat'
  version: '1.0.0'
server.use restify.acceptParser(server.acceptable)
server.use restify.queryParser()
server.use restify.bodyParser()
server.use restify.jsonp()

comments = [
    {text: 'fine this one', author: 'him'}
    {text: 'fine this two', author: 'me'}
    {text: 'fine this three', author: 'him'}
    {text: 'fine this four', author: 'me'}
]

lectures = [
    {url: 'fine_this_one', name: 'one', author: 'us'}
    {url: 'fine_this_two', name: 'two', author: 'us'}
    {url: 'fine_this_tree',name: 'three',  author: 'us'}
    {url: 'fine_this_four',name: 'four',  author: 'us'}
]

server.get '/api/dbstatus/',  (req, res, next) ->
  console.log('checking status')
  res.send comments:comments
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

###
server.get(//, restify.serveStatic({
  directory: './public/web'
  }))
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
