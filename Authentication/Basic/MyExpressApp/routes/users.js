var express = require('express')
, router    = express.Router()
, async     = require('async')
, Firebase  = require('firebase')
, _         = require('lodash')

// Assign Firebase DB
var ref;
router.init = function( config ){
	var dbPath = config.clients[0].path

	ref = new Firebase(dbPath)
}


router.get('/', function(req, res, next) {
	res.json( { success: false, message: "POST request required." } )
});


// Create user
router.get('/create', function(req, res, next) {
	res.json( { success: false, message: "POST request required." } )
});


// Create user
router.post('/create', function(req, res, next) {
	
	//Fundamentals
	var email     = req.body.email
	var password  = req.body.password
	//Attributes
	var firstName = req.body.firstName
	var lastName  = req.body.lastName
	var zipCode   = req.body.zipCode

	async.auto({
		create_user: function(callback){
			ref.createUser({
				email:    email,
				password: password
			}, function(error, userData) {
				if (error) {
					switch (error.code) {
					case "EMAIL_TAKEN":
						var m = "The new user account cannot be created because the email is already in use.";
						res.json({ success: "false", message: m });
						break;
					case "INVALID_EMAIL":
						var m = "The specified email is not a valid email.";
						res.json({ success: "false", message: m });
						break;
					default:
						var m = "Error creating user: " + error;
						res.json({ success: "false", message: m });
					}
				} else {
					var m = "Successfully created user account with uid: " + userData.uid
					callback(null, userData)
				}
			})
		},
		add_attributes: [ 'create_user', function(callback, obj){
			//User Token
			var userData = obj.create_user
			
			console.log("userData: ", userData)
			//Add Attributes
			var attributes = { 
				name_first: firstName,  
				name_last:  lastName,
				zip_code:   zipCode
			}
			
			
			function isEmpty(val){
			    return (val === undefined || val == null || val.length <= 0) ? true : false;
			}
			
			//Check to see all three are working
			if( !isEmpty(firstName) || !isEmpty(firstName) || !isEmpty(firstName) ){
				//Access the User data
				var usersRef = ref.child("users");
					usersRef.set(attributes, function(error) {
						if (error) {
							var m = 'Synchronization failed'
							res.json({ success: "false", message: m, data: userData.uid });
						} else {
							var m = 'Synchronization succeeded'
							res.json({ success: "true", message: m, data: userData.uid });
						}
					})
			}
			//Respond back
			else{
				var m = "Error creating user: Please Fill out All Fields ";
				res.json({ success: "false", message: m });
			}
		}]
	},
	function(err, results, o) {
		if(err){
			console.error("Routes:users:err: ", results )
			res.json({ success: false })		
		}else{
			console.log("Routes::users: success", results)
			res.json({ success: true })		
		}
	});
});


// Log In
router.post('/login', function(req, res, next) {
	var email    = req.body.email
	var password = req.body.password
	
	async.auto({
		create_user: function(){
			ref.authWithPassword({
				email    : email,
				password : password
			}, function(error, authData) {
				if (error) {
					var m = error.toString()
					console.log("My Error:", m)
					res.json({ success: "false", message: m });
				} else {
					var m = "Authenticated successfully with payload"
					var d = JSON.stringify(authData)
					console.log(d)
					res.json({ success: "true", message: m, userToken: d });
				}
			})
		}
	},
	function(err, results, o) {
		if(err){
			console.error("Routes:users:err: ", results )
			res.json({ success: false })		
		}else{
			console.log("Routes::users: success", results)
			res.json({ success: true })		
		}
	});	
})


// Log Out
router.post('/logout', function(req, res, next) {
	
})


// Change E-mail
router.post('/update/email', function(req, res, next){
	var email    = req.body.email
	var newEmail = req.body.newemail
	var password = req.body.password

	ref.changeEmail({
		oldEmail : email,
		newEmail : newEmail,
		password : password
	}, function(error) {
		if (error === null) {
			console.log("Email changed successfully");
		} else {
			console.log("Error changing email:", error);
		}
	});
	
})


// Change Password
router.post('/update/password', function(req, res, next) {	
	var email    = req.body.email
	var password = req.body.password
	var newPassword = req.body.newpassword

	ref.changePassword({
		email       : email,
		oldPassword : password,
		newPassword : newPassword
	}, function(error) {
		if (error === null) {
			console.log("Password changed successfully");
		} else {
			console.log("Error changing password:", error);
		}
	});
});


// Reset Password
router.post('/reset/password', function(req, res, next) {	
	var email = req.body.email
	
	ref.resetPassword({
		email : email
	}, function(error) {
		if (error === null) {
			console.log("Password reset email sent successfully");
		} else {
			console.log("Error sending password reset email:", error);
		}
	});
})


// Delete User
router.get('/delete/:id', function(req, res, next) {
	var email    = req.body.email
	var password = req.body.password
	
	ref.removeUser({
		email    : email,
		password : password
	}, function(error) {
		if (error === null) {
			var m = "User removed successfully"
			res.json({ success: "true", message: m });
		} else {
			var m  = "Error removing user:" + error
			res.json({ success: "false", message: m });
		}
	});
});


module.exports = router;