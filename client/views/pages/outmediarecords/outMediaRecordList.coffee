Template.outMediaRecordList.onCreated ->
  instance = this
  instance.limit = new ReactiveVar(20)
  start = new Date()
  start.setHours(0,0,0,0)
  end = new Date()
  end.setHours(23,59,59,999)
  instance.selector = new ReactiveVar({'$and':[{'digt': {'$gte': start}}, {'digt': {'$lte': end}}]})
  @autorun ->
    option =
      sort: {digt: -1}
      limit: instance.limit.get()
    Meteor.subscribe 'outMedRecords', instance.selector.get(), option

Template.outMediaRecordList.onRendered ->
  instance = Template.instance()
  $('#recordrange span').html moment().format('YYYY/MM/DD') + ' - ' + moment().format('YYYY/MM/DD')
  $('#recordrange #start').val moment().format('YYYY/MM/DD')
  $('#recordrange #end').val moment().format('YYYY/MM/DD')
  $('#recordrange').daterangepicker {
    format: 'YYYY/MM/DD'
    startDate: moment()
    endDate: moment()
    minDate: '2012/01/01'
#    maxDate: moment(new Date().setDate(new Date().getDate()+1)).format('YYYY/MM/DD')
    dateLimit:
      days: 60
    showDropdowns: true
    showWeekNumbers: false
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
    applyClass: 'btn-success'
    cancelClass: 'btn-primary'
    separator: ' to '
    locale:
      "format": "YYYY/MM/DD",
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
    $('#recordrange span').html start.format('YYYY/MM/DD') + ' - ' + end.format('YYYY/MM/DD')
    $('#recordrange #start').val start.format('YYYY/MM/DD')
    $('#recordrange #end').val end.format('YYYY/MM/DD')
    tmpselector = instance.selector.get()
    tmpselector['$and'] = [{'digt': {'$gte': start._d}}, {'digt': {'$lte': end._d}}]
    instance.selector.set(tmpselector)

  $('body').addClass 'fixed-sidebar'
  $('body').addClass 'full-height-layout'
  $('#page-wrapper').css 'min-height', $(window).height() + 'px'
  $('.full-height-scroll').slimscroll
    height: '100%',
    alwaysVisible: true

  instance.autorun ->
    if Session.get('currentoutmedrecord')
      Meteor.defer(->
        $('.full-height-scroll2').slimscroll
          height: '100%',
          alwaysVisible: true
      )

  $('.full-height-scroll').slimscroll().bind 'slimscroll',(e,pos) ->
    if pos is 'bottom'
      limit = instance.limit.get()
      if Laniakea.Collection.OutMedRecords.find().count() >= limit
        limit = limit + 10
        instance.limit.set(limit)

Template.outMediaRecordList.onDestroyed ->
  $('body').removeClass 'fixed-sidebar'
  $('body').removeClass 'full-height-layout'
  $('#page-wrapper').removeAttr('style')
  $('.blCon .col-sm-6').removeAttr('style')
Template.outMediaRecordList.helpers
  'medRecords': ->
    selector = Template.instance().selector.get()
    delete selector.si
    if selector.selectext
      selector['si'] = new RegExp(selector.selectext,'i')
    delete selector.selectext
    Laniakea.Collection.OutMedRecords.find(selector, {$sort: {digt: -1}})
  'recordCount': ->
    if Laniakea.Collection.OutMedRecords.find().count() > 0
      true
    else
      false
  'hasSelectedRecord': ->
    if Session.get('currentoutmedrecord')
      return true
    else
      return false
  'itemstatus': ->
    if Template.currentData()._id is Session.get('currentoutmedrecord')
      return 'active'

Template.outMediaRecordList.events
  'input #outMedRecordQueryParam': (e, t)->
    text = t.$(e.target).val()?.trim()
    if text?
      tmpselector = Template.instance().selector.get()
      if text is ''
        delete tmpselector.selectext
      else
        tmpselector['selectext'] = text
      Template.instance().selector.set(tmpselector)

  'click #omrItem': (e, t) ->
    Session.set('currentoutmedrecord', @_id)
  'click #addCheck':(e,t) ->
    $("#checkCon").append('<div class="panel panel-default m-t-sm">'+
                                        '<div class="panel-heading"><button class="btn btn-primary btn-xs pull-right" id="closeCheck">停止执行</button>检查预约</div>'+
                                        '<div class="panel-body">'+
                                            '<p>腹部B超</p>'+
                                        '</div>'+
                            '</div>')
    $('#appointCheckModal').modal('hide')
  'click #closeCheck':(e,t) ->
    t.$(e.target).parents('.panel').hide()