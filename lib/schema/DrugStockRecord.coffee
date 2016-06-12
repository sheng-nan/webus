#console.log 'Loading DrugStockRecords.coffee'

## 本数据库涉及到的几个Colleciotn首先列出
##  COLLECTION
@Laniakea.Collection.DrugStockRecords = new Mongo.Collection ("drugStockRecords")

##  INDEX
if Meteor.isServer
  @Laniakea.Collection.DrugStockRecords._ensureIndex {si: 1}
  @Laniakea.Collection.DrugStockRecords._ensureIndex {hosid: 1}

@Laniakea.Schema.DrugStockRecord = new SimpleSchema
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

  price: # instock price
    type: String
    label: '价格'
    optional: true

  amount:
    type: Number
    label: '数量'
    optional: true

  du: #drugStock unit
    type: String
    label: '单位'
    optional: true

  opeid:
    type: String
    label: '操作ID'
    optional: true

  operator:
    type: String
    label: '操作人'
    optional: true

  ct: #
    type: Date,
    autoValue: ->
      if @isInsert
        new Date()
    autoform:
      omit: true
#    type: Date
#    label: '出入库时间'
#    optional: true
#    autoform:
#      afFieldInput:
#        defaultValue:new Date()
#        type:"bootstrap-datepicker"
#        datePickerOptions:
#          autoclose:true
#          format:'yyyy-mm-dd'
#          language:'zh-CN'
#          todayHighlight:true
  status:
    type: String
    label: '状态'
    allowedValues: ["出库", "入库"]
    autoform:
      afFieldInput:
        type:'select-radio-inline'

  money:
    type: Number
    label: '总金额'
    optional: true

  app:
    type: String
    label: '申请方'
    optional: true

  pro:
    type: String
    label: '提供方'
    optional: true

  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['name','df','du','dt','pd','ft'])

  hosid:
    type: String
    label: '医院id'
    optional: true

  hos:
    type: String
    label: '医院'
    optional: true

Laniakea.Collection.DrugStockRecords.attachSchema Laniakea.Schema.DrugStockRecord


##PUBLISH
if Meteor.isServer
  Meteor.publish 'drugStockRecords', (selector, options)->
    unless @userId? and Roles.userIsInRole(@userId,['hosadmin'])
      throw new Meteor.Error '403','权限不足'
      @ready()
    else
      if selector?.si
        selector.si = new RegExp(selector.si, 'i')
      options['fields'] =
        opeid: 1
        operator: 1
        ct: 1
        status: 1
        money: 1
        app: 1
        pro: 1
        did: 1
        name: 1
        df: 1
        price: 1
        amount: 1
        du: 1
        expt: 1

      Laniakea.Collection.DrugStockRecords.find selector, options

  Meteor.publish 'singleDrugStockRecord', (id)->
    unless @userId? and Roles.userIsInRole(@userId,['hosadmin'])
      throw new Meteor.Error '403','权限不足'
      @ready()
    else
      Laniakea.Collection.DrugStockRecords.find id

#PERIMISSION
Laniakea.Collection.DrugStockRecords.allow
  insert: ->
    true
  remove: ->
    true
  update: ->
    true




