class Paginator
  constructor: (collection) ->
    unless collection?.find
      throw new Error 'Paginator only accepts collections with a `find` method, at the moment'

    currentPageVar = new ReactiveVar(0)

    @reset = -> currentPageVar.set(0)

    @find = (query={}, options={}) ->
      if options.limit || options.skip
        console.warn '`limit` and `skip` ignored due to pagination'

      currentPage = ->
        currentPageVar.get()


      itemsPerPage = options.itemsPerPage || 10

      options.limit = itemsPerPage
      options.skip = currentPage() * itemsPerPage

      cursor = collection.find(query, options)

      # UI Helpers
      cursor.currentPage = currentPage
      cursor.totalPages = -> Math.ceil(collection.find(query).count() / itemsPerPage)

      i = 0
      while i < cursor.totalPages()
        if @pages[i] != undefined
          @pages[i].active = i is cursor.currentPage()
          i++
          continue
        @pages.push {
          num: i,
          active: i is cursor.currentPage(),
          show: i < 5
        }
        i++
      cursor.pages = @pages

      cursor.goToPage = (pageNumber) ->
        oldPage = currentPageVar.get()
        # check if page exists before setting
        if pageNumber >= 0 and pageNumber < cursor.totalPages()
          currentPageVar.set(pageNumber)
        if pageNumber > oldPage && !cursor.pages[pageNumber].show
          cursor.pages[pageNumber].show = true
          page = _.find(cursor.pages, (e) -> return e.show)
          page.show = false
        if pageNumber < oldPage && !cursor.pages[pageNumber].show
          cursor.pages[pageNumber].show = true
          cursor.pages.reverse()
          page = _.find(cursor.pages, (e) -> return e.show)
          page.show = false
          cursor.pages.reverse()
      return cursor
  pages : []


if Meteor.isClient

  Template.Paginator_UI.helpers
    currentPagei18n: -> @currentPage() + 1
    showUI: -> @totalPages() > 1
    isCurrentPageFirst: -> @currentPage() is 0
    isCurrentPageLast: -> @currentPage() is @totalPages() - 1

  Template.Paginator_UI.events
    'click .paginator-prev': -> @goToPage @currentPage() - 1
    'click .paginator-next': -> @goToPage @currentPage() + 1

  Template.bootstrap_paginator.helpers
    showUI: -> @totalPages() > 1
    disablePrev: ->
      if @currentPage() is 0
        return "disabled"
    disableNext: ->
      #Workaround for compilation issue (@totalPages() -1 is compiling to @totalPages()(-1) and trying to call the value as a function)
      pageTotal = @totalPages()
      pageTotal--
      if @currentPage() is pageTotal
        return "disabled"


  Template.bootstrap_paginator.events
    'click .paginator-prev': ->
      @goToPage @currentPage() - 1
    'click .paginator-next': ->
      @goToPage @currentPage() + 1
    'click li[data-page]': (e) -> @goToPage $(e.target).data "page"

  Template.page.helpers
    activeClass: ->
      if @active
        return "active"
    displayNum: ->
      return @num + 1