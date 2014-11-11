Template.PostIndex.helpers
  authorName: ->
    Meteor.users.findOne(@user_id).profile.name

  owner: ->
    Meteor.userId() == @user_id

Template.PostIndex.events
  "click [data-action=delete]": ->
    Post.remove @_id

Template.PostIndex.rendered = ->
