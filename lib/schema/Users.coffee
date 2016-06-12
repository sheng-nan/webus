#console.log 'Loading Users.coffee'

@Laniakea.Collection.UserPhotos = new FS.Collection('userPhotos',
  stores: [
#    new FS.Store.GridFS('userPhotos', path: '~/uploads')
    new FS.Store.FileSystem('userPhotos', path: '/dfs/lan'),
    new FS.Store.FileSystem('userThumbs',
      transformWrite: (fileObj, readStream, writeStream) ->
        gm(readStream).resize(60).stream('PNG').pipe writeStream
    )
  ]
)

#@Images = new FS.Collection("images",
#  stores: [new FS.Store.GridFS("images", {})]
#)
## INDEX
if Meteor.isServer
  Meteor.users._ensureIndex {'profile.si':1}
  Meteor.users._ensureIndex {'profile.patient.hosids': 1}
  Meteor.users._ensureIndex {'profile.patient.prmdocid': 1}
  Meteor.users._ensureIndex {'profile.patient.docids': 1}
  Meteor.users._ensureIndex {'updatedAt': 1}


##SCHEMA
# ----------------------   管理员 profile  -----------------------------
@Laniakea.Schema.AdminProfile = new SimpleSchema(
  hosid:
    type: String
    optional:true
    label:'管理医院ID'

  hos:   # 管理医院名称hospital_name
    type: String
    label:'管理医院'
    optional:true  #冗余字段，用于显示
  cooid:
    type:String
    label: '合作单位ID'
    optional: true
  coo:
    type: String
    label: '合作单位'
    optional: true

)

# ----------------------   医生 profile  -----------------------------
@Laniakea.Schema.DoctorProfile = new SimpleSchema(
  hosid:
    type: String
    optional:true
    label:'所属医院ID'

  hos:   # 所属医院名称hospital_name
    type: String
    label:'所属医院'
    optional:true  #冗余字段，用于显示

  depid:
    type: String
    optional:true
    label:'所属科室ID'

  dep:   # 所属科室名称department_name
    type: String
    label:'所属科室'
    optional:true  #冗余字段，用于显示

  following:
    type:[String]
    optional:true
    label:'关注'

  followers:
    type:[String]
    optional:true
    label:'谁关注了我'

  qr:
    type:String
    optional:true
    label:"微信二维码"

  edubg:  #  educational background
    type: String
    label:'学历'
    optional:true

  gfs: #      Graduated from the school
    type: String
    label:'毕业学校'
    optional:true

  gcnum:    #Graduation certificate number
    type: String
    label:'毕业证书编号'
    optional:true

  gc:  #Graduation certificate
    type: String
    label:'毕业证书'
    optional:true

  mlnum:       # Medical licence number
    type: String
    label:'医师资格证编号'
    optional:true

  ml:   # Medical licence
    type: String
    label:'医师资格证'
    optional:true

  pdnum:
    type:String
    label:'医师职业证编号'
    optional:true

  pd:   # Professional doctor
    type: String
    label:'医师职业证'
    optional:true

  ppcnum:# Physician's practice certificate Number
    type:String
    label:'医师执业证书编号'
    optional:true

  ppc:   # Physician's practice certificate
    type: String
    label:'医师执业证书'
    optional:true

  ptpqnum:# Professional technical position qualifications Number
    type:String
    label:'专业技术职务资格证书编号'
    optional:true

  ptpq:   # Professional technical position qualifications
    type: String
    label:'专业技术职务资格证书'
    optional:true

  ocnum: # Other certificate Number
    type:String
    label:'其他证书编号'
    optional:true

  oc: # Other certificate
    type:String
    label:'其他证书'
    optional:true

  doct:   # doctor_title
    type: String
    label:'医生职称'
    optional:true
  occ:   # Occupation
    type: String
    label:'职业'
    optional:true

  exp:   #
    type: String
    label:'擅长领域'
    optional:true

  desc:   #
    type: String
    label:'医生简介'
    optional:true
    autoform:
      rows: 5
  chatPat:
    type: String
    label:'聊天患者'
    optional:true

  verify:
    type: Number
    label:'审核状态'
    allowedValues:[0, 1, 2] #0未审核 1审核   2已驳回
    optional:true
  verpid:
    type: String
    label:'审核人ID'
    optional:true
  verpn:
    type: String
    label:'审核人'
    optional:true
  verd:
    type: Date
    label:'审核时间'
    optional:true
    autoValue: ->
      new Date()
  verReason:
    type: String
    label:'驳回原因'
    optional:true
  source:
    type:Number
    label: '医生来源'
    allowedValues:[0, 1, 2] #0系统管理员录入  1 医院管理员录入   2 合作单位录入
    optional: true
  sourceId:
    type: String
    label: '来源ID'
    optional: true

)

