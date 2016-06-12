Template.medimgReports.onCreated ->
  increment = 20
  option={}
  option['limit']=100
  Session.set('medimgReportReportPara', {})
  Session.set('medimgReportOptionPara', option)
  instance = this
  instance.query = new ReactiveVar()
  instance.limit = new ReactiveVar(increment)
Template.medimgReports.onRendered ->
  config =
    '.chosen-select': {width:100}
    '.chosen-select-deselect': allow_single_deselect: true
    '.chosen-select-no-single': disable_search_threshold: 10
    '.chosen-select-no-results': no_results_text: 'Oops, nothing found!'
    '.chosen-select-width': width: '95%'
  for selector of config
    $(selector).chosen config[selector]
  console.log(this)
  $('#reportrange span').html moment().format('YYYY/MM/DD') + ' - ' + moment().format('YYYY/MM/DD')
  $('#reportrange #start').val moment().format('YYYY/MM/DD')
  $('#reportrange #end').val moment().format('YYYY/MM/DD')
  startTime = $('#start').val()
  endTime = $('#end').val()
  state =$("input[type='radio']:checked").val()
  str = {}
  if startTime
    str['startTime'] = new Date(startTime)
  if endTime
    end = new Date(endTime)
    end.setDate(end.getDate()+1)
    str['endTime'] =end
  if state
    str['state'] =state
  depId=''
  if Meteor.userId()
    if Meteor.user()?.profile?.doctor?
      depId = Meteor.user()?.profile?.doctor?.depid
    if Meteor.user()?.profile?.patient?
      depId = Meteor.user()?.profile?.patient?.depid
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
    state = $("input[type='radio']:checked").val()
    str = {}
    mydate = new Date()
    if startTime
      mydate.setFullYear(startTime)
      str['startTime'] = start._d
    if endTime
      mydate.setFullYear(endTime)
      str['endTime'] = end._d
    if state
      str['state'] =state
    if Meteor.user()?.profile?.doctor?.depid?
      depId = Meteor.user()?.profile?.doctor?.depid
    if Meteor.user()?.profile?.patient?.depid?
      depId = Meteor.user()?.profile?.patient?.depid
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
    if Meteor.user()?.profile?.doctor?
      if reg.state
        selector['state']=reg.state
    if Meteor.user()?.profile?.nurse?
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
        fee: 1
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
          fee: 1
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
  return


Template.medimgReports.helpers
  isWS:->
    Template.instance().data?.ws
  'medimgReports': ->
#    reg = Template.instance().query.get()
#    if reg?
#      sql = {'si':reg}
#      Laniakea.Collection.MedimgReports.find(sql,{sort:{st:-1}})
#    else
    Laniakea.Collection.MedimgReports.find({},{sort:{st:-1}})
Template.medimgReports.events
  'click a[href=#showmedimgReportModal]':(e,t)->
    Session.set('selectedReport',@_id)
  'input [name=usReportsQueryPara]':(e,t)->
    e.preventDefault();
    text = t.$(e.target).val()?.trim()
    if text?
#      reg = new RegExp(text, 'i')
      Template.instance().query.set(text)
  'change input[name=state]':(e,t)->
    Session.set('selectedReport',null)
    e.preventDefault()
    searchReportMethod(t)
  'click  #showmedimgReportModalDiv1':(e,t)->
    Router.go("/uscapture/"+ this._id)
    document.title = "{\"action\":\"StartEditReport\",\"id\":\""+@._id+"\"}"
  'keydown [name=usReportsQueryPara]':(e,t)->
    if(event.which == 13 )
      e.preventDefault();
      false

searchReportMethod = (t)->
  startTime = t.$('#start').val()
  endTime = t.$('#end').val()
  state = t.$("input[type='radio']:checked").val()
  str = {}
  if startTime
    str['startTime'] = new Date(startTime)
  if endTime
    end = new Date(endTime)
    end.setDate(end.getDate()+1)
    str['endTime'] =end
  if state
    str['state'] =state
  if Meteor.user()?.profile?.doctor?.depid?
    depId = Meteor.user()?.profile?.doctor?.depid
  if Meteor.user()?.profile?.patient?.depid?
    depId = Meteor.user()?.profile?.patient?.depid
  if Meteor.user()?.profile?.nurse?.depid?
    depId = Meteor.user()?.profile?.nurse?.depid
  str['depId']=depId
  Session.set('medimgReportReportPara',str)
