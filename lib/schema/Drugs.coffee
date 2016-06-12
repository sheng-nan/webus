#console.log 'Loading drugs.coffee'

## 本数据库涉及到的几个Colleciotn首先列出
##  COLLECTION
@Laniakea.Collection.Drugs = new Mongo.Collection ("drugs")

##  INDEX
if Meteor.isServer
  @Laniakea.Collection.Drugs._ensureIndex {si: 1}

##  SCHEMA

@Laniakea.Schema.drug = new SimpleSchema
  name:
    type: String
    label: '名称'
    optional: false

  cname:
    type: String
    label: "通用名称"
    optional: true

  bc:  #barcord
    type: String,
    label: '条码'
    optional: true

  dt: #drugType
    type: String
    label: '类型'
    optional: true
    allowedValues: ["西药", "中药"]
    autoform:
      afFieldInput:
        type:'select-radio-inline'
  df: #drug format
    type: String
    label: '规格'
    optional: true

  gprice: #guide price
    type: Number
    label: '指导价格'
    optional: true

  du: #drug unit
    type: String
    label: '单位'
    optional: true

  dp: #drug package
    type: String
    label: '包装'
    optional: true

  pd:# place of production
    type: String
    label: '产地'
    optional: true
  ft: #Factory
    type: String
    label: '厂家'
    optional: true

  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['name','cname','bc','dt','du'])

Laniakea.Collection.Drugs.attachSchema Laniakea.Schema.drug


##PUBLISH
if Meteor.isServer
  Meteor.publish 'drugs', (selector, options)->
    if selector?.si
      if selector.si != '*****'
        selector.si = new RegExp(selector.si, 'i')
    options['fields'] =
      name: 1
      cname: 1
      bc: 1
      dt: 1
      df: 1
      du: 1
      dp: 1
      pd: 1
      ft: 1
      si: 1
    Laniakea.Collection.Drugs.find selector, options

  Meteor.publish 'singledrug', (id)->
    Laniakea.Collection.Drugs.find id

#PERIMISSION
Laniakea.Collection.Drugs.allow
  insert: ->
    true
  remove: ->
    true
  update: ->
    true
@Laniakea.Seed.DrugSeeding = () ->
  if Laniakea.Collection.Drugs.find({}).count() is 0
#    console.log '@Laniakea.Seed.UsKnowledges... '

    dr0 =
      name: '庆大霉素缓释片'
      cname: '庆大霉素缓释片'
      bc: ''
      dt: '西药'
      df: '40mg*24片'
      du: '盒'
      dp: ''
      pd: ''
      ft: '上海中瀚集团宁国邦宁制药有限公司'
    dr0._id = Laniakea.Collection.Drugs.insert dr0

    dr1 =
      name: '链霉素粉针'
      cname: '链霉素粉针'
      bc: ''
      dt: '西药'
      df: '1.0g*50支'
      du: '盒'
      dp: ''
      pd: ''
      ft: '三九医药股份有限公司'
    dr1._id = Laniakea.Collection.Drugs.insert dr1

    dr2 =
      name: '阿米卡星注射液'
      cname: '阿米卡星注射液'
      bc: ''
      dt: '西药'
      df: '0.2g*10支'
      du: '盒'
      dp: ''
      pd: ''
      ft: '修正药业集团长春高新制药有限公司'
    dr2._id = Laniakea.Collection.Drugs.insert dr2

    dr3 =
      name: '依替米星粉针'
      cname: '依替米星粉针'
      bc: ''
      dt: '西药'
      df: '50mg*1支'
      du: '支'
      dp: ''
      pd: ''
      ft: '河南省百泉制药有限公司'
    dr3._id = Laniakea.Collection.Drugs.insert dr3

    dr4 =
      name: '妥布霉素针'
      cname: '妥布霉素针'
      bc: ''
      dt: '西药'
      df: '80mg*5支2ml'
      du: '盒'
      dp: ''
      pd: ''
      ft: '北京同仁堂科技发展股份有限公司制药厂'
    dr4._id = Laniakea.Collection.Drugs.insert dr4

    dr5 =
      name: '庆大霉素注射液'
      cname: '庆大霉素注射液'
      bc: ''
      dt: '西药'
      df: '8万u*10支'
      du: '盒'
      dp: ''
      pd: ''
      ft: '成都天银制药有限公司'
    dr5._id = Laniakea.Collection.Drugs.insert dr5

    dr6 =
      name: '依替米星氯化钠针'
      cname: '依替米星氯化钠针'
      bc: ''
      dt: '西药'
      df: '0.1g*100ml*1瓶'
      du: '瓶'
      dp: ''
      pd: ''
      ft: '江西华太药业有限公司'
    dr6._id = Laniakea.Collection.Drugs.insert dr6

    dr7 =
      name: '八珍颗粒'
      cname: '八珍颗粒'
      bc: ''
      dt: '西药'
      df: '3.5g*10'
      du: '盒'
      dp: ''
      pd: ''
      ft: '吉林省吴太感康药业有限公司'
    dr7._id = Laniakea.Collection.Drugs.insert dr7

    dr8 =
      name: '生血宁片'
      cname: '生血宁片'
      bc: ''
      dt: '西药'
      df: '0.25g*24'
      du: '盒'
      dp: ''
      pd: ''
      ft: '浙江亚峰制药厂有限公司'
    dr8._id = Laniakea.Collection.Drugs.insert dr8

    dr9 =
      name: '金天格胶囊'
      cname: '金天格胶囊'
      bc: ''
      dt: '西药'
      df: '0.4g*24'
      du: '盒'
      dp: ''
      pd: ''
      ft: '中美天津史克制药有限公司'
    dr9._id = Laniakea.Collection.Drugs.insert dr9

    Laniakea.Collection.Drugs.insert
      name: '肾康注射液'
      cname: '肾康注射液'
      bc: ''
      dt: '西药'
      df: '20ml*1'
      du: '支'
      dp: ''
      pd: ''
      ft: '山东健民药业有限公司'
    Laniakea.Collection.Drugs.insert
      name: '珍珠粉'
      cname: '珍珠粉'
      bc: ''
      dt: '西药'
      df: '0.3g*20支'
      du: '盒'
      dp: ''
      pd: ''
      ft: '甘肃省康达制药厂'
    Laniakea.Collection.Drugs.insert
      name: '生脉胶囊'
      cname: '生脉胶囊'
      bc: ''
      dt: '西药'
      df: '0.3g*24粒'
      du: '盒'
      dp: ''
      pd: ''
      ft: '湖北美宝药业有限公司'
    Laniakea.Collection.Drugs.insert
      name: '氨基葡萄糖片'
      cname: '氨基葡萄糖片'
      bc: ''
      dt: '西药'
      df: '0.24g*30片'
      du: '盒'
      dp: ''
      pd: ''
      ft: '云南白药集团股份有限公司'

  return [dr0,dr1,dr2,dr3,dr4,dr5,dr6,dr7,dr8,dr9]