# ----------------------   护士 profile  -----------------------------
@Laniakea.Schema.NurseProfile = new SimpleSchema(
  hosid:
    type: String
    optional:true
    label:'所属医院ID'

  hos:   # 所属医院名称hospital_name
    type: String
    label:'所属医院'
    optional:true  #冗余字段，用于显示

  depid:
    type: String
    optional:true
    label:'所属科室ID'

  dep:   # 所属科室名称department_name
    type: String
    label:'所属科室'
    optional:true  #冗余字段，用于显示
)

# ----------------------   病人 profile  -----------------------------
@Laniakea.Schema.PatientProfile = new SimpleSchema(

  hosids:
    type: [String]
    optional:true
    label:'医院ID' #本字段仅用于检索，不需要显示，所以不记录hospital

  prmdocid:
    type: String
    optional:true
    label: '主治医生' #本字段仅用于检索，不需要显示，所以不记录doctor
  docids:
    type:[String]
    optional:true
    label:'相关医生' #本字段不需要显示，患者通过docids保存自己的相关医生列表

#  medical insurance card
  mic:
    type:String
    optional:true
    label:'医保卡号'

  gms:
    type:[String]
    optional:true
    label:'过敏史'

# vaccinate
  vac:
    type:[String]
    optional:true
    label:'疫苗接种史'

# anamnesis
  ana:
    type:[String]
    optional:true
    label:'既往病史'

# inheritable
  inh:
    type:[String]
    optional:true
    label:'家族遗传病史'
  spc:
    type:[Object]
    optional:true
    label: '购物车'
  'spc.$.gid':
    type:String
    optional:true
    label: '商品ID'
  'spc.$.gn':
    type:String
    optional:true
    label: '商品名称'
  'spc.$.gp':
    type:Number
    optional:true
    label: '单价'
  'spc.$.ga':
    type:Number
    optional:true
    label: '数量'
  'spc.$.img':
    type:String
    optional:true
    label: '商品图标'
  'spc.$.isbuy':
    type:Boolean
    optional:true
    label: '是否购买'
  spa:
    type:[Object]
    optional:true
    label: '收货地址信息'
  'spa.$.rid':
    type:String
    optional:true
    label: '收货地址ID'
  'spa.$.rn':
    type:String
    optional:true
    label: '收货人'
  'spa.$.rt':
    type:String
    optional:true
    label: '联系方式'
  'spa.$.ra':
    type:String
    optional:true
    label: '收货地址'
  'spa.$.isdefaule':
    type:Boolean
    optional:true
    label: '收货地址'
)

