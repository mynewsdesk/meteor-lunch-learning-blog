Meteor.publish "comments", ->
  Comment.find()
