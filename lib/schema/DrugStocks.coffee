#console.log 'Loading drugStocks.coffee'

## 本数据库涉及到的几个Colleciotn首先列出
##  COLLECTION
@Laniakea.Collection.DrugStocks = new Mongo.Collection ("drugStocks")

##  INDEX
if Meteor.isServer
  @Laniakea.Collection.DrugStocks._ensureIndex {si: 1}
  @Laniakea.Collection.DrugStocks._ensureIndex {hosid: 1}

##  SCHEMA

@Laniakea.Schema.drugStock = new SimpleSchema

  did:
    type: String
    label: '药品ID'
    optional: false

  name:
    type: String
    label: '名称'
    optional: false

  df: #drugStock format
    type: String
    label: '规格'
    optional: true
  sprice: #sale price
    type: Number
    label: '售价'
    optional: true

  total:
    type: Number
    label: '库存量'
    optional: true
    autoValue: ->
      if @isInsert
        0

  du: #drugStock unit
    type: String
    label: '单位'
    optional: true

  dt: #drugStockType
    type: String
    label: '类型'
    optional: true
    allowedValues: ["西药", "中药"]
    autoform:
      afFieldInput:
        type:'select-radio-inline'

  pd:# place of production
    type: String
    label: '产地'
    optional: true

  ft: #Factory
    type: String
    label: '厂家'
    optional: true

  hosid:
    type: String
    label: '医院id'
    optional: true

  hos:
    type: String
    label: '医院'
    optional: true

  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['name','df','du','dt','od','ft'])

Laniakea.Collection.DrugStocks.attachSchema Laniakea.Schema.drugStock


##PUBLISH
if Meteor.isServer
  Meteor.publish 'drugStocks', (selector, options)->
    unless @userId?# and Roles.userIsInRole(@userId,['hosadmin'])
      throw new Meteor.Error '403','权限不足'
      @ready()
    else
      if selector?.si
        selector.si = new RegExp(selector.si, 'i')
      options['fields'] =
        did: 1
        name: 1
        df: 1
        sprice: 1
        total: 1
        du: 1
        dt: 1
        pd: 1
        ft: 1
        si: 1
        hosid: 1
        hos: 1
      Laniakea.Collection.DrugStocks.find selector, options

  Meteor.publish 'singleDrugStock', (id)->
    unless @userId? and Roles.userIsInRole(@userId,['hosadmin'])
      throw new Meteor.Error '403','权限不足'
      @ready()
    else
      Laniakea.Collection.DrugStocks.find id

#PERIMISSION
Laniakea.Collection.DrugStocks.allow
  insert: ->
    true
  remove: ->
    true
  update: ->
    true




