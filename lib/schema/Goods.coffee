#console.log 'Loading goods.coffee'

## 本数据库涉及到的几个Colleciotn首先列出
##  COLLECTION
@Laniakea.Collection.Goods = new Mongo.Collection ("goods")

##  INDEX
if Meteor.isServer
  @Laniakea.Collection.Goods._ensureIndex {si: 1}

##  SCHEMA

@Laniakea.Schema.good = new SimpleSchema
  name:
    type: String
    label: '商品名称'
    optional: false

  type:
    type: String
    label: "商品分类"
    optional: true

  price:
    type: Number,
    label: '商品单价'
    optional: true

  gf:
    type: Object
    label: '规格参数'
    optional: true
  'gf.cn':
    type: String
    label: '全称/通用名'
    optional: true
  'gf.an':
    type: String
    label: '别称/商品名'
    optional: true
  'gf.pro':
    type: String
    label: '商品产地'
    optional: true
  'gf.bpck':
    type: String
    label: '基础包装'
    optional: true
  'gf.ppck':
    type: String
    label: '产品包装'
    optional: true
  'gf.pfmt':
    type: String
    label: '包装规格'
    optional: true
  'gf.sdosage':
    type: String
    label: '默认单次用量'
    optional: true
  'gf.rate':
    type: String
    label: '默认用药频次'
    optional: true
  status:
    type: String
    label: '商品状态'
    optional: true

  img:
    type: String
    label: '商品图标'
    optional: true

  ads:
    type: [String]
    label: '广告图片'
    optional: true

  desc:
    type: String
    label: '商品说明'
    optional: true

  detail:
    type: String
    label: '商品详情'
    optional: true
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
  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['name','type'])

Laniakea.Collection.Goods.attachSchema Laniakea.Schema.good


##PUBLISH
if Meteor.isServer
  Meteor.publish 'goods', (selector, options)->
    if selector?.si
      if selector.si != '*****'
        selector.si = new RegExp(selector.si, 'i')
    Laniakea.Collection.Goods.find selector, options

  Meteor.publish 'singlegood', (id)->
    Laniakea.Collection.Goods.find id

#PERIMISSION
Laniakea.Collection.Goods.allow
  insert: ->
    true
  remove: ->
    true
  update: ->
    true
@Laniakea.Seed.GoodSeeding = () ->
  if Laniakea.Collection.Goods.find({}).count() < 1
    g0 =
      name:'EGCG'
      type:'食药'
      price:1998
      gf:{
        cn:'表没食子儿茶素没食子酸酯胶囊'
        an:'EGCG胶囊'
        pro:'华康同邦科技有限公司'
        bpck:'袋'
        ppck:'盒'
        pfmt:'0.2g×12袋/盒'
        sdosage:'0.4'
        rate:'每日三次'
      }
      status:'可销售'
      img:''
      ads:''
      desc:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar tempor. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam fermentum, nulla luctus pharetra vulputate, felis tellus mollis orci, sed rhoncus sapien nunc eget odio'
      detail:'http://www.jianke.com/product/242273.html'
    g0._id =Laniakea.Collection.Goods.insert(g0)
    g1 =
      name:'阿胶胶囊'
      type:'食药'
      price:1998
      gf:{
        cn:'阿胶胶囊'
        an:'阿胶胶囊'
        pro:'华康同邦科技有限公司'
        bpck:'袋'
        ppck:'盒'
        pfmt:'0.2g×12袋/盒'
        sdosage:'0.4'
        rate:'每日三次'
      }
      status:'可销售'
      img:''
      ads:''
      desc:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar tempor. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam fermentum, nulla luctus pharetra vulputate, felis tellus mollis orci, sed rhoncus sapien nunc eget odio'
      detail:'http://www.jianke.com/product/242273.html'
    g1._id =Laniakea.Collection.Goods.insert(g1)
    g2 =
      name:'西洋参'
      type:'食药'
      price:1998
      gf:{
        cn:'西洋参'
        an:'西洋参'
        pro:'华康同邦科技有限公司'
        bpck:'袋'
        ppck:'盒'
        pfmt:'0.2g×12袋/盒'
        sdosage:'0.4'
        rate:'每日三次'
      }
      status:'可销售'
      img:''
      ads:''
      desc:'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Aenean euismod bibendum laoreet. Proin gravida dolor sit amet lacus accumsan et viverra justo commodo. Proin sodales pulvinar tempor. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Nam fermentum, nulla luctus pharetra vulputate, felis tellus mollis orci, sed rhoncus sapien nunc eget odio'
      detail:'http://www.jianke.com/product/242273.html'
    g2._id =Laniakea.Collection.Goods.insert(g2)