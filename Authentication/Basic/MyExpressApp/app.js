var express = require('express');
var path = require('path');
var favicon = require('serve-favicon');
var logger = require('morgan');
var cookieParser = require('cookie-parser');
var bodyParser = require('body-parser');

var routes = require('./routes/index');
var users = require('./routes/users');

var app = express();

//A. Database
var sqlite3 = require('sqlite3').verbose()
var db = new sqlite3.Database('swiftApp.db')

//B. Special Config
app.locals.pretty = true;
app.set('port', process.env.PORT || 8080);
app.set('ipaddress', process.env.HOST || "localhost");

// view engine setup
app.set('views', path.join(__dirname, 'views'));
app.set('view engine', 'jade');

// uncomment after placing your favicon in /public
//app.use(favicon(path.join(__dirname, 'public', 'favicon.ico')));
app.use(logger('dev'));
app.use(bodyParser.json());
app.use(bodyParser.urlencoded({ extended: false }));
app.use(cookieParser());
app.use(express.static(path.join(__dirname, 'public')));

app.use('/', routes);
app.use('/users', users);


db.get("SELECT name FROM sqlite_master WHERE type='table' AND name='users'", function(err, rows){
	if(err !== null){
		console.log(err);
	}
	else if(rows === undefined){
		var query = 'CREATE TABLE "users" ' + 
					'(' +
					'"user_id" INTEGER PRIMARY KEY AUTOINCREMENT, ' + 
					'"email" VARCHAR(255), ' + 
					'"first_name" VARCHAR(255), ' + 
					'"last_name" VARCHAR(255), ' + 
					'"user_password" VARCHAR(255), ' + 
					'"salt" BINARY(16) ' +
					')'
		db.run( query, function(err){
			if(err) throw new Error()
			else console.log("SQL Table Initialized")
		})
	}
	else{
		console.log("SQL Table 'users' initialized")
	}
})


// catch 404 and forward to error handler
app.use(function(req, res, next) {
  var err = new Error('Not Found');
  err.status = 404;
  next(err);
});

// error handlers

// development error handler
// will print stacktrace
if (app.get('env') === 'development') {
  app.use(function(err, req, res, next) {
    res.status(err.status || 500);
    res.render('error', {
      message: err.message,
      error: err
    });
  });
}

// production error handler
// no stacktraces leaked to user
app.use(function(err, req, res, next) {
  res.status(err.status || 500);
  res.render('error', {
    message: err.message,
    error: {}
  });
});


module.exports = app;

/* ** ** ** ** ** ** **
* App Server Listening
* ** ** ** ** ** ** **/
app.listen(app.get('port'), app.get('ipaddress'), function() {
    console.log("Node app is running at localhost:" + app.get('port'))
});