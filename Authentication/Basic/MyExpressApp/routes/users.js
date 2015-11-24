var express = require('express')
, router    = express.Router()
, async     = require('async')
, Firebase = require('firebase')

var ref = new Firebase('https://swift-example.firebaseio.com/')

/* GET users listing. */
router.get('/', function(req, res, next) {
	res.json( { success: false, message: "POST request required." } )
});

router.get('/create', function(req, res, next) {
	res.json( { success: false, message: "POST request required." } )
});


// We define a new route that will handle bookmark creation
router.post('/create', function(req, res, next) {
	
	var email     = req.body.email
	var password  = req.body.password
	var firstName = req.body.firstName
	var lastName  = req.body.lastName
	var zipCode   = req.body.zipCode

	async.auto({
		create_user: [function(){
			ref.createUser({
				email:    email,
				password: password,
				fname:    firstName,
				lname:    lastName,
				zipcode:  zipCode
			}, function(error, userData) {
				if (error) {
					var m = "Error creating user: " + error
					res.json({ success: "false", message: m });
				} else {
					var m = "Successfully created user account with uid: " + userData.uid
					res.json({ success: "true", message: m });
				}
			})
		}]
	},
	function(err, results, o) {
		if(err) console.log(err)
			console.log(results, o)
	});
});

router.post('/login', function(req, res, next) {
	var email    = req.body.email
	var password = req.body.password

	ref.authWithPassword({
		email    : email,
		password : password
	}, function(error, authData) {
		if (error) {
			console.log("Login Failed!", error);
		} else {
			console.log("Authenticated successfully with payload:", authData);
		}
	});
})

// We define another route that will handle bookmark deletion
router.post('/delete/:id', function(req, res, next) {
	var email    = req.body.email
	var password = req.body.password
	
	ref.removeUser({
		email    : email,
		password : password
	}, function(error) {
		if (error === null) {
			console.log("User removed successfully");
		} else {
			console.log("Error removing user:", error);
		}
	});
		
});

module.exports = router;
