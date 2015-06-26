Resources
=

User Registration Workflow
- 
1. User > Complete email address and password fields
- User > Click Sign Up
- User > Agree to the terms and conditions
- Parse > Create a PFUser object
- Parse > Send user a welcome and validation email
- App > Sign the user in

Resources
- [Logging in and logging out](http://blog.bizzi-body.com/2015/02/10/ios-swift-1-2-parse-com-tutorial-users-sign-up-sign-in-and-securing-data-part-3-or-3/)





TODO
-
Caching data, Parse has some clever caching capabilites that will improve app performance

Form validtion, you really must add validation to every place a user can type something.

Email configuration and validation, you will need to consider how you manage the email 
workflow of validating users and definitely write some nice text for the emails.

Passwords, you know that users will forget their passwords. Parse has a password reset capability - you just need to configure it and add the appropriate button to your app.

Twitter and Facebook, you can allow users to sign up using their social credentials. There are reasons why you might not want to do that, but it's there if you need it.