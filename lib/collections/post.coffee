Post = new Meteor.Collection "posts", transform: (model) ->
  model.comments = ->
    Comment.find post_id: @_id
  model

Post.attachSchema new SimpleSchema {
  title:
    type: String
  body:
    type: String
  user_id:
    type: String
    autoValue: -> Meteor.userId()
}

Post.allow
  insert: (userId, doc) ->
    userId && userId == doc.user_id

  update: (userId, doc, fields, modifier) ->
    userId && userId == doc.user_id

  remove: (userId, doc) ->
    userId && userId == doc.user_id

(global ? window).Post = Post
