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
	var product     = req.body.product
	var customer    = req.body.customer
	
	async.auto({
		//Make sure the request has all the required params
		check_params: function(callback){
			if( _.isEmpty(stripeToken) ){
				callback(true, "Stripe Token is Empty" )
			}
			if( _.isEmpty(amount) ){
				callback(true, "No amount set." )
			}
			if( _.isEmpty(product) ){
				callback(true, "No product type." )
			}
			if( _.isEmpty(customer) ){
				callback(true, "No name set." )
			}
			callback(null)
		},
		//Use Stripe
		charge_customer: ["check_params", function(callback){
			stripe.charges.create({
				amount: amount,
				currency: "usd",
				source: stripeToken,
				metadata: {'order_id': product },
				description: "Charge for " + customer
			}, 
			function(err, charge) {
				if(err){
					console.log(err)
					throw err
				}
				callback(null, charge)
			});		
			
		}],
		//Use this to send users an e-mail
		send_email: ["charge_customer", function(callback){
			/*
			var charge = callback.charge
			console.log("send_email:", callback)
			var payload = {
				  to:       'test@maildrop.cc',
				  from:     'stripe@maildrop.cc',
				  subject:  'Stripe Charge Complete',
				  text:     'My first email through SendGrid.' + charge
			}
			sendgrid.send(payload, function(err, json) {
			  if (err) { 
				  callback(true, err)
				  return console.error(err); 
			  }
			  console.log(json);
			  callback(null, json)
			});
			*/
			callback(null)
		}]
	},
	function(err, results, o) {
		if(err){
			//console.log(err, results)
			res.json({ success: false, message: results })
		}
		res.json({success: true, message: results })
	});

})

module.exports = router;
