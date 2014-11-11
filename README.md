Lunch Learning Blog
===================

A blog created during Meteor lunch learning at Mynewsdesk.

## Prerequisites

Install node

    brew install node

Install Meteor

    curl https://install.meteor.com/ | sh

Install stardust generator

    npm install -g generator-stardust

Steps for reproducing the blog
==============================

## Create app
- `meteor create awesome-blog`
- Show app
- Remove files

## Initialise app
- `yo stardust`
- Show app / filestructure

## Scaffold post
- `yo stardust:scaffold post title:string body:string`
- Paste routes
- Redirect root
- Remove old index.html / index.coffee
- New post
- Set rows=8
- Add post with some body
- Set {{title}} in index

## PostsShow

- Set {{title}} and {{body}} in show.html
- `meteor add markdown`
- Set {{#markdown}}{{body}}{{/markdown}}

## Add comments
- `yo stardust:model comment author:string email:string message:string post_id:string`
- `regEx: SimpleSchema.RegEx.Email` in message definition
- Subscribe to comments in posts controller
- Add comments method to post.coffe transform
- Add comments stuff to the post view

```handlebars
<h2>Comments</h2>
{{#each comments}}
  <div class="comment">
    <strong>{{author}}</strong> <small>says...</small><br>
    {{#markdown}}{{message}}{{/markdown}}
  </div>
{{/each}}
```

- Add a comment via console

```js
Comment.insert({author: "David Backeus", email: "duztdruid@gmail.com", message: "Awesome post you got there!", post_id: ""})
```

## Add comments form

```handlebars
<h3>Add a Comment</h3>
{{#autoForm collection="Comment" type="insert" id="new-comment-form"}}
  {{> afQuickField name="author"}}
  {{> afQuickField name="email"}}
  {{> afQuickField name="message" rows=4}}
  {{> afFieldInput type="hidden" name="post_id" value=_id}}
  <button type="submit" class="btn btn-primary">Add Comment</button>
{{/autoForm}}
```

- Add a comment
- Basic blog complete!

Authentication and Authorization
================================

## Accounts
- meteor add accounts-google ian:accounts-ui-bootstrap-3
- Configure google auth
- Sign in
- Sign out

## cosmetic security
- `yo stardust:helper signedIn`
- Add Meteor.userId() in the helper
- Add conditionals to index.html
- `{{#if signedIn}}` for edit/delete/new buttons
- Manually navigate to the new/edit pages
- Add before filter to router.coffee

```coffeescript
authenticate = ->
  if Meteor.userId()
    @next()
  else
    @redirect "/"

Router.onBeforeAction authenticate, only: ["new_post", "edit_post"]
```

- Display we can still mess it up in the console

## Real security

- add actual security in collections/post.coffee
- userId check in all allows

## Own your posts

- Add user_id to post.coffee

```coffeescript
user_id:
  type: String
  autoValue: -> Meteor.userId()
```

- Publish users and subscribe to them
- Add helper to index.coffee

```coffeescript
authorName: ->
  Meteor.users.findOne(@user_id).profile.name
```
- Demonstrate problem with updating stuff

# Secure updating with ownership

- fix Post allow block

```coffeescript
userId && userId == doc.user_id
```

- Create owner helper in index.coffee

```coffeescript
owner: ->
  Meteor.userId() == @user_id
```

- Change `{{#if signedIn}}` to `{{#if owner}}`
- And we should be safe!

Deploy it!
==========

- `meteor deploy awesomeblog`

One more thing!
===============

- `meteor add-platform ios`
- `meteor run ios`
