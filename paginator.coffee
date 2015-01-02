class @Paginator
  constructor: (collection, defaults={}) ->
    unless collection instanceof Mongo.Collection
      throw new Error 'Paginator only accepts Mongo.Collections'

    currentPageVar = new ReactiveVar(0)
    @currentPage = currentPage = -> currentPageVar.get()

    itemsPerPage = defaults.itemsPerPage || 10

    @totalItems = totalItems = (query={}) -> collection.find(query).count()
    @totalPages = -> Math.ceil(totalItems() / itemsPerPage)

    @find = (query={}, options={}) ->
      if options.limit || options.skip
        console.warn '`limit` and `skip` ignored due to pagination'

      options.limit = itemsPerPage
      options.skip = currentPage() * itemsPerPage

      return collection.find(query, options)

    # ui stuff
    @goToPage = goToPage = (pageNumber) ->
      # check if page exists before setting
      currentPageVar.set(pageNumber)

    @turnPage = (dir) -> goToPage currentPage() + dir

    # @turnPage(+/- 1) = -> console.log 'next'
    # @goToStart()
    # @goToEnd()

    return @


if Meteor.isClient
  Template.Paginator_UI.helpers
    currentPagei18n: -> @currentPage() + 1

  Template.Paginator_UI.events
    'click .paginator-prev': -> @turnPage -1
    'click .paginator-next': -> @turnPage 1


