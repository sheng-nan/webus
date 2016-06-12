Template.worklistHead.onCreated ->
  Session.set('queryWlName', '')
Template.worklistHead.events
  'input [id=pName]':(e,t)->
    e.preventDefault();
    pName = t.$('#pName').val().trim()
    Session.set('queryWlName',pName)

  'keydown [name=pName]':(e,t)->
    if(event.which == 13 )
      e.preventDefault();
      false


Template.worklistHead.onRendered ->
  $('#reportrange span').html moment().format('YYYY/MM/DD') + ' - ' + moment().add(29, 'days').format('YYYY/MM/DD')
  $('#reportrange #startTime').val moment().format('YYYY/MM/DD')
  $('#reportrange #endTime').val moment().add(29, 'days').format('YYYY/MM/DD')
  #  para = $('#pName').val()
  startTime = $('#startTime').val()
  endTime = $('#endTime').val()
  #  state = $('input[name=state]:checked').val()
  str = {}
  if startTime
    str['startTime'] = new Date(startTime)
  if endTime
    end = new Date(endTime)
    end.setDate(end.getDate()+1)
    str['endTime'] =end
  #  if state
  #    str['state'] =state
  Session.set('queryWlParams',str)
  #  reg = Session.get('queryWlParams')
  $('#reportrange').daterangepicker {
    format: 'YYYY/MM/DD'
    startDate: moment()
    endDate: moment().add(29, 'days')
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
      '明天': [
        moment().add('days', 1)
        moment().add('days', 1)
      ]
      '未来一周': [
        moment()
        moment().add('days', 6)
      ]
      '未来30天': [
        moment()
        moment().add(29, 'days')
      ]
      '这个月': [
        moment().startOf('month')
        moment().endOf('month')
      ]
      '下个月': [
        moment().add(1, 'month').startOf('month')
        moment().add(1, 'month').endOf('month')
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
    $('#reportrange span').html start.format('YYYY/MM/DD') + ' - ' + end.format('YYYY/MM/DD')
    $('#reportrange #startTime').val start.format('YYYY/MM/DD')
    $('#reportrange #endTime').val end.format('YYYY/MM/DD')
    #    para = $('#pName').val()
    startTime = $('#startTime').val()
    endTime = $('#endTime').val()
    #    state = $('input[name=state]:checked').val()
    str = {}
    if startTime
      str['startTime'] = new Date(startTime)
    if endTime
      end = new Date(endTime)
      end.setDate(end.getDate()+1)
      str['endTime'] =end
    #    if state
    #      str['state'] =state
    Session.set('queryWlParams',str)
    return
  $('#data_1 .input-daterange').datepicker
#    defaultViewDate: { year: 1977, month: 04, day: 25 }
    format: "yyyy-mm-dd"
    keyboardNavigation: false
    forceParse: false
    autoclose: true
  options=
    limit:10
    fields:
      patid: 1
      pat: 1
      age: 1
      sex: 1
      apmt: 1
      serv: 1
      mod: 1
      apldepid: 1
      apldep: 1
      apldocid: 1
      apldoc: 1
      docid: 1
      doc : 1
      exmpt: 1
      exmitm: 1
      fee: 1
      state: 1
      note: 1
      si:1
      desc: 1
  instance = Template.instance()
  instance.autorun ->
    reg = Session.get('queryWlParams')
    selector={}
    depId = Meteor.user()?.profile?.nurse?.depid
    if depId
      selector['apldepid']= depId
    #    if reg.state
    #      selector['state']=reg.state
    if reg.startTime && reg.endTime
      selector['$and']= [{'apmt':{'$gte':reg.startTime}},{'apmt':{'$lte':reg.endTime}}]
    instance.subscribe "subWorklists", selector, options




