Template.operationMedimgReportItem.onCreated ->
  Session.set('selectedReport',null)
Template.operationMedimgReportItem.events
  'click a[href=#tab_1]':(e,t)->
    Session.set('selectedReport',@_id)
Template.operationMedimgReportItem.rendered = ->
  this.$('.r_content').slimscroll
    height: 90
    alwaysVisible: true
    color: '#999999'
    wheelStep: 2