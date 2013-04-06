restify = require('restify')

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

server.get '/api/lectures/',  (req, res, next) ->
  res.send lectures
  next()
server.get '/api/comments/',  (req, res, next) ->
  res.send comments
  next()

server.listen 8080, () ->
  console.log '%s listening at %s', server.name, server.url
