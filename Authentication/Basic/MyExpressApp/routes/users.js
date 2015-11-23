var express = require('express');
var router = express.Router();

/* GET users listing. */
router.get('/', function(req, res, next) {
	

    db.all('SELECT * FROM users ORDER BY email', function(err, row) {
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
	var email     = req.body.email
	, first_name = req.body.firstName
	, last_name  = req.body.lastName
	, user_password = req.body.password

console.log(req.body)
  
  sqlRequest = "INSERT INTO 'users' (user_id, email, first_name, last_name, user_password) " +
               "VALUES('" + email + "', '" + first_name + "', '" + last_name + "', '" + user_password + "')"
  db.run(sqlRequest, function(err) {
    if(err !== null) {
      next(err);
    }
    else {
      res.redirect('back');
    }
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
