## COLLECTION
@Laniakea.Collection.Consultations = new Mongo.Collection "consultations"
@Laniakea.Collection.ConsultationFiles = new FS.Collection('consultationFiles',
  stores: [
    new FS.Store.FileSystem('consultationFiles', path: '/dfs/lan/us')
  ]
)
if Meteor.isServer
  Meteor.publish 'singleConsultationFiles',(id)->
    Laniakea.Collection.ConsultationFiles.find(id)
Laniakea.Collection.ConsultationFiles.allow
  'insert':(userId,doc)->
    userId
  'update':(userId,doc,fieldNames,modifier)->
    userId
  download: (userId, fileObj)->
    true
## INDEX
if Meteor.isServer
  @Laniakea.Collection.Consultations._ensureIndex {patid: 1}
  @Laniakea.Collection.Consultations._ensureIndex {constatus: 1}

## SCHEMA
patientRequistion = new SimpleSchema(
  condition:
    type:String
    label:'病况自述'
  fee:
    type:Number
    label:'预计费用'
    optional:true
  expertdoc:
    type:String
    label:'期望专家'
    optional:true
  vid:
    type:String
    label:'自述视频'
    optional:true
  st:
    type:Date
    autoValue:->
      if @isInsert
        new Date
)
doctorRequistion = new SimpleSchema(
  conpur:
    type:String
    label:'会诊目的'
  initdiag:
    type:String
    label:'初始诊断'
  conmod:
    type:String
    label:'会诊模式'
    allowedValues: ["分时", "实时"]
  st:
    type:Date
    optional:true
)
session = new SimpleSchema(
  from: #会话from user id
    type:String
  type:#会话类型
    type:String
    allowedValues :['text','image','video']
  content: #会话内容
    type:String
  st:
    type:Date
)
condocs = new SimpleSchema(
  _id:
    type:String
  name:#专家姓名
    type:String
  status:#专家受邀状态
    type:Boolean
    defaultValue:false
)
@Laniakea.Schema.Consultations = new SimpleSchema(

  patid: #会诊患者id
    type: String
  pat:
    type: String
    label: "会诊患者"
  prmdocid:#会诊发起者
    type: String
  prmdoc:
    type:String
    label:'会诊发起者'
  patreq: #患者申请会诊
    type:patientRequistion
    optional:true
  docreq: #医生填写申请单
    type:doctorRequistion
    optional:true
  session:
    type:[session]
    optional:true
  condocs:
    type: [condocs]
    label: "会诊医生"
    optional:true
  constatus:
    type:String
    label:'会诊状态'
    allowedValues:['患者申请','待会诊','会诊中','会诊结束']
  conresult:
    type:String
    label:'会诊结果'
    optional:true
  st:#会诊开始时间
    type:Date
    optional:true
  et:#会诊结束时间
    type:Date
    optional:true
  si:
    type:String
    optional:true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['pat','prmdoc','constatus'])
)

Laniakea.Collection.Consultations.attachSchema Laniakea.Schema.Consultations


# Publish
if Meteor.isServer
  Meteor.publish 'consultations', (selector,options)->
    unless @userId
      throw new Meteor.Error('权限不足，未登录')
    if selector?
      text = selector.si
      selector['si']= new RegExp(text,'i')
    else
      selector = {}
    unless options?
      options ={}
    Laniakea.Collection.Consultations.find selector,options

  Meteor.publish 'myConsultations', (selector,options)->
    unless @userId
      throw new Meteor.Error('权限不足，未登录')
    Laniakea.Collection.Consultations.find {$or: [{prmdocid: @userId}, {'condocs._id': @userId}]},options

  Meteor.publish 'singleConsultation', (_id)->
    unless @userId
      throw new Meteor.Error('权限不足，未登录')
    Laniakea.Collection.Consultations.find {'_id': _id}
##PERIMISSION
Laniakea.Collection.Consultations.allow
  insert:(userId,doc)->
    userId
  'update':(userId,doc,fieldNames,modifier)->
    userId and Roles.userIsInRole(userId,['doctor'])
  remove:->
    if Meteor.userId() and Roles.userIsInRole(Meteor.userId(),['admin'])
      true

@Laniakea.Seed.ConsultationsSeeding = (pats,docs)->
  formData = {
      patid:pats[0]?._id,
      pat:pats[0]?.profile?.name,
      prmdocid:docs[0]._id,
      prmdoc:docs[0].profile.name,
      constatus:'患者申请',
      patreq:{
        condition:"toutongfashao"
      }
    };
  Laniakea.Collection.Consultations.insert(formData)
