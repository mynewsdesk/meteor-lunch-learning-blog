Router.configure
  layoutTemplate: "layout"
  loadingTemplate: "loading"
  waitOn: -> [
    # Meteor.subscribe("collection")
  ]

Router.map ->
  @route "/", -> @redirect "posts"
  @route "posts", controller: "PostsController", action: "index", name: "posts"
  @route "posts/new", controller: "PostsController", action: "new", name: "new_post"
  @route "posts/:_id", controller: "PostsController", action: "show", name: "post"
  @route "posts/:_id/edit", controller: "PostsController", action: "edit", name: "edit_post"

authenticate = ->
  if Meteor.userId()
    @next()
  else
    @redirect "/"

Router.onBeforeAction authenticate, only: ["new_post", "edit_post"]
