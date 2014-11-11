Template.PostNew.helpers()

Template.PostNew.events()

AutoForm.hooks
  "new-post-form":
    onSuccess: (operation, result, template) ->
      Router.go "posts"

Template.PostNew.rendered = ->
