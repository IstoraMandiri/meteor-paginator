# Meteor Paginator
## Super Simple Client-Only Cursor Pagination

### Why?

Meteor apps can become slow when rendering many items in an `{{#each}}` loop. Much of this is due to expensive DOM rendering done by blaze on the initial population (especially noticeable on mobile).

I needed a no-fills, client-only pagination solution that accepted existing collections.

### Usage

client.coffee -- `myPagination` behaves like a regular mongo collection.
```coffeescript
myCollection = new Meteor.Collection 'people'
myPagination = new Paginator myCollection

Template.myTemplate.helpers
  people : -> myPagination.find({}, {itemsPerPage:50})

# `myPagination.reset()` will set the current page to 1
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

### TODO

* More UI Options
* Infinite Scolling
* tap:i18n
* Example App


### License

MIT, Jan 2015, [Chris Hitchcott](http://hitchcott.com)

[TAPevents.com](http://tapevents.com/)
