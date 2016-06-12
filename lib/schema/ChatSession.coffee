##  COLLECTION
@Laniakea.Collection.ChatSessions = new Mongo.Collection ("chatsessions")

## INDEX
if Meteor.isServer
  @Laniakea.Collection.ChatSessions._ensureIndex {docid: 1}
  @Laniakea.Collection.ChatSessions._ensureIndex {patid: 1}
  @Laniakea.Collection.ChatSessions._ensureIndex {lastpPatPushTime: 1}
@Laniakea.Schema.ChatSession = new SimpleSchema({
  patid: #咨询的patient id
    type:String,
  docid: #咨询的doctor id
    type:String,
  messages:
    type:[Object],
    optional:true
  'messages.$.from': #消息谁发的
    type:String,
  'messages.$.type': #发送消息的类型   video  image  text  audio
    type:String,
  'messages.$.content': #发送消息的内容
    type:String,
  'messages.$.st':  #发送消息的时间
    type:Date
  lastPatPushTime:
    label:'最后一次给患者推送消息的时间'
    type:Date
    optional:true
  lastMessages:
    label:'双方最后发送的消息'
    type:Object
    optional:true
  'lastMessages.$.doctor': #doctor发送的最后消息
    type:Object
  'lastMessages.$.patient': #patient发送的最后消息
    type:Object
  createdAt:
    type: Date
    autoValue: ->
      if @isInsert
        new Date
      else if @isUpsert
        $setOnInsert: new Date
      else
        @unset()
  updatedAt:
    type: Date,
    optional: true,
    autoValue: ->
      if @isUpdate
        new Date()
})
Laniakea.Collection.ChatSessions.attachSchema @Laniakea.Schema.ChatSession

# Publish
if Meteor.isServer
  Meteor.publish 'singleChatSession', (id,options)->
    unless @userId
      throw new Meteor.Error('权限不足，未登录')
    Laniakea.Collection.ChatSessions.find {_id:id},options
  Meteor.publish 'chatSessionByDoctorID', (docid,options)->
    unless @userId
      throw new Meteor.Error('权限不足，未登录')
    Laniakea.Collection.ChatSessions.find {docid:docid},options
  Meteor.publish 'chatSessionByPatientID', (patid,options)->
    unless @userId
      throw new Meteor.Error('权限不足，未登录')
    Laniakea.Collection.ChatSessions.find {patid:patid},options

##PERIMISSION
Laniakea.Collection.ChatSessions.allow
  insert:(userId,doc)->
    userId
  'update':(userId,doc,fieldNames,modifier)->
    userId
  remove:->
    if Meteor.userId() and Roles.userIsInRole(Meteor.userId(),['admin'])
      true