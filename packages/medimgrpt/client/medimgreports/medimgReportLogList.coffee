#Template.medimgReportLogList.onCreated ->
#  Session.set('selectedReport',null)
#Template.medimgReportLogList.onRendered ->
##  $('#showmedimgReportModal').appendTo("body")
#  instance = Template.instance()
#  instance.autorun ->
#    console.log(Session.get('selectedReport'))
#    instance.subscribe "singleMedimgReport", Session.get('selectedReport')
#Template.medimgReportLogList.helpers
#  selectedReport:->
#    Laniakea.Collection.MedimgReports.findOne Session.get('selectedReport')