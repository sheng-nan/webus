#console.log 'Loading Cooperations.coffee'

## 本数据库涉及到的几个Colleciotn首先列出
##  COLLECTION
@Laniakea.Collection.Cooperations = new Mongo.Collection ("cooperations")

##  INDEX
if Meteor.isServer
  @Laniakea.Collection.Cooperations._ensureIndex {si: 1}

##  SCHEMA

@Laniakea.Schema.Cooperation = new SimpleSchema
  name:
    type: String
    index: 1
    label: '单位名称'

  status:
    type: String
    optional: true
    label: '单位状态'

  cooType:
    type: String
    optional: true
    label: '类型'
    autoform:
      afFieldInput:
        firstOption:'请选择'
      allowedValues:['药品代理']
      options:->
        药品代理:'药品代理',
        保健品销售:'保健品销售',
        其他: '其他'

  contact:
    type: String
    optional: true
    index: 1
    label: '联系人'

  tel:
    type: String
    optional: true
    label: '联系电话'
  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['name','cooType','status','tel', 'contact'])
  createdAt:
    type: Date,
    autoValue: ->
      if @isInsert
        new Date()
    autoform:
      omit: true

  updatedAt:
    type: Date,
    optional: true,
    autoValue: ->
      if this.isUpdate
        new Date()
    autoform:
      omit: true

Laniakea.Collection.Cooperations.attachSchema Laniakea.Schema.Cooperation


##PUBLISH
if Meteor.isServer
  Meteor.publish 'Cooperations', (selector, options)->
    if selector?.si
      if selector.si != '*****'
        selector.si = new RegExp(selector.si, 'i')
    Laniakea.Collection.Cooperations.find selector, options

  Meteor.publish 'singleCooperation', (id)->
    Laniakea.Collection.Cooperations.find id

#PERIMISSION
Laniakea.Collection.Cooperations.allow
  insert: ->
    true
  remove: ->
    true
  update: ->
    true
