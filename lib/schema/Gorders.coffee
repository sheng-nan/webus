#console.log 'Loading gorders.coffee'

## 本数据库涉及到的几个Colleciotn首先列出
##  COLLECTION
@Laniakea.Collection.Gorders = new Mongo.Collection ("gorders")

##  INDEX
if Meteor.isServer
  @Laniakea.Collection.Gorders._ensureIndex {si: 1}

##  SCHEMA

@Laniakea.Schema.gorder = new SimpleSchema
  num:
    type: String
    label: '订单编号'
    optional: false

  pid:
    type: String
    label: "患者ID"
    optional: true

  pname:
    type: String,
    label: '患者姓名'
    optional: true

  did:
    type: String
    label: '医生ID'
    optional: true
  dname:
    type: String
    label: '医生姓名'
    optional: true
  goods:
    type: [Object]
    label: '商品信息'
    optional: true
  'goods.$._id':
    type: String
    label: '商品Id'
    optional: true
  'goods.$.gn':
    type: String
    label: '商品名'
    optional: true
  'goods.$.gp':
    type: String
    label: '价格'
    optional: true
  'goods.$.ga':
    type: String
    label: '数量'
    optional: true
  'goods.$.img'
    type: String
    label: '图片'
    optional: true
  'goods.$.gu':
    type: String
    label: '单位'
    optional: true
  shinfo:
    type: Object
    label: '收货信息'
  'shinfo.rn':
    type: String
    label: '收货人'
    optional: true
  'shinfo.addr':
    type: String
    label: '收货地址'
    optional: true
  'shinfo.sht':
    type: Date
    label: '收货时间'
    optional: true
  'shinfo.verify':
    type: String
    label: '确认人'
    optional: true
  'shinfo.tel':
    type: String
    label: '联系方式'
    optional: true
  'shinfo.note':
    type: String
    label: '备注'
    optional: true
  precords:
    type: [Object]
    label: '付款记录'
  'precords.$.pt':
    type: String
    label: '支付方式'
    optional: true
  'precords.$.pnum':
    type: String
    label: '付款单号'
    optional: true
  'precords.$.pmoney':
    type: Number
    label: '金额'
    optional: true
  'precords.$.ptime':
    type: Date
    label: '付款时间'
    optional: true
  fhinfo:
    type: Object
    label: '发货记录'
  'fhinfo.fht':
    type: Date
    label: '发货时间'
    optional: true
  'fhinfo.fhn':
    type: String
    label: '发货人'
    optional: true
  'fhinfo.wl':
    type: String
    label: '物流公司'
    optional: true
  'fhinfo.wlnum':
    type: String
    label: '运单号'
    optional: true
  status:
    type: String
    label: '状态'
    optional: true
    allowedValues: ['已下单','已付款','已发货','已收货']

  almoney:
    type: Number
    label: '已付金额'
    optional: true

  tmoney:
    type: Number
    label: '总金额'
    optional: true

  desc:
    type: String
    label: '订单描述'
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
      si(this,['pname','dname','num'])

Laniakea.Collection.Gorders.attachSchema Laniakea.Schema.gorder


##PUBLISH
if Meteor.isServer
  Meteor.publish 'gorders', (selector, options)->
#    if selector?.si
#      if selector.si != '*****'
#        selector.si = new RegExp(selector.si, 'i')
    if selector?.num
      selector.num = new RegExp(selector.num, 'i')
    if selector?.pname
      selector.pname = new RegExp(selector.pname, 'i')
    if selector?.dname
      selector.dname = new RegExp(selector.dname, 'i')
    if selector?.fhinfo?.fhn
      selector.fhinfo.fhn = new RegExp(selector.fhinfo.fhn, 'i')
    Laniakea.Collection.Gorders.find selector, options

  Meteor.publish 'singlegorder', (id)->
    Laniakea.Collection.Gorders.find id

#PERIMISSION
Laniakea.Collection.Gorders.allow
  insert: ->
    true
  remove: ->
    true
  update: ->
    true

