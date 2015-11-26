, mongoose  = require('mongoose')

var model    = {}
, clients    = []
, UserSchema = mongoose.Schema({
		displayName: {
			type: String
		},
		image:       {
			type: String
		}, 
		email:       {
			type: String
		},
		//The app timestamp is unreliable so do over
		created:     {
			type: String
		}, 
		//There will be two location points
		location:    {
			type: Object
		},
		//Strategy information will live here
		facebook:    {
			type: Object
		},
		twitter:     {
			type: Object
		},
		google:      {
			type: Object
		}
	})
/* ** ** ** ** ** ** ** * ** ** ** ** ** ** ** * 
* Assign Mongoose Schema to a model
* ** ** ** ** ** ** ** * ** ** ** ** ** ** ** **/
model.schema = mongoose.model("User", UserSchema)

/* ** ** ** ** ** ** ** * ** ** ** ** ** ** ** * 
* Initialize
* ** ** ** ** ** ** ** * ** ** ** ** ** ** ** **/
model.mongo = function(config){
	var database = "mongodb://localhost/swift-ios"
	//A. Iterate through each object within the dictionary
	for( var client in database ){
		var thisClient = database[client];
		//B. Add a Firebase connection to each client object
		//thisClient.firebase = new Firebase( thisClient.path )	
		//Create a new Array to hold the new 
		clients.push( thisClient.path );
	}
	mongoose.connect( clients[0] )
	console.log( "UserModel.mongo", clients[0] )
}
