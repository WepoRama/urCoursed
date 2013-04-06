/* Express quick setup */

restify = require('restify')
express = require('express')
app = express()

/* mongodb setup */
mongo = require('mongodb')

host = process.env['DOTCLOUD_DB_MONGODB_HOST'] || 'localhost'
port = process.env['DOTCLOUD_DB_MONGODB_PORT'] ||  27017
port = parseInt(port)
user = process.env['DOTCLOUD_DB_MONGODB_LOGIN'] || undefined
pass = process.env['DOTCLOUD_DB_MONGODB_PASSWORD'] || undefined

mongoServer = new mongo.Server(host, port, {})
db = new mongo.Db("test", mongoServer, {auto_reconnect:true,w:'majority'})


server = restify.createServer
  name: 'chattycat'
  version: '1.0.0'
server.use restify.acceptParser(server.acceptable)
server.use restify.queryParser()
server.use restify.bodyParser()

comments = [
    {text: 'fine this one', author: 'him'}
    {text: 'fine this two', author: 'me'}
    {text: 'fine this three', author: 'him'}
    {text: 'fine this four', author: 'me'}
]

lectures = [
    {url: 'fine_this_one', author: 'us'}
    {url: 'fine_this_two', author: 'us'}
    {url: 'fine_this_tree', author: 'us'}
    {url: 'fine_this_four', author: 'us'}
]

db.open((err)->{
    if(err) console.log(err)

    if(user && pass) {
        db.authenticate(user, pass, (err)->{
        })
    }
    else {
    }
})

server.get '/api/lectures/',  (req, res, next) ->
  res.send lectures
  next()
server.get '/api/comments/',  (req, res, next) ->
  res.send comments
  next()

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
