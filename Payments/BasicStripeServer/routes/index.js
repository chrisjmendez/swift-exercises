var express = require('express');
var router = express.Router();

var stripe = require("stripe")( "sk_test_nN2ONy3NBWu1TLSWubvrJY1F" )
, sendgrid = require("sendgrid")("API_KEY")
, async    = require("async")
, _         = require('lodash')

/* GET home page. */
router.get('/', function(req, res, next) {
  res.render('index', { title: 'Express' });
});

router.post('/pay', function(req, res, next) {
	var stripeToken = req.body.stripeToken
	var amount      = req.body.amount
	var type        = req.body.type
	var name        = req.body.name
	
	async.auto({
		//Make sure the request has all the required params
		check_params: function(callback){
			if( _.isEmpty(stripeToken) ){
				callback(true, "Stripe Token is Empty" )
			}
			if( _.isEmpty(amount) ){
				callback(true, "No amount set." )
			}
			if( _.isEmpty(type) ){
				callback(true, "No type." )
			}
			if( _.isEmpty(name) ){
				callback(true, "No name set." )
			}
			callback(null)
		},
		charge_customer: ["check_params", function(callback){
			stripe.charges.create({
				amount: 400,
				currency: "usd",
				source: stripeToken,
				metadata: {'order_id': '6735'},
				description: "Charge for test@example.com"
			},
			{
				idempotency_key: "gFdEfikuMgp8NUvq"
			}, 
			function(err, charge) {
				if(err) throw err
				callback(null, charge)
			});		
			
		}],
		send_email: ["charge_customer", function(callback){
			var charge = callback.charge
			console.log(callback)
			var payload = {
				  to:       'test@maildrop.cc',
				  from:     'stripe@maildrop.cc',
				  subject:  'Stripe Charge Complete',
				  text:     'My first email through SendGrid.' + charge
			}
			sendgrid.send(payload, function(err, json) {
			  if (err) { return console.error(err); }
			  console.log(json);
			  callback(null)
			});
		}]
	},
	function(err, results, o) {
		if(err){
			res.json({ success: false, message: results })
		}
		res.json({success: true, message: "Great Success"})
	});

})

module.exports = router;
