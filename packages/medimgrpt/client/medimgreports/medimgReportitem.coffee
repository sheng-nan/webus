Template.medimgReportItem.onCreated ->
  Session.set('selectedReport',null)
Template.medimgReportItem.events
  'click a[href=#showmedimgReportModal]':(e,t)->
    Session.set('selectedReport',@_id)
Template.medimgReportItem.helpers
  'equals':(a, b) ->
    a == b
Template.medimgReportItem.rendered = ->
  this.$('.r_content').slimscroll
    height: 90
    alwaysVisible: true
    color: '#999999'
    wheelStep: 2
