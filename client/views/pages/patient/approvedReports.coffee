Template.approvedReports.onCreated ->
  Session.set('selectedReport',null)
Template.approvedReports.events
  'click a[href=#showmedimgReportModal]':(e,t)->
    Session.set('selectedReport',@_id)