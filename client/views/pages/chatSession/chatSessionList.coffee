Template.messageItem.helpers
  sessionType: (type)->
    this.type is type
Template.chatSessionList.onCreated ->
  instance = this
  instance.selectedSession = new ReactiveVar()
Template.chatSessionList.onRendered ->
  instance = this
  $('body').addClass 'fixed-sidebar'
  $('body').addClass 'full-height-layout'
  # Set the height of the wrapper
  $('#page-wrapper').css 'min-height', $(window).height() + 'px'
  # Add slimScroll to element
  $('.full-height-scroll').slimscroll height: '100%'
  instance.autorun ->
    patids = []
    Laniakea.Collection.ChatSessions.find({docid:Meteor.userId()}).fetch().map((c)->
      patids.push(c.patid)
    );
    Meteor.subscribe('patients',{_id:{$in:patids}},{'profile.name':1,'profile.photo':1})
    if Meteor.subscribe('singleChatSession',Session.get('currentChatSession')).ready()
      chatsession = Laniakea.Collection.ChatSessions.findOne(Session.get('currentChatSession'))
      instance.selectedSession.set(chatsession)
      if chatsession? and Meteor.subscribe('singleUser',chatsession?.patid,{fields:{services:0,createdAt:0,username:0,roles:0,'profile.si':0}}).ready() and Meteor.subscribe('healthRecords',chatsession?.patid).ready() and Meteor.subscribe('dicomList', chatsession?.patid).ready()
        $(window).resize ->
          height = $(window).height()-190
          $('.chat-mes').css('height',height)
          $('.leftBox .slimScrollDiv').css('height',$('.chat-mes').height())
          $('.chat-mes').slimscroll height:height,scrollBy:'1000px',alwaysVisible:true,start:'bottom'
        Meteor.defer(->
          $('.chat-mes').slimscroll height:$(window).height()-190,scrollBy:'1000px',alwaysVisible:true,start:'bottom'
        )
        $('.element-detail-box').css('padding','0px')
  Laniakea.Collection.ChatSessions.find(Session.get('currentChatSession')).observeChanges(
    changed: (id,fields) ->
      $('.chat-mes').slimscroll height:$(window).height()-190,alwaysVisible:true,scrollBy:'1000px'
  )
Template.chatSessionList.onDestroyed ->
  $('body').removeClass 'fixed-sidebar'
  $('body').removeClass 'full-height-layout'
  $('#page-wrapper').removeAttr 'style'
Template.chatSessionList.helpers
  chatSessionListExist:->
    Laniakea.Collection.ChatSessions.find({docid:Meteor.userId()}).count()>0
  chatSessions:->
    Laniakea.Collection.ChatSessions.find({docid:Meteor.userId()})
  patient:->
    Meteor.users.findOne(Template.instance()?.selectedSession?.get()?.patid)
  sessionType: (type)->
    this.type is type
  userInfo:(id,info)->
    Meteor.users.findOne(id)?.profile?[info]
  messages:->
    Laniakea.Collection.ChatSessions.findOne(Session.get('currentChatSession'))?.messages
  lastMessage:->
    this.messages[this.messages?.length-1]
Template.chatSessionList.events
  'submit #sessionForm': (e, t)->
    e.preventDefault()
    session =
      from: Meteor.userId()
      type: 'text'
      content: e.target['content'].value
      st: new Date()
    Laniakea.Collection.ChatSessions.update({_id: Session.get('currentChatSession')}, {$push: {messages: session}})
    e.target['content'].value = ''
  'click a[href=#tab-1]':(e,t)->
    Session.set('currentChatSession',@_id)
  'click #uploadImage':(e,t)->
    unless Session.get('currentChatSession')
      return
    t.$('#inputImage').click()
  'change #inputImage':(e,t)->
    chatsessionId = Session.get('currentChatSession')
    files = e.target.files
    file = files[0]

    if (files && files.length)
      file = files[0];
      if (/^image\/\w+$/.test(file.type))
        Meteor.call 'AliYun',(error,result)->
          if error or result != "TRUE"
            throw new Meteor.Error('未启用阿里云上传')
          else if result is "TRUE"
            mongoID = (new Mongo.ObjectID)._str
            key = 'img/'+ mongoID+'.jpg'
            successCallback = ->
              session =
                from: Meteor.userId()
                type: 'image'
                content: OSS.config.Endpoint + '/' + key
                st: new Date()
              Laniakea.Collection.ChatSessions.update({_id: chatsessionId}, {$push: {messages: session}})
            OSS.PostObject file,key,successCallback
      else
        toastr.info('请选择一张图片')
    input = $('#inputImage')
    input.replaceWith(input.val('').clone(true))