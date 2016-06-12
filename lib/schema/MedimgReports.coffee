#console.log 'Loading MedimgReports.coffee'
# 医学影像报告
# 以报告形式存在的医学影像形式
# 通过Mod(Modality模态)字段区别相关影像模态，包括US, MR, DR，CT等

##COLLECTION
@Laniakea.Collection.MedimgReports = new Mongo.Collection "medimgReports"

Laniakea.Collection.MedimgReportImages = new FS.Collection('medimgReportImages',
  stores: [
    new FS.Store.FileSystem('medimgReportImages', path: '/dfs/lan/us'),
    new FS.Store.FileSystem('medimgReportThumbs',
      transformWrite: (fileObj, readStream, writeStream) ->
        unless fileObj.isVideo()
          console.log 'medimgReportImages resize60',fileObj._id
          gm(readStream).resize(60).stream('PNG').pipe writeStream
    )
  ]
)
Laniakea.Collection.MedimgReportVideos = new FS.Collection('medimgReportVideos',
  stores: [
    new FS.Store.FileSystem('medimgReportVideos', path: '/dfs/lan/us'),
  ]
)
Laniakea.Collection.Upload = new FS.Collection('upload',
  stores: [
    new FS.Store.FileSystem('upload', path: '/upload'),
  ]
)
if Meteor.isServer
  Meteor.publish 'singleUploadFile',(id)->
    Laniakea.Collection.Upload.find(id)

##PERIMISSION
Laniakea.Collection.Upload.allow
  'insert':(userId,doc)->
    userId and Roles.userIsInRole(userId,['doctor'])
  'update':(userId,doc,fieldNames,modifier)->
    userId and Roles.userIsInRole(userId,['doctor'])
  download: (userId, fileObj)->
    true

##INDEX
if Meteor.isServer
  @Laniakea.Collection.MedimgReports._ensureIndex {si: 1}
  @Laniakea.Collection.MedimgReports._ensureIndex {state: 1}
  @Laniakea.Collection.MedimgReports._ensureIndex {patid: 1}
  @Laniakea.Collection.MedimgReports._ensureIndex {docid: 1}
  @Laniakea.Collection.MedimgReports._ensureIndex {depid: 1}
  @Laniakea.Collection.MedimgReports._ensureIndex {st: 1}

##SCHEMA
@Laniakea.Schema.ReportImageItem = new SimpleSchema

  fid:
    type:String
    optional:true

  url:
    type: String
    optional: false

  print:
    type: Boolean
    optional: true


@Laniakea.Schema.ReportVideoItem = new SimpleSchema
  webm:
    type: String
    optional: true
  mp4:
    type:String
    optional:true
  img:
    type:String
    optional:true

@Laniakea.Schema.ReportLog = new SimpleSchema
  uid:
    type:String
    label:'操作用户的id '
  u:
    type:String
    label:'操作人'
  a:
    type:String
    label:'操作动作'
  c:
    type:String
    label:'操作内容'
    optional:true
    autoform:
      afFieldInput:
        type:'textarea'
  t:
    type:Date
    label:'操作时间'
    optional:true
    autoValue: ->
      new Date

#@Laniakea.Schema.Exm = new SimpleSchema
#  pt:
#    type:String
#    label:'检查部位'
#    optional:true
#
#  itm:
#    type:String
#    label:'检查项目'
#    optional:true
#
#  fee:
#    type:String
#    label:'费用'
#    optional:true

@Laniakea.Schema.MedimageReport = new SimpleSchema
##需要用于检索的字段
  patid:
    type: String
    label: '患者id'
    optional: false

  docid:
    type:String
    label:'检查医生id'
    optional:false

  depid:
    type:String
    label:'检查科室id'
    optional:false
  dep:
    type:String
    label:'检查科室'
    optional:true

  hosid:
    type: String
    label: "医院编号"
    optional: true
  hos:
    type: String
    label: "医院名称"
    optional: true

##基本信息

#报告状态（包含质控信息）
  state:
    type:String
    optional:false
    label:'报告状态'
    allowedValues:['已新建','编辑中','已保存','已打回','已审核','已打印']
    autoValue: ->
      if this.field('state').value?
        this.field('state').value
      else if @isInsert
        '已新建'
    autoform:
      omit:true
  logs:
    type:[@Laniakea.Schema.ReportLog]
    optional:false
    label:'报告日志'

  mod:
    type:String
    optional:false
    label:'模态'
    autoform:
      allowedValues:['US','CT','MR','XR']
      options:->
        US:'US'
        CT:'CT'
        MR:'MR'
        XR:'XR'

