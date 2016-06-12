Template.modifySingleReport.onRendered ->
  h =$('.report_height').height()
  $('.rizhi_height').height(h)
#  $('#showmedimgReportModal').appendTo("body")
  instance = Template.instance()
  instance.autorun ->
    instance.subscribe "singleMedimgReport", Session.get('selectedReport')
    selectId=Session.get('selectedReport')
    $('#'+selectId).addClass 'active'
Template.modifySingleReport.helpers
  reportLogSchema:->
    Laniakea.Schema.ReportLog
  selectedReport:->
    Laniakea.Collection.MedimgReports.findOne Session.get('selectedReport')
  curruserid:->
    Meteor.userId()
  currusername:->
    Meteor.user()?.username
#Template.modifySingleReport.events
#  'click #saveBut':(e,t)->
#    e.preventDefault()
##    t.$('#modifyForm').submit()
#    t.$('#log_action').val('保存')
#    t.$('#log_userid').val(Meteor.userId())
#    t.$('#log_user').val(Meteor.user()?.username)
#    doc = AutoForm.getFormValues('logForm').insertDoc
#    reportId =  Session.get('selectedReport')
#    Laniakea.Collection.MedimgReports.update({_id:reportId},{$set:{state:'已保存'},$push:{logs:doc}})
#    Session.set('selectedReport',null)