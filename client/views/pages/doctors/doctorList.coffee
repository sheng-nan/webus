Template.doctorList.onCreated ->
  Session.set('doctorSi', '')
  increment = 20
  Session.set('doctorLimit',increment )
Template.doctorList.helpers
  'doctors':->
    Meteor.users.find({roles:{$in:['doctor']},_id:{$nin:[Meteor.userId()]}})
Template.doctorList.events
  'input [name=doctorSi]':(e,t)->
    e.preventDefault();
    text = t.$(e.target).val()
    if text?
      Session.set('doctorSi', text)
Template.doctorList.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    limit = Session.get('doctorLimit')
    str = {}
    si = Session.get('doctorSi')
    if si
      str['text'] = si
    options =
      limit:limit
    instance.subscribe "doctorSearch", str,options
  $(window).scroll ->
#      文档高度                滚动条高度               浏览器高度
    if $(document).height() - $(window).scrollTop() - $(window).height()<300
      limit = Session.get('doctorLimit')
      str = {}
      si = Session.get('doctorSi')
      if si
        str['text'] = si
      count = Meteor.users.find(str).count()
      hasMore = count == limit
      limit =  if hasMore then limit + 10 else count
      Session.set('doctorLimit', limit)