#  exms:
#    type:[@Laniakea.Schema.Exm]
#    label: '检查项'
#    optional: true

  exmpt:
    type:String
    label:'检查部位'
    autoform:
      afFieldInput:
        firstOption:'请选择'
    optional:true

  exmitm:
    type:String
    label:'检查项目'
    autoform:
      afFieldInput:
        firstOption:'请选择'
    optional:true

  fee:
    type:String
    label:'费用'
    optional:true

  pat:
    type: String
    label: '患者姓名'
    optional: true

  age:
    type: String
    label: '患者年龄'
    optional: true

  sex:
    type:String
    label:'患者性别'
    optional:true

  diag:
    type:String
    optional:true
    label:'初始诊断'

  dev:
    type:String
    optional:true
    label:'设备名称'

  apldep:
    type:String
    label:'申请科室'
    optional:true

  apldoc:
    type:String
    optional:true
    label:'申请医生'

  doc:
    type:String
    label:'检查医生'
    optional:true

  room:
    type:String
    label:'诊室'
    optional:true

  src:
    type:String
    label:'来源'
    optional:true
    autoform:
      allowedValues:['住院','门诊','急诊','预约']
      options:->
        住院:'住院'
        门诊:'门诊'
        急诊:'急诊'
        预约:'预约'

  find:
    type: String
    label:'影像所见'
    optional:true
    autoform:
      afFieldInput:
        type:'textarea'

  hint:
    type:String
    label: '影像所得'
    optional:true
    autoform:
      afFieldInput:
        type:'textarea'

  st:
    type:Date
    label:'开始时间'
    optional:true
    autoValue: ->
      if @isInsert
        new Date
      else if @isUpsert
        $setOnInsert: new Date
      else
        @unset()

# 影像列表
  imgs:
    type: [Laniakea.Schema.ReportImageItem ]
    optional: true
    label: '影像列表'

  vids:
    type: [Laniakea.Schema.ReportVideoItem]
    optional: true
    label: '视频列表'

# 自动生成的字段
  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['pat','doc','exmpt','exmitm'])

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
    type: Date
    autoValue: ->
        new Date
    autoform:
      omit: true

  wlid:
    type:String
    label: '工作流编号'
    optional:true
@Laniakea.Collection.MedimgReports.attachSchema Laniakea.Schema.MedimageReport

##PUBLISH
if Meteor.isServer
  Meteor.publish 'singleMedimgReport',(id)->
    Laniakea.Collection.MedimgReports.find(id)

  Meteor.publish 'medimgReports',(selector,options)->
    if @.userId?
      if @.user?.profile?.doctor?
        depid = @.user?.profile?.doctor?.depid
      if @.user?.profile?.nurse?
        depid = @.user?.profile?.nurse?.depid
      if depid? and depid
        selector['depid']=depid

      unless selector
        selector = {}
        if depid? and depid
          selector.depid=depid
        if @user?.profile?.doctor?
          selector.docid = @userId
      else
        text = selector?.si
        selector['$or'] =[
          'si': new RegExp(text,'i')
        ]
        delete selector.si
        unless selector['docid']
          if @user?.profile?.doctor?
            selector.docid = @userId

      unless options
        options = {}
        options.limit = 100
      Laniakea.Collection.MedimgReports.find(
        selector
        options
      )
  Meteor.publish 'singleMedimgReportImage',(id)->
    Laniakea.Collection.MedimgReportImages.find(id)
  Meteor.publish 'singleMedimgReportVideo',(id)->
    Laniakea.Collection.MedimgReportVideos.find(id)

##PERIMISSION
Laniakea.Collection.MedimgReports.allow
  'insert':(userId,doc)->
    userId and Roles.userIsInRole(userId,['doctor'])
  'update':(userId,doc,fieldNames,modifier)->
    userId and Roles.userIsInRole(userId,['doctor'])

Laniakea.Collection.MedimgReportImages.allow
  'insert':(userId,doc)->
    userId and Roles.userIsInRole(userId,['doctor'])
  'update':(userId,doc,fieldNames,modifier)->
    userId and Roles.userIsInRole(userId,['doctor'])
  download: (userId, fileObj)->
    userId and Roles.userIsInRole(userId,['doctor'])

