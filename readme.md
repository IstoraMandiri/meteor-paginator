# Meteor Paginator
## Super Simple Client-Only Cursor Pagination

Demo: http://paginator.meteor.com

### Why?

Meteor apps can become slow when rendering many items in an `{{#each}}` loop. Much of this is due to expensive DOM rendering done by blaze on the initial population (especially noticeable on mobile).

I needed a no-frills, client-only pagination solution that accepted existing collections.

### Usage

Check the `/example` for a demo meteor app.

client.coffee -- `myPagination` behaves like a regular mongo collection.
```coffeescript
myCollection = new Meteor.Collection 'people'
myPagination = new Paginator myCollection

Template.myTemplate.helpers
  people : -> myPagination.find({}, {itemsPerPage:50})

# `myPagination.reset()` will set the current page to 1
# `myPagination.find().currentPage()` will return current page number, 0 indexed
```

template.html -- the `people` cursor passed to this tempalte will be paginated
```handlebars
<template name="myTemplate">

	<!-- pass the pagination to Paginator_UI for basic navigation -->
	{{> Paginator_UI people}}

	<!-- use cursor in templates as usual -->
	{{#each people}}
  		{{> person}}
	{{/each}}

	{{> Paginator_UI people}}

</template>

```

The `Paginator_UI` tempalte is automatially hidden if the page count is 1.

### Internationalization

`hitchcott:paginator` uses [tap:i18n](http://github.com/TAPevents/tap-i18n) for i18n. Current supported languages are:

* English
* Japanese
* Swedish

Pull Requests are welcome!

### TODO

* More UI Options
  * Go to End
  * Go to Start
  * Go to Specific Page
* Infinite Scolling
* Tests

### License

MIT, Jan 2015, [Chris Hitchcott](http://hitchcott.com)

[TAPevents.com](http://tapevents.com/)