@Laniakea.Schema.UserProfile = new SimpleSchema({
  name:
    type: String
    label: "姓名"
    optional: true

# 自动生成的字段
  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['profile.name'])

  mobile:
    type: String
    label:'手机'
    regEx: /^1\d{10}$/

  birthday:
    type: Date
    label: '生日'
    optional:true
    autoform:
      afFieldInput:
        defaultValue:new Date()
        type:"bootstrap-datepicker"
        datePickerOptions:
          autoclose:true
          format:'yyyy-mm-dd'
          endDate:new Date()
          language:'zh-CN'
          todayHighlight:true
#    autoValue: ->
#      unless @value?
#        new Date()
  sex:
    type:String
    optional:true
    label:'性别'
    autoform:
      afFieldInput:
        firstOption:'请选择'
      allowedValues: ["男", "女"]
      options:->
        男:'男',
        女:'女',
  photo:
    type:String
    optional:true
    label:"头像"
#    autoform:
#      afFieldInput:
#        type: 'fileUpload'
#        collection: Laniakea.Collection.UserPhotos
#        label: '选择图片...' # optional

  openid:
    type:String
    optional:true
    label:"微信openid"

  idc:
    type:String
    optional:true
    label:"身份证号"
    regEx: /^[1-9](\d{16}|\d{13})[0-9xX]$/
  pmi:  # private metting id
    type:String
    optional:true
    label:'会诊ID'
})


# ----------------------  Schema for Meteor users  -----------------------------

@Laniakea.Schema.User = new SimpleSchema(
  username:
    type: String
    optional:true
    label: "用户名"

  password:
    type: String
    label: "创建密码"
    optional: true

  confirmPassword:
    type: String
    label: "再输密码"
    optional: true
#    custom: ->
#      if @value isnt @field("password").value
#        "密码不一致"
  createdAt:
    type: Date
    autoValue: ->
      if @isInsert
        new Date
      else if @isUpsert
        $setOnInsert: new Date
      else
        @unset()
    autoform:
      omit: true
  updatedAt:
    type: Date,
    optional: true,
    autoValue: ->
      if @isUpdate
        new Date()
    autoform:
      omit: true

  roles:
    type: [ String ]
    label: "身份"
    allowedValues: [ "admin", "doctor","nurse", "patient" ,"qc","hosadmin", "hosadmin_drugstore","cooadmin"]
    optional: true
#    autoform:
#      afFieldInput:
#        type:'select-checkbox-inline'

  services:
    type: Object
    optional: true
    blackbox: true

  profile:
    type: Laniakea.Schema.UserProfile
    optional: true

  "profile.admin":
    type: Laniakea.Schema.AdminProfile
    optional: true

  "profile.doctor":
    type: Laniakea.Schema.DoctorProfile
    optional: true

  "profile.patient":
    type: Laniakea.Schema.PatientProfile
    optional: true

  "profile.nurse":
    type: Laniakea.Schema.NurseProfile
    optional: true
  status:
    label: '用户状态'
    type: Number
    allowedValues:[0, 1] #0删除停用  1 正常
    optional: true

)


