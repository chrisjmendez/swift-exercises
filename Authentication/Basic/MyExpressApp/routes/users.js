var express = require('express')
, router    = express.Router()
, async     = require('async')

/* GET users listing. */
router.get('/', function(req, res, next) {
	
	var query = 'SELECT * FROM users ORDER BY email'
	db.all(query, function(err, row) {
		if(err !== null) {
			// Express handles errors via its next function.
			// It will call the next operation layer (middleware),
			// which is by default one that handles errors.
			next(err);
		}
		else {
			console.log(row);
			res.render('index.jade', {bookmarks: row}, function(err, html) {
				res.send(200, html);
			});
		}
	});
	
	
});

// We define a new route that will handle bookmark creation
router.post('/add', function(req, res, next) {
	var email         = req.body.email
	var first_name    = req.body.firstName
	var last_name     = req.body.lastName
	var user_password = req.body.password
	
	console.log( email, first_name, last_name, user_password)
	
	async.auto({
		save_user: [function(callback){
			var query = "INSERT INTO 'users' (email, first_name, last_name, user_password) VALUES('" +
			email + "', '" + 
			first_name + "', '" + 
			last_name + "', '" + 
			user_password + 
			"')"

			db.run(query, function(err) {
				if(err !== null) {
					console.log("success")
					next(err);
				}
				else {
					console.log("fail")
					res.redirect('back');
				}
			});
		}]
	},
	function(err, results, o) {
	});
});

// We define another route that will handle bookmark deletion
router.get('/delete/:id', function(req, res, next) {
	db.run("DELETE FROM users WHERE id='" + req.params.email + "'",
	function(err) {
		if(err !== null) {
			next(err);
		}
		else {
			res.redirect('back');
		}
	});
});

module.exports = router;
