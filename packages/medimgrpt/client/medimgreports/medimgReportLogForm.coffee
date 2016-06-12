Template.medimgReportLogForm.onRendered ->
#  $('#showmedimgReportModal').appendTo("body")
  $('#log_userid').val(Meteor.userId())
  $('#log_user').val(Meteor.user()?.username)
Template.medimgReportLogForm.helpers
  'equals':(a, b) ->
    a == b
  reportLogSchema:->
    Laniakea.Schema.ReportLog
  selectedReport:->
    Laniakea.Collection.MedimgReports.findOne Session.get('selectedReport')
  isSelected:->
    if Session.get('selectedReport')
      true
    else
      false
  curruserid:->
    Meteor.userId()
  currusername:->
    Meteor.user()?.profile?.name
Template.medimgReportLogForm.events
  'click #auditBut':(e,t)->
    e.preventDefault()
    $('#log_action').val('审核')
    doc = AutoForm.getFormValues('logForm').insertDoc
    reportId =  Session.get('selectedReport')
    report = Laniakea.Collection.MedimgReports.findOne({_id:reportId})
    Laniakea.Collection.MedimgReports.update({_id:reportId},{$set:{state:'已审核'},$push:{logs:doc}})
    Meteor.call 'saveMirs',report
    #   Router.go '/auditReports'
    Session.set('selectedReport',null)
  'click #backToBut':(e,t)->
    e.preventDefault()
    $('#log_action').val('打回')
    doc = AutoForm.getFormValues('logForm').insertDoc
    reportId =  Session.get('selectedReport')
    Laniakea.Collection.MedimgReports.update({_id:reportId},{$set:{state:'已打回'},$push:{logs:doc}})
    #   Session.set('selectedReport',Laniakea.Collection.MedimgReports.findOne()._id)
    #   Router.go '/auditReports'
    Session.set('selectedReport',null)
  'click #saveBut':(e,t)->
    e.preventDefault()
    t.$('#log_action').val('保存')
    doc = AutoForm.getFormValues('logForm').insertDoc
    reportId = Session.get('selectedReport')
    currentreport = Laniakea.Collection.MedimgReports.findOne({_id: reportId})
    if currentreport.state != '已打回'
      Laniakea.Collection.MedimgReports.update({_id: reportId}, {$set: {state: '已保存'}, $push: {logs: doc}})
    else
      upreportdoc = AutoForm.getFormValues('modifyForm').updateDoc.$set
      upreportdoc.state='已保存'
      Laniakea.Collection.MedimgReports.update({_id: reportId}, {$set: upreportdoc, $push: {logs: doc}})
    #   Router.go '/modifyReports'
    Session.set('selectedReport',null)
    $(':input','#modifyForm')
    .not(':button, :submit, :reset, :hidden')
    .val('')
    .removeAttr('checked')
    .removeAttr('selected');
  'click #medimgReportPrint':(e,t)->
    data = $('#printDiv').html()
    mywindow = window.open('', '报告打印', 'height=400,width=600');
    mywindow.document.write('<html><head><title>清华大学</title>');
    mywindow.document.write('</head><body >');
    mywindow.document.write(data);
    mywindow.document.write('</body></html>');

    mywindow.document.close();
    mywindow.focus();

    mywindow.print();
    mywindow.close();
    $('#log_action').val('打印')
    doc = AutoForm.getFormValues('logForm').insertDoc
    reportId =  Session.get('selectedReport')
    Laniakea.Collection.MedimgReports.update({_id:reportId},{$set:{state:'已打印'},$push:{logs:doc}})

    return true;
