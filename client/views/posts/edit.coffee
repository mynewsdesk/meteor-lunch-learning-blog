Template.PostEdit.helpers()

Template.PostEdit.events()

Template.PostEdit.rendered = ->

AutoForm.hooks
  "edit-post-form":
    onSuccess: (operation, result, template) ->
      Router.go "posts"
