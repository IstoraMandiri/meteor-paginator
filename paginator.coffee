class Paginator
  constructor: (collection) ->
    unless collection?.find
      throw new Error 'Paginator only accepts collections with a `find` method, at the moment'

    currentPageVar = new ReactiveVar(0)

    @reset = -> currentPageVar.set(0)

    @find = (query={}, options={}) ->
      if options.limit || options.skip
        console.warn '`limit` and `skip` ignored due to pagination'

      currentPage = -> currentPageVar.get()

      itemsPerPage = options.itemsPerPage || 10

      options.limit = itemsPerPage
      options.skip = currentPage() * itemsPerPage

      cursor = collection.find(query, options)

      # UI Helpers

      cursor.currentPage = currentPage
      cursor.totalPages = -> Math.ceil(collection.find(query).count() / itemsPerPage)
      cursor.goToPage = (pageNumber) ->
        # check if page exists before setting
        if pageNumber >= 0 and pageNumber < cursor.totalPages()
          currentPageVar.set(pageNumber)

      return cursor


if Meteor.isClient

  Template.Paginator_UI.helpers
    currentPagei18n: -> @currentPage() + 1
    showUI: -> @totalPages() > 1
    isCurrentPageFirst: -> @currentPage() is 0
    isCurrentPageLast: -> @currentPage() is @totalPages() - 1

  Template.Paginator_UI.events
    'click .paginator-prev': -> @goToPage @currentPage() - 1
    'click .paginator-next': -> @goToPage @currentPage() + 1


