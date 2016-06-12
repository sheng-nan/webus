Template.consultationList.helpers
  consListExist:(status)->
    docId=Meteor.userId()
    Laniakea.Collection.Consultations.find({$or:[{prmdocid:docId},{'condocs._id':docId}],$and:[{constatus:status}]}).count()>0
  consList:(status)->
     docId=Meteor.userId()
     Laniakea.Collection.Consultations.find({$or:[{prmdocid:docId},{'condocs._id':docId}],$and:[{constatus:status}]})
  conStatus:(status)->
    Laniakea.Collection.Consultations.findOne(Template.instance().selectedConsultation?.get()?._id)?.constatus is status
  isPrmdoc:(con)->
    con?.prmdocid is Meteor.userId()
  conInvalite:(docid)->
    Laniakea.Collection.Consultations.find({$or:[{prmdocid:docId},{'condocs._id':docId}],$and:[{constatus:'待会诊'}]})
  selectedConsultation:->
    Template.instance().selectedConsultation?.get()
Template.consultationList.onCreated ->
  instance = this
  instance.selectedConsultation = new ReactiveVar()
Template.consultationList.events
  'click a[href=#tab-1]':(e,t)->
    Template.instance().selectedConsultation.set(@)
Template.consultationList.onRendered ->
  $('body').addClass 'fixed-sidebar'
  $('body').addClass 'full-height-layout'
# Set the height of the wrapper
  $('#page-wrapper').css 'min-height', $(window).height() + 'px'
# Add slimScroll to element
  $('.full-height-scroll').slimscroll height: '100%'
Template.consultationList.onDestroyed ->
  $('body').removeClass 'fixed-sidebar'
  $('body').removeClass 'full-height-layout'
  $('#page-wrapper').removeAttr 'style'

