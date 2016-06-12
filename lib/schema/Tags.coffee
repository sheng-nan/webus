#console.log 'Loading tags.coffee'

## 本数据库涉及到的几个Colleciotn首先列出
##  COLLECTION
@Laniakea.Collection.Tags = new Mongo.Collection ("tags")

##  INDEX
if Meteor.isServer
  @Laniakea.Collection.Tags._ensureIndex {si: 1}

##  SCHEMA

@Laniakea.Schema.tag = new SimpleSchema
  name:
    type: String
    index: 1
    label: '标签名'

  slug:
    type: String
    optional: true

  position:
    type: Number
    optional: true
    label: '标签位置'

  relatedTagIds:
    type: [String]
    optional: true
    index: 1
    label: '相关标签集'

  isTopLevel:
    type: Boolean
    optional: true

  tagType:
    type: String
    index: 1
    label: '标签类型' #视频,文章等

  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['name','slug','tagType'])

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

Laniakea.Collection.Tags.attachSchema Laniakea.Schema.tag


##PUBLISH
if Meteor.isServer
  Meteor.publish 'tags', (selector, options)->
    if selector?.si
      if selector.si != '*****'
        selector.si = new RegExp(selector.si, 'i')
#    options['fields'] =
#      name: 1
#      slug: 1
#      position: 1
#      relatedTagIds: 1
#      isTopLevel: 1
#      tagType: 1
#      si: 1
    Laniakea.Collection.Tags.find selector, options

  Meteor.publish 'singleTag', (id)->
    Laniakea.Collection.Tags.find id

#PERIMISSION
Laniakea.Collection.Tags.allow
  insert: ->
    true
  remove: ->
    true
  update: ->
    true

@Laniakea.Seed.TagsSeeding = ()->
#    家族病史 Family history
  fh = ['高血压', '糖尿病', '心脏病', '脑梗', '脑出血', '癌症', '过敏性疾病', '哮喘', '癫痫病', '白癜风', '近视']
#    过敏药物 Allergic drug
  ad = ['青霉素', '头孢类抗生素', '破伤风抗毒素（TAT）', '普鲁卡因', '地卡因', '磺胺类药物', '维生素B1', '泛影葡胺', '阿司匹林']
#    食物接触过敏 Food contact allergy
  fca = ['芒果', '牛奶', '海鲜', '笋', '香菇', '黄瓜', '花粉', '油漆', '皮毛', '化妆品']

#  接种史 Vaccination history
  vac = ['乙肝疫苗','卡介苗','白破疫苗','麻风疫苗','麻腮风疫苗']

#  既往病史 anamnesis
  ana = ['高血压', '糖尿病', '心脏病', '脑梗', '脑出血', '癌症', '过敏性疾病', '哮喘', '癫痫病', '白癜风', '近视']

  fhlist = []
  adlist = []
  fcalist = []
  vaclist = []
  analist = []

  for item,i in fh
    tag =
      name: item
      tagType: 'fh'
    tag._id = Laniakea.Collection.Tags.insert(tag)
    fhlist.push tag

  for item,i in ad
    tag =
      name: item
      tagType: 'ad'
    tag._id = Laniakea.Collection.Tags.insert(tag)
    adlist.push tag

  for item,i in fca
    tag =
      name: item
      tagType: 'fca'
    tag._id = Laniakea.Collection.Tags.insert(tag)
    fcalist.push tag

  for item,i in vac
    tag =
      name: item
      tagType: 'vac'
    tag._id = Laniakea.Collection.Tags.insert(tag)
    vaclist.push tag

  for item,i in ana
    tag =
      name: item
      tagType: 'ana'
    tag._id = Laniakea.Collection.Tags.insert(tag)
    analist.push tag

  return [fhlist, adlist, fcalist,vaclist,analist]