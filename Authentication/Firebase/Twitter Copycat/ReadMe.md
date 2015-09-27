Authenticating with Firebase
=

How does it work?
- 
The first time to register with Firebase, you are automatically authenticated.  This has two function. The first is that Firebase needs both a registration and login in order to create an actual user. The second is a convenience to the user; they don't have to both manually register then log-in. 

Keeping persistence with Firebase
-
When you sign in the first time, Firebase creates an authentication ID in the application (forever) until a user logs out. 