Laniakea.Collection.MedimgReportVideos.allow
  'insert':(userId,doc)->
    userId
  'update':(userId,doc,fieldNames,modifier)->
    userId
  download: (userId, fileObj)->
    true

#SEED
@Laniakea.Seed.MedimgReportsSeeding =(deps,docs,pats) ->
  if Laniakea.Collection.MedimgReports.find({}).count() is 0
#    console.log '@Laniakea.Seed.MedimgReports...'



    r =
      patid: pats?[0]._id   #患者id
      docid:docs?[0]._id    #检查医生id
      depid: deps?[0]._id   # 检查科室id
      dep:deps?[0].name #检查科室
      hosid:deps?[0].hosid  #医院信息
      hos:deps?[0].hos  #医院信息
      mod: 'US'         #超声影像
      exmpt: '腹部'      #检查部位
      exmitm: '肝脏'     #检查项目
      pat: '王大锤'      #姓名
      age: 22           #年龄
      sex: '男'
      diag: '怀疑是肝癌' #初始诊断
      dev: 'Terason 3000' #检查设备
      apldep: '外科'  #申请科室
      apldoc: docs?[2].name #申请医生
      doc: docs?[0].profile.name #检查医生
      room: '一诊室'
      src: '门诊'
      st:  new Date #检查开始时间
      find:'肝脏:体积正常,形态规整,右前叶下段可见一1.0x0.8cm的无回声囊,余实质回声均匀,肝内管道结构清晰;肝内胆管无扩张;门静脉内径正常. 胆囊缩小,大小3.6x1.6cm,壁厚,毛糙,壁上可见点状强回声,大小0.4cm. 胰腺:体积正常,形态规整,实质回声均匀,主胰管不扩张. 脾脏:体积正常,形态规整,实质厚度正常,回声正常,皮髓质界限清晰,集合系统未探及分离. 平卧们:腹腔扫查未探及明显游离液体.'
      hint:'肝囊肿. 胆囊缩小,胆囊壁胆固醇结晶,符合慢性胆囊炎声像图改变.'
      imgs:[
        {
          'url': 'http://mimas-img.oss-cn-beijing.aliyuncs.com/17647225b86c47fc86089d1bff2ad450.jpg'
          'print': true
        },
        {
          'url': 'http://mimas-img.oss-cn-beijing.aliyuncs.com/371e09ccf6af4539b81ce487af2ce8bb.jpg'
          'print': false
        }
      ]
      vids: [
        {
          'img': 'http://mimas-img.oss-cn-beijing.aliyuncs.com/371e09ccf6af4539b81ce487af2ce8bb.jpg'
          'mp4': 'http://mimas-video.oss-cn-beijing.aliyuncs.com/552b23e9800b6e0418000001.mp4'
        }
      ]
      state:'编辑中'
      logs:[
        {
          uid:docs?[0]._id
          u:docs?[0].username
          a:'创建报告'
          c:'创建患者' + pats?[0].profile.name + '的报告'
          t: new Date
        }
        {
          uid:docs?[0]._id
          u:docs?[0].username
          a:'开始检查'
          c:'开始为患者' + pats?[0].profile.name + '检查超声'
          t: new Date
        }
      ]

    r0 = r
    Laniakea.Collection.MedimgReports.insert(r0)

    r1 = r
    r1.patid = pats?[1]._id
    r1.pat = pats?[1].profile.name
    r1.sex = pats?[1].profile.sex
    r1.state = '已保存'
    Laniakea.Collection.MedimgReports.insert(r1)


    r2 = r
    r2.patid = pats?[2]._id
    r2.pat = pats?[2].profile.name
    r2.sex = pats?[2].profile.sex
    r2.state = '已新建'
    Laniakea.Collection.MedimgReports.insert(r2)

    r3 = r
    r3.patid = pats?[3]._id
    r3.pat = pats?[3].profile.name
    r3.sex = pats?[3].profile.sex
    r3.state = '已打回'
    Laniakea.Collection.MedimgReports.insert(r3)

    r4 = r
    r4.patid = pats?[4]._id
    r4.pat = pats?[4].profile.name
    r4.sex = pats?[4].profile.sex
    r4.state = '已打印'
    Laniakea.Collection.MedimgReports.insert(r4)

    r5 = r
    r5.patid = pats?[5]._id
    r5.pat = pats?[5].profile.name
    r5.sex = pats?[5].profile.sex
    r5.state = '已审核'
    r5._id=Laniakea.Collection.MedimgReports.insert(r5)

    return r5



