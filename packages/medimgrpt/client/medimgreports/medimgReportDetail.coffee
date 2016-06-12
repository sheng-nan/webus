#Template.medimgReportDetail.onRendered ->
##  $('#showmedimgReportModal').appendTo("body")
#  instance = Template.instance()
#  instance.autorun ->
#    instance.subscribe "singleMedimgReport", Session.get('selectedReport')
Template.medimgReportDetail.helpers
  'equals':(a, b) ->
    a == b
  selectedReport:->
    Laniakea.Collection.MedimgReports.findOne Session.get('selectedReport')
#  hos:->
#    hos=''
#    if Meteor.user()?.profile?.doctor?
#      hos = Meteor.user()?.profile?.doctor?.hos
#    if Meteor.user()?.profile?.nurse?
#      hos = Meteor.user()?.profile?.nurse?.hos
##    Meteor.user()?.profile?.patient?.hos
#    return hos
Template.medimgReportDetail.events

  'click #reportPrint':->
    ###bdhtml = window.document.body.innerHTML
    #获取当前页的html代码
    sprnstr = '<!--startprint1-->'
    #设置打印开始区域
    eprnstr = '<!--endprint1-->'
    #设置打印结束区域
    prnhtml = bdhtml.substring(bdhtml.indexOf(sprnstr) + 18)
    #从开始代码向后取html
    prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr))
    #从结束代码向前取html
    window.document.body.innerHTML = prnhtml
    window.print()
    window.document.body.innerHTML = bdhtml###
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

    return true;

#'click #reportPrint':->
#    console.log('print')
#    bdhtml = window.document.body.innerHTML
#    #获取当前页的html代码
#    sprnstr = '<!--startprint1-->'
#    #设置打印开始区域
#    eprnstr = '<!--endprint1-->'
#    #设置打印结束区域
#    prnhtml = bdhtml.substring(bdhtml.indexOf(sprnstr) + 18)
#    #从开始代码向后取html
#    prnhtml = prnhtml.substring(0, prnhtml.indexOf(eprnstr))
#    #从结束代码向前取html
#    window.document.body.innerHTML = prnhtml
#    window.print()
#    window.document.body.innerHTML = bdhtml