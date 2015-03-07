myCollection = new Meteor.Collection 'numbers'

if Meteor.isClient

  myPagination = new Paginator myCollection

  Template.test.helpers
    numbers : -> myPagination.find({}, {itemsPerPage:15})
    showResetButton : -> myPagination.find().currentPage() > 0


  Template.test.events
    'click .reset' : -> myPagination.reset()

if Meteor.isServer

  # seed data
  if myCollection.find().count() is 0
    for i in [0...300]
      myCollection.insert {number: i}