Meteor.users.attachSchema @Laniakea.Schema.User
#Meteor.users.allow
#  update:(userId,doc,fieldNames,modifier)->#只允许修改profile字段
#    userId and fieldNames.length == 1 and fieldNames[0] == 'profile'
## PUBLISH
if Meteor.isServer
#医生微信端我的患者
  Meteor.publish 'myPatients', (selector,options)->
    unless @userId? and Roles.userIsInRole(@userId,['doctor'])
      throw new Meteor.Error '403','权限不足'
      @ready()
    else
      selector = selector or {}
      options = options or {}
      selector['roles'] =
        $in: ['patient']
      selector['profile.patient.prmdocid'] = @userId
      options['fields'] =
        profile: 1
        roles: 1
        updatedAt: 1
      options['limit'] = options['limit'] or 10
      return Meteor.users.find(selector,options)
  Meteor.publish 'singlePatient', (selector,options)->
    unless @userId? and Roles.userIsInRole(@userId,['doctor'])
      throw new Meteor.Error '403','权限不足'
      @ready()
    else
      selector = selector or {}
      options = options or {}
      selector['roles'] =
        $in: ['patient']
      selector['profile.patient.prmdocid'] = @userId
      options['fields'] =
        username:1
        profile: 1
        roles: 1
        updatedAt: 1
      options['limit'] = options['limit'] or 10
      return Meteor.users.find(selector,options)
  Meteor.publish 'users',(selector,options)->
    unless @userId? and Roles.userIsInRole(@userId,['admin', 'hosadmin','cooadmin'])
      throw new Meteor.Error '403','权限不足'
      @ready()
    else
      unless selector
        selector={}
      unless options
        options={}
      Meteor.users.find(selector,options)

  Meteor.publish 'patients', (selector,options)->
    unless @userId? and Roles.userIsInRole(@userId,['doctor','nurse'])
      throw new Meteor.Error '403','权限不足'
      @ready()
    else
      selector['roles'] =
        $in:['patient']
      options['fields']=
        profile: 1
        roles: 1
        updatedAt:1
      Meteor.users.find(selector,options)
  Meteor.publish 'patientSearch', (selector,options)->
    unless @userId? and Roles.userIsInRole(@userId,['doctor','nurse','admin'])
      throw new Meteor.Error '403','权限不足'
      @ready()
    else
      text = selector?.text
      if text && text != '*****'
        selector['$or'] =[
          'profile.si': new RegExp(text,'i')
        ]
      delete selector.text
      selector['roles'] ={$in:['patient']}
      options['fields']=
        profile: 1
        roles: 1
        updatedAt:1
      Meteor.users.find(selector,options)
  Meteor.publish 'doctorSearch', (selector,options)->
    text = selector?.text
    selector['$or'] =[
      'profile.si': new RegExp(text,'i')
    ]
    if selector?.profile?.name
      selector.profile.name = new RegExp(selector.profile.name,'i')
    if selector?.profile?.mobile
      selector.profile.mobile = new RegExp(selector.profile.mobile,'i')
    if selector?.profile?.admin.occ
      selector.profile.admin.occ = new RegExp(selector.profile.admin.occ,'i')
    if selector?.profile?.doctor.doct
      selector.profile.doctor.doct = new RegExp(selector.profile.doctor.doct,'i')
    delete selector.text
    selector['roles'] ={$in:['doctor']}
    options['fields']=
      profile: 1
      roles: 1
      updatedAt:1
    Meteor.users.find(selector,options)

  Meteor.publish 'doctors', ->
    Meteor.users.find {roles:{$in:['doctor']}},
      fields:
        profile: 1
        updatedAt:1

  Meteor.publish 'singleUser',(id,options) ->
    Meteor.users.find {_id:id},options

  Meteor.publish "user",->
    Meteor.users.find {_id:@userId},
      limit:1
      fields:
        profile:1
  Meteor.publish 'singleUserPhoto',(id)->
    Laniakea.Collection.UserPhotos.find(id)
  Meteor.publish 'photos' ,->
    Laniakea.Collection.UserPhotos.find()

##PERIMISSION
Meteor.users.allow
  update:(userId,doc,fieldNames,modifier)->#只允许修改profile字段
    userId
  remove:(userId,doc)->
    userId

Laniakea.Collection.UserPhotos.allow
  'insert':(userId,doc)->
    userId and Roles.userIsInRole(userId,['admin'])
  'update':(userId,doc,fieldNames,modifier)->
    userId and Roles.userIsInRole(userId,['admin'])
  download: (userId, fileObj)->
    userId and Roles.userIsInRole(userId,['admin'])


#   演示数据脚本
##SEED
@Laniakea.Seed.AdminUsersSeeding = (hos,deps) ->

  if Meteor.users.find().count() is 0
    u =
      username: "adm"
      password:"123"
      roles:["admin"]
      profile:
        name:'admin'
        birthday:'1985-06-04'
        sex:'男'
        mobile:'13355639566'

    u._id = Accounts.createUser(u)
    #    console.log 'Seed Admin : ' + u.username

    u2 =
      username: "yqadmin"
      password:"123"
      roles:["hosadmin"]
      profile:
        name:'玉泉管理员'
        birthday:'1986-09-24'
        sex:'男'
        mobile:'15247845875'
        admin:
          hosid:hos?[0]._id
          hos:hos?[0].name

    u2._id = Accounts.createUser(u2)
