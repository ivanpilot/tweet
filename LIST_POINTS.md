# Comments

## General
1. Comments has its own model and controller
2. A comment exists only in the context of a posts
3. The author of a comment will be called a commenter

## Comment attributes
1. id
2. description
3. commenter_id
4. post_id

## Relationship model
1. A post has many comments
2. A commenter has many comments
3. A comment belongs to a unique commenter
4. A comment belongs to a unique post

## Routing pattern
Nested under posts routes
1. /posts/:post_id/comments
2. /posts/:post_id/comments/:comment_id

## Controller
1. All except :new, :edit

## Authorization
1. Only the author of a comment can create, update and delete a comments
2. A comment is visible from everyone
3. Only a connected user can create a comment

## Validation
1. Validates description attributes
