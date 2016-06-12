Template.printMedimgReportList.onCreated ->
  Session.set('selectedReport',null)
  increment = 20
  option={}
  option['limit']=12
  Session.set('medimgReportReportPara', {})
  Session.set('medimgReportOptionPara', option)
  instance = this
  instance.query = new ReactiveVar()
  instance.limit = new ReactiveVar(increment)

Template.printMedimgReportList.onRendered ->
  $('body').addClass 'fixed-sidebar'
  $('body').addClass 'full-height-layout'
  $('#page-wrapper').css 'min-height', $(window).height() + 'px'
  $('.full-height-scroll').slimscroll height: '100%'
  $('.sidebar-collapse').slimScroll
    height: '100%'
    railOpacity: 0.9
    alwaysVisible:true
  #  selectId=Session.get('selectedReport')
  #  $('#'+selectId).addClass 'active'

  Session.set('selectedReport',null)
  $('#reportrange span').html moment().format('YYYY/MM/DD') + ' - ' + moment().format('YYYY/MM/DD')
  $('#reportrange #start').val moment().format('YYYY/MM/DD')
  $('#reportrange #end').val moment().format('YYYY/MM/DD')
  startTime = $('#start').val()
  endTime = $('#end').val()
  str = {}
  if startTime
    str['startTime'] = new Date(startTime)
  if endTime
    end = new Date(endTime)
    end.setDate(end.getDate()+1)
    str['endTime'] =end
  depId=''
  if Meteor.userId()
    if Meteor.user()?.profile?.nurse?
      depId = Meteor.user()?.profile?.nurse?.depid
  str['depId']=depId
  Session.set('medimgReportReportPara',str)
  $('#reportrange').daterangepicker {
    format: 'YYYY/MM/DD'
    startDate: moment()
    endDate: moment()
    minDate: '2012/01/01'
    maxDate: '2018/12/31'
    dateLimit: days: 60
    showDropdowns: true
    showWeekNumbers: true
    timePicker: false
    timePickerIncrement: 1
    timePicker12Hour: true
    ranges:
      '今天': [
        moment()
        moment()
      ]
      '昨天': [
        moment().subtract(1, 'days')
        moment().subtract(1, 'days')
      ]
      '前7天': [
        moment().subtract(6, 'days')
        moment()
      ]
      '前30天': [
        moment().subtract(29, 'days')
        moment()
      ]
      '这个月': [
        moment().startOf('month')
        moment().endOf('month')
      ]
      '上个月': [
        moment().subtract(1, 'month').startOf('month')
        moment().subtract(1, 'month').endOf('month')
      ]
    opens: 'right'
    drops: 'down'
    buttonClasses: [
      'btn'
      'btn-sm'
    ]
    applyClass: 'btn-primary'
    cancelClass: 'btn-default'
    separator: ' to '
    locale:
      applyLabel: '确定'
      cancelLabel: '取消'
      fromLabel: '从'
      toLabel: '到'
      customRangeLabel: '自定义'
      daysOfWeek: [
        '周日'
        '周一'
        '周二'
        '周三'
        '周四'
        '周五'
        '周六'
      ]
      monthNames: [
        '一月'
        '二月'
        '三月'
        '四月'
        '五月'
        '六月'
        '七月'
        '八月'
        '九月'
        '十月'
        '十一月'
        '十二月'
      ]
      firstDay: 1
  }, (start, end, label) ->
    Session.set('selectedReport',null)
    $('#reportrange span').html start.format('YYYY/MM/DD') + ' - ' + end.format('YYYY/MM/DD')
    $('#reportrange #start').val start.format('YYYY/MM/DD')
    $('#reportrange #end').val end.format('YYYY/MM/DD')
    startTime = $('#start').val()
    endTime = $('#end').val()
    str = {}
    mydate = new Date()
    if startTime
      mydate.setFullYear(startTime)
      str['startTime'] = start._d
    if endTime
      mydate.setFullYear(endTime)
      str['endTime'] = end._d
    if Meteor.user()?.profile?.nurse?.depid?
      depId = Meteor.user()?.profile?.nurse?.depid
    str['depId']=depId
    Session.set('medimgReportReportPara',str)
  instance = Template.instance()
  instance.autorun ->
    limit = instance.limit.get()
    si = instance.query.get()
    reg = Session.get('medimgReportReportPara')
    #    opt = Session.get('medimgReportOptionPara')
    selector={}
    if si?
      selector['si']=si
    if reg.depId
      selector['depid']=reg.depId
#    if Meteor.user()?.profile?.doctor?
#      console.log('doctor')
#    if Meteor.user()?.profile?.nurse?
#      console.log('nurse')
      selector['state']={
        '$in':['已审核','已打印']
      }

    if reg.startTime && reg.endTime
      selector['$and']= [{'st':{'$gte':reg.startTime}},{'st':{'$lte':reg.endTime}}]
    option=
      sort: {st: -1}
      fields:
        pat:1
        age:1
        sex:1
        st:1
        exmpt:1
        exmitm:1
        apldoc:1
        doc:1
        si:1
        state:1
    if limit
      option=
        sort: {st: -1}
        limit:limit
        fields:
          pat:1
          age:1
          sex:1
          st:1
          exmpt:1
          exmitm:1
          apldoc:1
          doc:1
          si:1
          state:1
    instance.subscribe "medimgReports", selector,option
    $(window).scroll ->
#      文档高度                滚动条高度               浏览器高度
      if $(document).height() - $(window).scrollTop() - $(window).height()<300
        limit = instance.limit.get()
        count = Laniakea.Collection.MedimgReports.find().count()
        hasMore = count == limit
        limit =  if hasMore then (limit + 20) else count
        instance.limit.set(limit)

  #  $('#showmedimgReportModal').appendTo("body")
  Session.set('selectedReport',Laniakea.Collection.MedimgReports.findOne()?._id)



Template.printMedimgReportList.helpers
  isWS:->
    Template.instance().data?.ws
  'medimgReports': ->
    Laniakea.Collection.MedimgReports.find()
  'reportCount':->
    if Laniakea.Collection.MedimgReports.find().count()>0
      true
    else
      false

Template.printMedimgReportList.events
  'click a[href=#tab-1]':(e,t)->
    Session.set('selectedReport',@_id)
  'input [name=usReportsQueryPara]':(e,t)->
    e.preventDefault();
    text = t.$(e.target).val()?.trim()
    if text?
#      reg = new RegExp(text, 'i')
      Template.instance().query.set(text)
  'keydown [name=usReportsQueryPara]':(e,t)->
    if(event.which == 13 )
      e.preventDefault();
      false

Template.printMedimgReportList.onDestroyed ->
  $('body').removeClass 'fixed-sidebar'
  $('body').removeClass 'full-height-layout'
  $('.sidebar-collapse').slimScroll destroy: true
  $('.sidebar-collapse').removeAttr 'style'
  $('#page-wrapper').removeAttr 'style'
