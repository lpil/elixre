var express = require('express');
var app = express();

var newBaseURL = process.env.NEW_BASE_URL || 'http://example.com';
var port = process.env.PORT || 5000;

app.get('*', function(request, response) {
  response.redirect(newBaseURL + request.url);
});

app.listen(port, function() {
  console.log("Listening on " + port);
});