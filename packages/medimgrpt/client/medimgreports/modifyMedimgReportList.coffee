Template.modifyMedimgReportList.onCreated ->
  Session.set('selectedReport',null)

Template.modifyMedimgReportList.onRendered ->
#  $('#showmedimgReportModal').appendTo("body")

  Session.set('selectedReport',Laniakea.Collection.MedimgReports.findOne()?._id)
  $('body').addClass 'fixed-sidebar'
  $('body').addClass 'full-height-layout'
  # Set the height of the wrapper
  $('#page-wrapper').css 'min-height', $(window).height() + 'px'
  # Add slimScroll to element
  $('.full-height-scroll').slimscroll height: '100%'
  # Add slimScroll to left navigation
  $('.sidebar-collapse').slimScroll
    height: '100%'
    railOpacity: 0.9
    alwaysVisible:true
#  selectId=Session.get('selectedReport')
#  $('#'+selectId).addClass 'active'

Template.modifyMedimgReportList.helpers
  isWS:->
    Template.instance().data?.ws
  'medimgReports': ->

    Laniakea.Collection.MedimgReports.find()
  'reportCount':->
    if Laniakea.Collection.MedimgReports.find().count()>0
      true
    else
      false


Template.modifyMedimgReportList.events
  'click a[href=#tab-1]':(e,t)->
    Session.set('selectedReport',@_id)

Template.modifyMedimgReportList.onDestroyed ->
  $('body').removeClass 'fixed-sidebar'
  $('body').removeClass 'full-height-layout'
  # Destroy slimScroll for left navigation
  $('.sidebar-collapse').slimScroll destroy: true
  # Remove inline style form slimScroll
  $('.sidebar-collapse').removeAttr 'style'
  $('#page-wrapper').removeAttr 'style'