# Description

For every request hitting the server, ApiRequest will verify if the request is valid

Each request received is supposed to have a token inside the header of the request
this token must be the same as the one initially created and sent to the client when client's credentials were verified

### Steps to validate the request
1. check if header has an authorisation key otherwise error of missing token
2. decode the token inside the header otherwise error of invalid token
3. find the user based on the user_id key of the decoded token other return an ActiveRecord::RecordNotFound error
4. return this user

# Tests
In order to test, we must have
1. a user -> generate user
2. a token -> generate token
3. a valid request -> header with an authorisation key point to the token
  3.a a valid token
  3.b an invalid token
4. an invalid request -> header without authorisation key

number of tests
1. [valid] valid call and valid token -> user
2. [invalid] invalid call i.e. no header -> missing token error
3. [invalid] valid call and invalid token -> invalid token error
4. [invalid] valid call and expired token -> expired token error
