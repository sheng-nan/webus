#Meteor.subscribe 'usKnowledgeNodes'
Template.usKnowledgeNode.onCreated ->
  increment = 20
  instance = this
  instance.query = new ReactiveVar()
  instance.limit = new ReactiveVar(increment)

Template.usKnowledgeNode.helpers
  usKnowledgeNodes: ->
    str = {}
    si = Session.get('knowledgeNoteSi')
    if si
      reg = new RegExp(si, 'i')
      str['si'] = reg
    Laniakea.Collection.UsKnowledgeNodes.find(str)
Template.usKnowledgeNode.events
  'input [name=usKnowledgeNodes]':(e,t)->
    e.preventDefault();
    text = t.$(e.target).val()
    if text?
      Session.set('knowledgeNoteSi', text)
  'submit #usKnowledgeNodeListQuery':(e)->
      e.preventDefault();
Template.usKnowledgeNode.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    limit = instance.limit.get()
    str = {}
    si = Session.get('knowledgeNoteSi')
    if si
      str['si'] = si
    options =
      limit:limit
    instance.subscribe "usKnowledgeNodes", str,options
  $('#tab-2 .box-full-height').scroll ->
#      文档高度                                 滚动条高度
    if $('#tab-2 .box-full-height').height() - $('#tab-2 .box-full-height').scrollTop()<400
      limit = instance.limit.get()
      str = {}
      si = Session.get('knowledgeNoteSi')
      if si
        str['si'] = si
      count = Laniakea.Collection.UsKnowledgeNodes.find(str).count()
      hasMore = count == limit
      limit =  if hasMore then limit + 10 else count
      instance.limit.set(limit)