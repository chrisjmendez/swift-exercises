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
			{ id: 0000, name: "test", api_key: "xxxxxxxxxx", source: "web", path: "https://swift-example.firebaseio.com" },
		]
    },
	//PRODUCTION
    production: {
        rootPath: rootPath,
        port:     process.env.OPENSHIFT_NODEJS_PORT || 80,
        ip  :     process.env.OPENSHIFT_NODEJS_IP,
		clients: [
		]
    }
 }