##COLLECTION
@Laniakea.Collection.OutMedRecords = new Mongo.Collection "outMedRecords"

##INDEX
if Meteor.isServer
  @Laniakea.Collection.OutMedRecords._ensureIndex {patid: 1}

@Laniakea.Schema.OutMedRecord = new SimpleSchema
  hosid:
    type: String
    label: "医院编号"
    optional: true
  hos:
    type: String
    label: "医院名称"
    optional: true

  depid:
    type:String
    label:'诊断科室id'
    optional:false
  dep:
    type:String
    label:'诊断科室'
    optional:true

  docid:
    type:String
    label:'检查医生id'
    optional:false

  doc:
    type:String
    label:'诊断医生'
    optional:false

  patid:
    type: String
    label: '患者id'
    optional: false

  pat:
    type: String
    label: '患者姓名'
    optional: false

  age:
    type: String
    label: '患者年龄'
    optional: true

  sex:
    type:String
    optional:true
    label:'性别'
    allowedValues: ["男", "女"]

  blh:
    type:String
    optional:true
    label:'病历号'

  gm:
    type:String
    label:"过敏史"
    optional:true
    autoform:
      afFieldInput:
        type:'textarea'
        rows: 4


  fetp:
    type:String
    label:'费别'
    optional:true

  digt:
    type:Date
    label:'检查时间'
    optional:true

  rv:
    type:String
    label:'复诊'
    optional:true

  rvapm:
    type:String
    label:'复诊预约'
    optional:true

  zs:
    type:String
    label:'主诉'
    optional:true
    autoform:
      afFieldInput:
        type:'textarea'
        rows: 4

  xbs:
    type:String
    label:'现病史'
    optional:true
    autoform:
      afFieldInput:
        type:'textarea'
        rows: 4

  jw:
    type:String
    label:"既往史"
    optional:true
    autoform:
      afFieldInput:
        type:'textarea'
        rows: 4

  jzs:
    type:String
    label:"家族史"
    optional:true
    autoform:
      afFieldInput:
        type:'textarea'
        rows: 4

  bdck:
    type:String
    label:"体格检查"
    optional:true
    autoform:
      afFieldInput:
        type:'textarea'
        rows: 5

  diag:
    type:String
    label:'初始诊断'
    optional:true
    autoform:
      afFieldInput:
        type:'textarea'
        rows: 5

  sugst:
    type:String
    label:'处理意见'
    optional:true
    autoform:
      afFieldInput:
        type:'textarea'
        rows: 5

#    处方列表
  pres:
    type:[Object]
    label:'处方列表'
    optional:true
  'pres.$._id':
    type:String
    label:'处方id'
    optional:true
  'pres.$.pat':
    type:String
    label:'姓名'
    optional:true
  'pres.$.state':
    type:String
    label:'处方状态'
    optional:true
  'pres.$.createdAt':
    type:Date
    label:'创建时间'
    optional:true

#    工作流列表
  wls:
    type:[Object]
    label:'工作流列表'
    optional:true
  'wls.$._id':
    type:String
    label:'工作流id'
    optional:true
  'wls.$.pat':
    type:String
    label:'患者姓名'
    optional:true
  'wls.$.dep':
    type:String
    label:'检查科室'
    optional:true
  'wls.$.state':
    type:String
    label:'工作流状态'
    optional:true
  'wls.$.apmt':
    type:Date
    label:'申请时间'
    optional:true

# 自动生成的字段
  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['pat'])

@Laniakea.Collection.OutMedRecords.attachSchema Laniakea.Schema.OutMedRecord

##PUBLISH
if Meteor.isServer
  Meteor.publish 'singleOutMedRecord',(id)->
    Laniakea.Collection.OutMedRecords.find(id)

  Meteor.publish 'outMedRecords',(selector,options)->
    if Roles.userIsInRole(@userId,['doctor'])
      selector['docid'] = @userId
    unless options?.limit
      options.limit = 20
    unless options?.fields
      options['fields']=
        pat: 1
        age: 1
        sex: 1
        digt: 1
        si: 1
    delete selector['si']
    if selector?.selectext
      selector['si'] = new RegExp(selector.selectext,'i')
    delete selector['selectext']
    Laniakea.Collection.OutMedRecords.find(selector,options)

##PERIMISSION
Laniakea.Collection.OutMedRecords.allow
  'insert':(userId,doc)->
    userId and Roles.userIsInRole(userId,['doctor'])
  'update':(userId,doc,fieldNames,modifier)->
    userId and Roles.userIsInRole(userId,['doctor'])

##SEED
@Laniakea.Seed.OutMedRecordsSeeding=(docs,pat)->
#  console.log '@Laniakea.Seed.OutMedRecords...'
  medrecords = []
  for doc in docs
    if 1 is Math.floor(Math.random()*2)
      continue
    omr =
      hosid: doc.profile.doctor.hosid
      hos: doc.profile.doctor.hos
      depid: doc.profile.doctor.depid
      dep: doc.profile.doctor.dep
      docid: doc._id
      doc: doc.profile.name
      patid: pat._id
      pat: pat.profile.name
      age: 22
      sex: pat.profile.sex
      blh: '1000000000001'
      gm: Fake.fromArray(['青霉素', '红霉素', '头孢霉素', '链霉素'])
      fetp: Fake.fromArray(['自费', '公费', '医保'])
      digt: Fake.fromArray(['2015-07-19 09:15', '2015-07-20 08:22', '2015-08-15 10:12', '2015-08-16 09:25', '2015-08-18 09:45', '2015-08-24 09:55'])
      rv: '复诊'
      rvapm: '复诊预约'
      zs: Fake.fromArray(['咳嗽，发热', '头晕，耳鸣', '失眠，多汗', '口干，发热','腹痛，腹泻'])
      xbs: Fake.fromArray(['严重咳嗽，伴有轻微咳血', '心脏骤停', '心肌炎', '动脉硬化'])
      jw: Fake.fromArray(['高血压', '心脏病', '糖尿病', '动脉硬化', '肝炎'])
      jzs: Fake.fromArray(['高血压', '心脏病', '糖尿病', '动脉硬化', '肝炎'])
      bdck: Fake.fromArray(['发烧39摄氏度', '扁桃体发炎', '淋巴结肿大'])
      diag: Fake.fromArray(['急性肺炎', '脑膜炎', '冠心病','动脉硬化', '肝炎'])
      sugst: Fake.fromArray(['注射颠茄，1日3次。止泻药：思密达，1日2～3次', '感冒灵颗粒冲服，一日三次，一次2袋', 'A、654-2：剂量1-2mg/kg10-15分一次，稳定后改为0.5-1mg/kg，2-4小时一次，静推。B、东莨菪碱：0.02-0.04mg/kg每30分一次，加入5%葡萄糖10-20m1中静脉推注'])
    omr._id = Laniakea.Collection.OutMedRecords.insert(omr)
    medrecords.push omr
  return medrecords