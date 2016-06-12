Template.worklists.onCreated ->
  $('#editWorkListModal').appendTo("body")
#时间格式化
Template.registerHelper 'formatDate', (date) ->
  moment(date).format 'YYYY-MM-DD HH:mm'
#根据日期计算年龄
Template.registerHelper 'getAge', (date) ->
  aDate = moment(new Date).format 'YYYY-MM-DD'
  thisYear = aDate.substr(0, 4)
  brith = moment(date).format 'YYYY-MM-DD'
  brith = brith.substr(0, 4)
  age = thisYear - brith
  return age

Template.worklists.helpers
  wlrCount: ->
    Laniakea.Collection.Worklists.find({'state': '预约'}).count()
  worklists_qr: ->
    str = {}
    if Session.get('queryWlName') != ''
      si = RegExp(Session.get('queryWlName'), 'i')
    else
      si = Session.get('queryWlName')
    if si
      str['si'] = si
    str['state'] = '确认'
    Laniakea.Collection.Worklists.find(str, {sort: {apmt: 1}, limit: 10})
  worklists_yy: ->
    str = {}
    if Session.get('queryWlName') != ''
      si = RegExp(Session.get('queryWlName'), 'i')
    else
      si = Session.get('queryWlName')
    if si
      str['si'] = si
    str['state'] = '预约'
    Laniakea.Collection.Worklists.find(str, {sort: {apmt: 1}, limit: 10})
  worklists_wc: ->
    str = {}
    if Session.get('queryWlName') != ''
      si = RegExp(Session.get('queryWlName'), 'i')
    else
      si = Session.get('queryWlName')
    if si
      str['si'] = si
    str['state'] = '完成'
    Laniakea.Collection.Worklists.find(str, {sort: {apmt: 1}, limit: 10})
  worklists_apl: ->
    str = {}
    if Session.get('queryWlName') != ''
      si = RegExp(Session.get('queryWlName'), 'i')
    else
      si = Session.get('queryWlName')
    if si
      str['si'] = si
    str['state'] = '检查申请'
    Laniakea.Collection.Worklists.find(str, {sort: {apmt: 1}, limit: 10})
Template.worklistHead.onRendered ->
  options=
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
      exmdepid: 1
      exmdep: 1
      apldocid: 1
      apldoc: 1
      docid: 1
      doc : 1
      exmpt: 1
      exmitm: 1
      fee: 1
      state: 1
      note: 1
      desc: 1
  instance = Template.instance()
  instance.autorun ->
    reg = Session.get('queryWlParams')
    selector={}
    depId = Meteor.user()?.profile?.nurse?.depid
    if depId
      selector['$or']= [ { apldepid: depId }, { exmdepid: depId } ]
    if reg.startTime && reg.endTime
      selector['$and']= [{'apmt':{'$gte':reg.startTime}},{'apmt':{'$lte':reg.endTime}}]
    instance.subscribe "subWorklists", selector, options
Template.worklists.events
  'submit #addWorkListForm':(e)->
    e.preventDefault()