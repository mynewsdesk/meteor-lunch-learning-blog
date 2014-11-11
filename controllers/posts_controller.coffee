PostsController = ApplicationController.extend
  waitOn: -> [
    Meteor.subscribe("posts")
    Meteor.subscribe("comments")
    Meteor.subscribe("users")
  ]

  index: ->
    @render "PostIndex", data: Post.find()

  show: ->
    @render "PostShow", data: Post.findOne(@params._id)

  new: ->
    @render "PostNew"

  edit: ->
    @render "PostEdit", data: Post.findOne(@params._id)

(global ? window).PostsController = PostsController
