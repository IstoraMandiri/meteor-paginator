console.log 'paginator has landed'
# API

myPagination = new Paginator collection, query, options

Template.x.helpers
  gallery : -> myPagination()


# Tempalte
"""
{{> Paginator_UI gallery}}

{{#each gallery}}
  {{> YourTempalte}}
{{/each}}

{{> Paginator_UI gallery}}
"""
