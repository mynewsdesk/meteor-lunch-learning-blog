Comment = new Meteor.Collection "comments"

Comment.attachSchema new SimpleSchema {
  author:
    type: String
  email:
    type: String
    regEx: SimpleSchema.RegEx.Email
  message:
    type: String
  post_id:
    type: String
}

Comment.allow
  insert: (userId, doc) ->
    true

  update: (userId, doc, fields, modifier) ->
    true

  remove: (userId, doc) ->
    true

(global ? window).Comment = Comment
