var http  = require('http');
var fs    = require('fs');

console.log('Starting server');

/**
 * This function takes a url and returns the file path that
 * corresponds to that url
 * Example:
 *    url: 'app.css'
 *    returns: 'public/app.css'
 */
function getFilepath(url){
  var filepath = require('url').parse(url).pathname;

  // The "root" pathname is always "/", so we will return the "index.html"
  // instead of "/"
  if (filepath === '/') {
    filepath = '/mapbox.html';
  }

  // Adds the absolute path to the directory of this file (server.js) and
  // adds "/public" to it, because our files are in the "public/" directory.
  filepath = __dirname + '/public' + filepath;

  console.log('Getting filepath from url: ' + url + '. Filepath: ' + filepath);
  return filepath;
}

/**
 * This function will be called when there is an error
 * reading our file from disk.
 * We must pass the 'res' argument so that this function
 * has access to it so it can send a response.
 */
function handleError(err, res){
  res.writeHead(500, {'Content-Type': 'text/html'});
  res.write('Handled Error: ' + err);
  res.end();
}

/**
 * This is the main part of our server, where we
 * actually create the server!
 */
var server = http.createServer(function(req, res){

  // figure out what file on disk corresponds to the
  // url that the user requested
  var filepath = getFilepath(req.url);

  // read 
  fs.readFile(filepath, function(err, data){
    if (err) {
      console.log('Failed to read file at path:' + filepath);
      handleError(err, res);
    } else {
      res.writeHead(200, {'Content-Type': 'text/html'});
      
      // Write the data that we read from the file
      res.write(data);
      res.end();
    }
  });
});

var port = Number(process.env.PORT || 5000);
console.log('Listening on port',port);
server.listen(port);