Template.videoedu.onCreated ->
  increment = 18
  instance = this
  instance.queryText = new ReactiveVar()
  instance.limit = new ReactiveVar(increment)

Template.videoedu.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    text = instance.queryText.get()
    limit = instance.limit.get()
    if text
      selector=
        text:text
    else
      selector={}
    options=
      limit:limit
    instance.subscribe 'videos', selector,options
    $(window).scroll ->
      #      文档高度                滚动条高度               浏览器高度
      if $(document).height() - $(window).scrollTop() - $(window).height()<300
        text = instance.queryText.get()
        limit = instance.limit.get()
        if text
          reg = new RegExp(text, 'i')
          count = Laniakea.Collection.Videos.find({$or:[{'si': reg}]}).count()
        else
          count = Laniakea.Collection.Videos.find({}).count()
        hasMore = count == limit
        limit =  if hasMore then limit + 12 else count
        instance.limit.set(limit)

Template.videoedu.helpers
  'videos':->
    text = Template.instance().queryText.get()
    if text
      selector=
        $or:[{'si': new RegExp(text,'i')}]
    else
      selector={}
    Laniakea.Collection.Videos.find(selector)

Template.videoedu.events
  'input [name=videoListQueryPara]':(e,t)->
    text = t.$(e.target).val()?.trim()
    if text?
      Template.instance().queryText.set(text)
  'keydown [name=videoListQueryPara]':(e,t)->
    if(event.which == 13 )
      e.preventDefault();
      false