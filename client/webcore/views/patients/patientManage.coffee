Template.patientManage.onCreated ->
  increment = 20
  instance = this
  instance.queryText = new ReactiveVar()
  instance.limit = new ReactiveVar(increment)
Template.patientManage.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    text = instance.queryText.get()
    limit = instance.limit.get()
    selector=
      text:text
      $and:[
        roles:{$in:['patient']}
        'profile.patient.hosids':Meteor.user()?.profile?.nurse?.hosid
      ]
    options =
      limit:limit
      sort:
        updatedAt:-1
    subs.subscribe 'patientSearch', selector,options

  $(window).scroll ->
#      文档高度                滚动条高度               浏览器高度
    if $(document).height() - $(window).scrollTop() - $(window).height()<300
      text = instance.queryText.get()
      limit = instance.limit.get()
      if text
        reg = new RegExp(text, 'i')
        count = Meteor.users.find({$or:[{'profile.si': reg}],$and:['profile.patient.hospids':Meteor.user()?.profile?.nurse?.hospid,roles:{$in:['patient']}]}).count()
      else
        count = Meteor.users.find({roles:{$in:['patient']},'profile.patient.hospids':Meteor.user()?.profile?.nurse?.hospid}).count()
      hasMore = count == limit
      limit =  if hasMore then limit + 5 else count
      instance.limit.set(limit)
Template.patientManage.helpers
  isWS:->
    Template.instance().data?.ws
  'patientList': ->
    text = Template.instance().queryText.get()
    if text
      reg = new RegExp(text, 'i')
      Meteor.users.find({$or:[{'profile.si': reg}],$and:['profile.patient.hospids':Meteor.user()?.profile?.nurse?.hospid,roles:{$in:['patient']}]},{sort:{updatedAt:-1}})
    else
      Meteor.users.find({roles:{$in:['patient']},'profile.patient.hospids':Meteor.user()?.profile?.nurse?.hospid},{sort:{updatedAt:-1}})

Template.patientManage.events
  'input [name=patientListQueryPara]':(e,t)->
    text = t.$(e.target).val()?.trim()
    if text?
      Template.instance().queryText.set(text)
  'submit #patientListQuery':(e)->
    e.preventDefault()