@Laniakea.Seed.GorderSeeding = () ->
  if Laniakea.Collection.Gorders.find({}).count() < 1
    go0 =
      num:'021160213022'
      pid:'32nZBhsvnTwu66Ruq'
      pname:'王大锤'
      did:'yixdfSgT9rxwficYX'
      dname:'张磊'
      goods:[{
        '_id':'envYbFe4HZHqPtkfz'
        'gn':'表没食子儿茶素没食子酸酯胶囊'
        'gp':1998
        'ga':3
        'gu':'盒'
      },{
        '_id':'WspJqfrMBMXr6BDri'
        'gn':'阿胶胶囊'
        'gp':1998
        'ga':3
        'gu':'盒'
      }]
      shinfo:{
        rn:'张大'
        addr:'北京市西三环中路19号'
        sht:new Date('2016-02-19')
        verify:'孙'
        tel:'18611837864'
        note:'一定要包装好，请物流人员送到楼上'
      }
      precords:[{
        pt: '微信支付'
        pnum: '011160216023'
        pmoney: 5000
        ptime: new Date('2016-02-16')
      },{
        pt: '微信支付'
        pnum: '011160216024'
        pmoney: 966
        ptime: new Date('2016-02-16')
      }]
      fhinfo:{
        fht:new Date('2016-02-17')
        fhn:'孙七'
        wl:'中通'
        wlnum:'123456789'
      }
      status:'已收货'
      almoney:'5996'
      tmoney:'5996'
      desc:''
    go0._id =Laniakea.Collection.Gorders.insert(go0)
    go1 =
      num:'021160213023'
      pid:'zaM8vzuumessooTFP'
      pname:'郭景'
      did:'5rEgAtmjoYjKgAYgk'
      dname:'梁萍'
      goods:[{
        '_id':'envYbFe4HZHqPtkfz'
        'gn':'表没食子儿茶素没食子酸酯胶囊'
        'gp':1998
        'ga':3
        'gu':'盒'
      },{
        '_id':'WspJqfrMBMXr6BDri'
        'gn':'阿胶胶囊'
        'gp':1998
        'ga':3
        'gu':'盒'
      }]
      shinfo:{
        rn:'张大'
        addr:'北京市西三环中路19号'
        sht:new Date('2016-02-19')
        verify:'孙'
        tel:'18611837864'
        note:'一定要包装好，请物流人员送到楼上'
      }
      precords:[{
        pt: '微信支付'
        pnum: '011160216023'
        pmoney: 5000
        ptime: new Date('2016-02-16')
      },{
        pt: '微信支付'
        pnum: '011160216024'
        pmoney: 966
        ptime: new Date('2016-02-16')
      }]
      fhinfo:{
        fht:new Date('2016-02-17')
        fhn:'孙七'
        wl:'中通'
        wlnum:'123456789'
      }
      status:'已收货'
      almoney:'5996'
      tmoney:'5996'
      desc:''
    go1._id =Laniakea.Collection.Gorders.insert(go1)
    go2 =
      num:'021160213025'
      pid:'BH2fQyhxxeXgk4NgK'
      pname:'张小喵'
      did:'GiT9ASKe99RR6aQw7'
      dname:'田军'
      goods:[{
        '_id':'envYbFe4HZHqPtkfz'
        'gn':'表没食子儿茶素没食子酸酯胶囊'
        'gp':1998
        'ga':3
        'gu':'盒'
      },{
        '_id':'WspJqfrMBMXr6BDri'
        'gn':'阿胶胶囊'
        'gp':1998
        'ga':3
        'gu':'盒'
      }]
      shinfo:{
        rn:'张大'
        addr:'北京市西三环中路19号'
        sht:new Date('2016-02-19')
        verify:'孙'
        tel:'18611837864'
        note:'一定要包装好，请物流人员送到楼上'
      }
      precords:[{
        pt: '微信支付'
        pnum: '011160216023'
        pmoney: 5000
        ptime: new Date('2016-02-16')
      },{
        pt: '微信支付'
        pnum: '011160216024'
        pmoney: 966
        ptime: new Date('2016-02-16')
      }]
      fhinfo:{
        fht:new Date('2016-02-17')
        fhn:'孙七'
        wl:'中通'
        wlnum:'123456789'
      }
      status:'已收货'
      almoney:'5996'
      tmoney:'5996'
      desc:''
    go2._id =Laniakea.Collection.Gorders.insert(go2)