#    console.log 'Seed hosAdmin : ' + u2.username


@Laniakea.Seed.NursesSeeding = (hos,deps)->
  unless hos? and deps?
    return

  if Roles.getUsersInRole('nurse').count() < 2
    n0 =
      username:'zh'
      password:'123'
      roles:['nurse']
      profile:
        name:'张宏'
        birthday:'1989-06-04'
        sex:'女'
        mobile:'13655639566'
        nurse:
          hosid:hos?[0]._id
          hos:hos?[0].name
          depid:deps?[0]._id
          dep:deps?[0].name
    n0._id = Accounts.createUser(n0)
    #    console.log "Seed Nurse: " + n0.profile.name

    n1 =
      username:'lf'
      password:'123'
      roles:['nurse']
      profile:
        name:'刘芳'
        birthday:'1985-06-04'
        sex:'女'
        mobile:'13355639566'
        nurse:
          hosid:hos?[1]._id
          hos:hos?[1].name
          depid:deps?[1]._id
          dep:deps?[1].name
    n1._id = Accounts.createUser(n1)
    #    console.log "Seed Nurse: " + n1.profile.name

    return [n0,n1]


@Laniakea.Seed.DoctorsSeeding = (hos,deps)->
  unless hos?
    return

  unless deps?
    return

  if Roles.getUsersInRole('doctor').count() < 2

    d0 =
      username:'sl'
      password:'123'
      roles:['doctor','qc']
      profile:
        name:'盛林'
        birthday:'1975-06-04'
        sex:'男'
        mobile:'18610256816'
        photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/3.jpg"
        doctor:
          hosid:hos?[0]._id
          hos:hos?[0].name
          depid:deps?[0]._id
          dep:deps?[0].name
          doct:'副主任医师，副教授'
          exp:'食道癌|肺癌|软组织肿瘤|纵膈肿瘤'
          desc:'复杂骨盆骨折的开放手术及微创手术治疗，对四肢、关节的复杂创伤的开放手术及微创手术也具有丰富的临床经验，同时对脊柱骨折、腰椎滑脱症以及关节疾病的诊断和治疗也较娴熟专业特长 1、复杂C型骨盆骨折的手术重建和微创治疗即外固定架结合透视下空心拉力螺钉固定骶髂关节 2、脊柱创伤及骨病的前后路手术治疗 3、脊柱外科微创技术－经皮椎体成形术（PVP）技术，该技术专门用于治疗老年人骨质疏松导致的脊柱压缩性骨折，脊柱转移性肿瘤的止痛治疗 国外经历：2001、1－2007、9参加中国驻黎巴嫩唯和医疗队'
    d0._id = Accounts.createUser(d0)

    #    console.log "Seed Doctor: " + d0.profile.name

    d1 =
      username:'lp'
      password:'123'
      roles:['doctor','qc']
      profile:
        name:'梁萍'
        birthday:'1968-06-04'
        sex:'女'
        mobile:'17955689566'
        photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/3.jpg"
        doctor:
          hosid:hos?[1]._id
          hos:hos?[1].name
          depid:deps?[1]._id
          dep:deps?[1].name
          doct: '主治医生'
          exp: '肝移植（成人肝移植、小儿肝移植、腹部器官簇移植）、肝切除（肝癌、血管瘤肝门部胆道疾病、胆道疾病）'
          desc: '美国加州大学洛杉矶分校（UCLA）访问学者。专业：小儿肝脏移植，成人肝脏移植，肝切除，胰腺、小肠等腹部器官移植。从事肝脏外科、器官移植工作13年，参与管理肝脏移植手术病人1000余例，参与肝脏移植手术800余例，其中亲体肝移植60余例。在肝癌肝移植术后肿瘤复发、肝移植术后胆道并发症、门静脉血栓的肝移植、供肝获取技术改进及活体肝移植的相关技术等领域内进行了深入研究'
    #          qr: "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHQ8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0RVUlFqWS1rVzJvaWF6X0RBR3dvAAIE3QGmVQMEAAAAAA=="
    d1._id = Accounts.createUser(d1)

    #    console.log "Seed Doctor: " + d1.profile.name

    d2 =
      username:'tj'
      password:'123'
      roles:['doctor']
      profile:
        name:'田军'
        birthday:'1969-06-04'
        sex:'男'
        mobile:'13655689566'
        photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/5.jpg"
        doctor:
          hosid:hos?[0]._id
          hos:hos?[0].name
          depid:deps?[0]._id
          dep:deps?[0].name
          doct: '主治医生'
          exp: '肝移植（成人肝移植、小儿肝移植、腹部器官簇移植）、肝切除（肝癌、血管瘤肝门部胆道疾病、胆道疾病）'
          desc: '美国加州大学洛杉矶分校（UCLA）访问学者。专业：小儿肝脏移植，成人肝脏移植，肝切除，胰腺、小肠等腹部器官移植。从事肝脏外科、器官移植工作13年，参与管理肝脏移植手术病人1000余例，参与肝脏移植手术800余例，其中亲体肝移植60余例。在肝癌肝移植术后肿瘤复发、肝移植术后胆道并发症、门静脉血栓的肝移植、供肝获取技术改进及活体肝移植的相关技术等领域内进行了深入研究'
    #          qr: "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHQ8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0RVUlFqWS1rVzJvaWF6X0RBR3dvAAIE3QGmVQMEAAAAAA=="
    d2._id = Accounts.createUser(d2)

    #    console.log "Seed Doctor: " + d2.profile.name

    d3 =
      username:'zl'
      password:'123'
      roles:['doctor']
      profile:
        name:'张磊'
        birthday:'1975-06-04'
        sex:'男'
        mobile:'17955689566'
        photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/6.jpg"
        doctor:
          hosid:hos?[1]._id
          hos:hos?[1].name
          depid:deps?[1]._id
          dep:deps?[1].name
          doct: '主治医生'
          exp: '肝移植（成人肝移植、小儿肝移植、腹部器官簇移植）、肝切除（肝癌、血管瘤肝门部胆道疾病、胆道疾病）'
          desc: '美国加州大学洛杉矶分校（UCLA）访问学者。专业：小儿肝脏移植，成人肝脏移植，肝切除，胰腺、小肠等腹部器官移植。从事肝脏外科、器官移植工作13年，参与管理肝脏移植手术病人1000余例，参与肝脏移植手术800余例，其中亲体肝移植60余例。在肝癌肝移植术后肿瘤复发、肝移植术后胆道并发症、门静脉血栓的肝移植、供肝获取技术改进及活体肝移植的相关技术等领域内进行了深入研究'
    #          qr: "https://mp.weixin.qq.com/cgi-bin/showqrcode?ticket=gQHQ8DoAAAAAAAAAASxodHRwOi8vd2VpeGluLnFxLmNvbS9xL0RVUlFqWS1rVzJvaWF6X0RBR3dvAAIE3QGmVQMEAAAAAA=="
    d3._id = Accounts.createUser(d3)

    #    console.log "Seed Doctor: " + d3.profile.name

    return [d0,d1,d2,d3]


