/* ** ** ** ** ** ** **
* App config file
* 
* Since we're using OpenShift for our server, here's a list of 
*	Environmental Variables that will assign the constants below.
*	https://developers.openshift.com/en/managing-environment-variables.html
* 
* 
* Firebase: How does this all work?
* MongoDB is great but Firebase continually proves to be easier to develop and
*	manage, friendlier on the eyes (UIX-wise), and easier to download data and manipulate.
*	The { firebase: null } param is where we store the firebase connection when it's assigned
* 	on /libs/Model.js
*	
* ** ** ** ** ** ** **/
var path     = require('path')
//Path:        /path/to/app.js/from/config/
, rootPath = path.normalize(__dirname + "/../")

module.exports = { 
	//DEVELOPMENT
    development: {
        rootPath: rootPath,
        port:     process.env.PORT || 8080,
        ip:       process.env.HOST || "localhost",
		clients: [
			{ id: 0000, name: "test", api_key: "xxxxxxxxxx", source: "web", path: "https://liveinsights-test.firebaseio.com" },
			{ id: 0001, name: "flurry", api_key: "xxxxxxxxxx", source: "web", path: "https://liveinsights-test.firebaseio.com" },
			{ id: 5200, name: "test", api_key: "a8485a6b94", source: "web", path: "https://uscradio.firebaseio.com" }
		]
    },
	//PRODUCTION
    production: {
        rootPath: rootPath,
        port:     process.env.OPENSHIFT_NODEJS_PORT || 80,
        ip  :     process.env.OPENSHIFT_NODEJS_IP,
		clients: [
			//Skyground Media Clients
			{ id: 1000, name: "guitarpick", api_key: "8592d2g759", source: "ios", path: "https://guitarpick-ios.firebaseio.com" },
			
			//USC Radio Clients
			{ id: 2000, name: "geotunes", api_key: "be754g62e8", source: "ios", path: "https://uscradio.firebaseio.com" },
			{ id: 6279, name: "kusc", api_key: "735ea289a5", source: "ios", path: "https://uscradio.firebaseio.com" },
			{ id: 5000, name: "kdfc", api_key: "798gg321a5", source: "ios", path: "https://uscradio.firebaseio.com" },
		]
    }
 }