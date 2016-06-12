# 手术信息
#


@Laniakea.Collection.Surgeries = new Mongo.Collection "surgeries"

## Indexing
if Meteor.isServer
  @Laniakea.Collection.MedimgReports._ensureIndex {si: 1}
  @Laniakea.Collection.MedimgReports._ensureIndex {state: 1}
  @Laniakea.Collection.MedimgReports._ensureIndex {patid: 1}
  @Laniakea.Collection.MedimgReports._ensureIndex {docid: 1}
  @Laniakea.Collection.MedimgReports._ensureIndex {depid: 1}
  @Laniakea.Collection.MedimgReports._ensureIndex {st: 1}


@Laniakea.Schema.Surgery = new SimpleSchema
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

  state:
    type:String
    optional:false
    label:'手术状态'
    allowedValues:['新建','预约','术前','术中','术后']
    autoValue: ->
      if this.field('state').value?
        this.field('state').value
      else if @isInsert
        '新建'
    autoform:
      omit:true

  pat:
    type: String
    label: '患者姓名'
    optional: true

  age:
    type: Number
    label: '患者年龄'
    optional: true

  sex:
    type:String
    label:'患者性别'
    optional:true

  doc:
    type:String
    label:'医生'
    optional:true

# 自动生成的字段
  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['pat','doc'])
  @Laniakea.Schema.volume = new SimpleSchema(
# .. and attach the single-file dicom in .NRRD format
# this works with gzip/gz/raw encoded NRRD files but XTK also supports other
# formats like MGH/MGZ
    vf:
      type: String
      optional:true
      label:''
  )
  @Laniakea.Schema.mesh = new SimpleSchema(
# .. and is loaded from a .VTK file
    mf:
      type: String
      optional:true
      label:''
    mc:  #color
      type: String
      optional:true
      label:''
    mo:
      type: String
      optional:true
      label:''
    mv:
      type: String
      optional:true
      label:''
  )

#SurgeryPlan 手术计划
#  sp:



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

@Laniakea.Collection.Surgeries.attachSchema Laniakea.Schema.Surgery


# PUBLISH





# SEED


@Laniakea.Seed.SurgeriesSeeding =(deps,docs,pats) ->
  if Laniakea.Collection.Surgeries.find({}).count() is 0
#    console.log '@Laniakea.Seed.Surgeries...'


    s =
      patid: pats?[0]._id   #患者id
      docid:docs?[0]._id    #检查医生id
      depid: deps?[0]._id   # 检查科室id
      pat: '王大锤'      #姓名
      age: 22           #年龄
      sex: '男'
      doc: docs?[0].profile.name #检查医生
      st:  new Date #检查开始时间

    s._id = Laniakea.Collection.Surgeries.insert(s)