@Laniakea.Seed.PatientsSeeding = (hos,deps,docs)->
  unless hos?
    return

  unless deps?
    return

  unless docs?
    return

  if Roles.getUsersInRole('patient').count() > 10
    return


  #第1个医生的患者
  pats = []
  pids = []

  p0 =
    username:'p0'
    password:'123'
    roles:['patient']
    profile:
      name:'王大锤'
      sex:'男'
      birthday:'1969-06-04'
      mobile:'13755689566'
      photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/6.jpg"
      patient:
        hosids:[hos?[0]._id,hos?[1]._id]
        prmdocid:docs?[0]._id
  p0._id = Accounts.createUser(p0)
  pats.push p0
  #  console.log "Seed Patient: " + p0.profile.name
  pids.push p0._id

  #
  p1 =
    username:'pat1'
    password:'123'
    roles:['patient']
    profile:
      name:'郭景'
      sex:'女'
      birthday:'1984-06-04'
      mobile:'13755389566'
      photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/3.jpg"
      patient:
        hosids:[hos?[0]._id,hos?[1]._id]
        docids:[docs?[0]._id]
  p1._id = Accounts.createUser(p1)
  pats.push p1
  #  console.log "Seed Patient: " + p1.profile.name
  pids.push p1._id


  #
  p2 =
    username:'pat2'
    password:'123'
    roles:['patient']
    profile:
      name:'张小喵'
      sex:'女'
      birthday:'1989-06-04'
      mobile:'13755689566'
      photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/4.jpg"
      patient:
        hosids:[hos?[0]._id,hos?[1]._id]
        prmdocid:docs?[0]._id
  p2._id = Accounts.createUser(p2)
  pats.push p2
  #  console.log "Seed Patient: " + p2.profile.name
  pids.push p2._id

  #
  p3 =
    username:'pat3'
    password:'123'
    roles:['patient']
    profile:
      name:'兰小暖'
      sex:'女'
      birthday:'1985-06-04'
      mobile:'13755689566'
      photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/8.jpg"
      patient:
        hosids:[hos?[0]._id,hos?[1]._id]
        prmdocid:docs?[0]._id
  p3._id = Accounts.createUser(p3)
  pats.push p3
  #  console.log "Seed Patient: " + p3.profile.name
  pids.push p3._id


  #
  p4 =
    username:'pat4'
    password:'123'
    roles:['patient']
    profile:
      name:'刘丹强'
      sex:'女'
      birthday:'1984-06-04'
      mobile:'18455689566'
      photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/7.jpg"
      patient:
        hosids:[hos?[0]._id,hos?[1]._id]
        prmdocid:docs?[0]._id
  p4._id = Accounts.createUser(p4)
  pats.push p4
  #  console.log "Seed Patient: " + p4.profile.name
  pids.push p4._id



  #
  p5 =
    username:'pat5'
    password:'123'
    roles:['patient']
    profile:
      name:'朱小雷'
      sex:'男'
      birthday:'1982-06-04'
      mobile:'18455689566'
      photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/5.jpg"
      patient:
        hosids:[hos?[0]._id,hos?[1]._id]
        prmdocid:docs?[0]._id
  p5._id = Accounts.createUser(p5)
  pats.push p5
  #  console.log "Seed Patient: " + p5.profile.name
  pids.push p5._id




  pids = []

  #
  p6 =
    username:'pat6'
    password:'123'
    roles:['patient']
    profile:
      name:'林小洁'
      sex:'女'
      birthday:'1968-06-04'
      mobile:'18837689566'
      photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/1.jpg"
      patient:
        hosids:[hos?[0]._id,hos?[1]._id]
        prmdocid:docs?[0]._id
  p6._id = Accounts.createUser(p6)
  pats.push p6
  #  console.log "Seed Patient: " + p6.profile.name
  pids.push p6._id


  p7 =
    username:'p7'
    password:'123'
    roles:['patient']
    profile:
      name:'董大鹏'
      sex:'男'
      birthday:'1978-06-04'
      mobile:'18835689566'
      photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/9.jpg"
      patient:
        hosids:[hos?[1]._id]
        prmdocid:docs?[1]._id
  p7._id = Accounts.createUser(p7)
  pats.push p7
  #  console.log "Seed Patient: " + p7.profile.name
  pids.push p7._id



  p8 =
    username:'pat8'
    password:'123'
    roles:['patient']
    profile:
      name:'王海'
      sex:'男'
      birthday:'1976-06-04'
      mobile:'18835689566'
      photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/2.jpg"
      patient:
        hosids:[hos?[1]._id]
        prmdocid:docs?[1]._id
  p8._id = Accounts.createUser(p8)
  pats.push p8
  #  console.log "Seed Patient: " + p8.profile.name
  pids.push p8._id


  return pats