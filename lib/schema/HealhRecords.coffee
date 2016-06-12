#console.log 'Loading HealthRecordsc.coffee'

##COLLECTION
@Laniakea.Collection.HealthRecords = new Mongo.Collection "healthRecords"

##INDEX

##SCHEMA
# 心率数据 HeartRate
@Laniakea.Schema.HeartRate = new SimpleSchema(
  t:
    type: Date
    label: "测量时间"
    optional: true
  v:
    type: Number
    label: "心率"
    decimal: true
    optional: true
)

# 体重数据 weights
@Laniakea.Schema.Weight = new SimpleSchema(
  t:
    type: Date
    label: "测量时间"
    optional: true
  v:
    type: Number
    label: "体重"
    decimal: true
    optional: true
)

# 血氧数据 bo
@Laniakea.Schema.Bo = new SimpleSchema(
  t:
    type: Date
    label: "测量时间"
    optional: true
  v:
    type: Number
    label: "血氧"
    decimal: true
    optional: true
)

# 血糖数据 bg
@Laniakea.Schema.Bg = new SimpleSchema(
  t:
    type: Date
    label: "测量时间"
    optional: true
  v:
    type: Number
    label: "血糖"
    decimal: true
    optional: true
)

# 运动数据 Activity
@Laniakea.Schema.Activity = new SimpleSchema(
  t:
    type: Date
    label: "测量时间"
    optional: true
  step:
    type: Number
    label: "步数"
    decimal: true
    optional: true
)

# 血压数据 BloodPressure
@Laniakea.Schema.Bp = new SimpleSchema(
  t:
    type: Date
    label: "测量时间"
    optional: true
  hv:
    type: Number
    label: "高压"
    decimal: true
    optional: true
  lv:
    type: Number
    label: "低压"
    decimal: true
    optional: true
)
#心电图数据 ecg
@Laniakea.Schema.Ecg=new SimpleSchema(
  e:
    type:String
    label:"心电图Base64编码的数据"
    optional:false
  t:
    type:Date
    label:'测量时间'
    optional:true
  _id:
    type:String
    label:'标识符'
    optional:false
)
#最新的测量数据
@Laniakea.Schema.LatestData=new SimpleSchema(
  wt:
    type: Laniakea.Schema.Weight
    label: "体重数据"
    optional: true
  bo:
    type:Laniakea.Schema.Bo
    label:"血氧数据"
    optional:true
  bg:
    type:Laniakea.Schema.Bg
    label:"血糖"
    optional:true

  ac:
    type:Laniakea.Schema.Activity
    label:"运动数据"
    optional:true
  bp:
    type:Laniakea.Schema.Bp
    label:"血压数据"
    optional:true
  heart:
    type:Laniakea.Schema.HeartRate
    label:"心率数据"
    optional:true
)

#患者病史
@Laniakea.Schema.MedicalHistory=new SimpleSchema(
  mt:
    type:String
    label:"疾病类型"
    optional:true
  fh:
    type:[String]
    label:"家族遗传病史"
    optional:true
  ad:
    type:[String]
    label:"过敏药物"
    optional:true
  fca:
    type:[String]
    label:"食物及接触过敏"
    optional:true
#  Vaccination
  vac:
    type:[String]
    label:"预防接种史"
    optional:true
#  anamnesis
  ana:
    type:[String]
    label:"既往病史"
    optional:true
)

# 总定义
@Laniakea.Schema.HealthRecords = new SimpleSchema(
  hr:
    type: [ Laniakea.Schema.HeartRate ]
    label: "心率"
    optional: true

  wt:
    type: [ Laniakea.Schema.Weight ]
    label: "体重"
    optional: true
  bo:
    type:[Laniakea.Schema.Bo]
    label:"血氧"
    optional:true

  bbbg:
    type: [ Laniakea.Schema.Bg ]
    label: "早餐前血糖数据"
    optional: true

  abbg:
    type: [ Laniakea.Schema.Bg ]
    label: "早餐后血糖数据"
    optional: true

  blbg:
    type: [ Laniakea.Schema.Bg ]
    label: "午餐前血糖数据"
    optional: true

  albg:
    type: [ Laniakea.Schema.Bg ]
    label: "午餐后血糖数据"
    optional: true
  bdbg:
    type: [ Laniakea.Schema.Bg ]
    label: "晚餐前血糖数据"
    optional: true

  adbg:
    type: [ Laniakea.Schema.Bg ]
    label: "晚餐后血糖数据"
    optional: true

  bsbg:
    type: [ Laniakea.Schema.Bg ]
    label: "睡前血糖数据"
    optional: true

  asbg:
    type: [ Laniakea.Schema.Bg ]
    label: "零食后血糖数据"
    optional: true
  ac:
    type:[Laniakea.Schema.Activity]
    label:"运动"
    optional:true
  bp:
    type:[Laniakea.Schema.Bp]
    label:"血压"
    optional:true

  ld:
    type:Laniakea.Schema.LatestData
    label:"最新测量"
    optional:true
  mh:
    type:Laniakea.Schema.MedicalHistory
    label:"患者病史"
    optional:true
  ecg:
    type:[Laniakea.Schema.Ecg]
    label:"心电图"
    optional:true
  mirs:
    type:[Object]
    label:"影像报告"
    optional:true

  'mirs.$._id':
    type:String
    label:"报告id"

  'mirs.$.exmpt':
    type:String
    label:'检查部位'
    optional:true

  'mirs.$.exmitm':
    type:String
    label:'检查项目'
    optional:true

  'mirs.$.pat':
    type: String
    label: '患者姓名'
    optional: true

  'mirs.$.age':
    type: Number
    label: '患者年龄'
    optional: true

  'mirs.$.sex':
    type:String
    label:'患者性别'
    optional:true

  'mirs.$.dev':
    type:String
    optional:true
    label:'设备名称'

  'mirs.$.hos':
    type:String
    label:'医院名称'
    optional:true

  'mirs.$.doc':
    type:String
    label:'检查医生'
    optional:true

  'mirs.$.st':
    type:Date
    label:'开始时间'
    optional:true

  ds:
    type:[Object]
    label:"影像列表"
    optional:true

  'ds.$._id':
    type:String
    label:'影像ID'
    optional:true

  'ds.$.pn':
    type:String
    label:'患者姓名'
    optional:true

  'ds.$.sd':
    type:String
    label:'检查日期'
    optional:true

  'ds.$.mod':
    type:String
    label:'模态'
    optional:true

  'ds.$.des':
    type:String
    label:'检查描述'
    optional:true

  omr:
    type:[Object]
    label:"门诊病例"
    optional:true

  'omr.$._id':
    type:String
    label:"病例id"

  'omr.$.pat':
    type:String
    label:'患者姓名'
    optional:true

  'omr.$.hos':
    type:String
    label:'诊断医院'
    optional:true

  'omr.$.dep':
    type:String
    label:'诊断科室'
    optional:true

  'omr.$.digt':
    type:String
    label:'诊断时间'
    optional:true

)

@Laniakea.Collection.HealthRecords.attachSchema  Laniakea.Schema.HealthRecords


## PUBLISH
if Meteor.isServer
  Meteor.publish 'healthRecords',(id)->
    Laniakea.Collection.HealthRecords.find(id)
  Meteor.publish 'partialHealthRecords', (id, singleField) ->
    fieldsArr = ['mh', 'ac', 'ld', 'mirs', 'bbbg', 'wt', 'bp', 'bo','hr']
    if _.indexOf fieldsArr, singleField >= 0
      option = {}
      option.fields = {}
      option.fields[singleField] = 1
      console.log option
      Laniakea.Collection.HealthRecords.find id, option
    else
      this.ready()

##PERIMISSION
Laniakea.Collection.HealthRecords.allow
  update:->
    if Meteor.userId()
      true
  insert:->
    if Meteor.userId()
      true

##SEED
@Laniakea.Seed.HealthRecordsSeeding=(rep,dicom,omrs,pat,tags)->
#  console.log "Seed Health Record: " + pat?._id
  if pat?.username=="p0"
    h=
      _id:pat?._id
      wt:[
        {
          'v':50
          't':'2015-06-04'
        }
        {
          'v':70
          't':'2015-06-08'
        }
        {
          'v':60
          't':'2015-06-10'
        }
        {
          'v':65
          't':'2015-06-24'
        }
        {
          'v':64
          't':'2015-06-28'
        }
        {
          'v':69
          't':'2015-07-2'
        }
        {
          'v':68
          't':'2015-07-3'
        }
      ]

      bo:[
        {
          'v':90
          't':'2015-06-04'
        }
        {
          'v':89
          't':'2015-06-08'
        }
        {
          'v':85
          't':'2015-06-10'
        }
        {
          'v':96
          't':'2015-06-20'
        }
        {
          'v':89
          't':'2015-06-29'
        }
        {
          'v':90
          't':'2015-07-03'
        }
      ]
      bbbg:[
        {
          'v':5
          't':'2015-06-04'
        }
        {
          'v':6.3
          't':'2015-06-08'
        }
        {
          'v':4.8
          't':'2015-06-10'
        }
        {
          'v':5.9
          't':'2015-06-20'
        }
        {
          'v':6
          't':'2015-06-29'
        }
        {
          'v':6.5
          't':'2015-07-03'
        }
      ]
      abbg:[
        {
          'v':5.2
          't':'2015-06-04'
        }
        {
          'v':5.3
          't':'2015-06-08'
        }
        {
          'v':4.8
          't':'2015-06-10'
        }
        {
          'v':4.9
          't':'2015-06-20'
        }
        {
          'v':6
          't':'2015-06-29'
        }
        {
          'v':5
          't':'2015-07-03'
        }
      ]
      blbg:[
        {
          'v':4.2
          't':'2015-06-04'
        }
        {
          'v':5.3
          't':'2015-06-08'
        }
        {
          'v':5.8
          't':'2015-06-10'
        }
        {
          'v':4.9
          't':'2015-06-20'
        }
        {
          'v':5
          't':'2015-06-29'
        }
        {
          'v':6
          't':'2015-07-03'
        }
      ]
      albg:[
        {
          'v':5.2
          't':'2015-06-04'
        }
        {
          'v':5.3
          't':'2015-06-08'
        }
        {
          'v':6.8
          't':'2015-06-10'
        }
        {
          'v':5
          't':'2015-06-20'
        }
        {
          'v':6
          't':'2015-06-29'
        }
        {
          'v':5
          't':'2015-07-03'
        }
      ]
      bdbg:[
        {
          'v':4.2
          't':'2015-06-04'
        }
        {
          'v':6.3
          't':'2015-06-08'
        }
        {
          'v':6.8
          't':'2015-06-10'
        }
        {
          'v':6
          't':'2015-06-20'
        }
        {
          'v':5
          't':'2015-06-29'
        }
        {
          'v':4
          't':'2015-07-03'
        }
      ]
      adbg:[
        {
          'v':5.2
          't':'2015-06-04'
        }
        {
          'v':5.3
          't':'2015-06-08'
        }
        {
          'v':4.8
          't':'2015-06-10'
        }
        {
          'v':5
          't':'2015-06-20'
        }
        {
          'v':6
          't':'2015-06-29'
        }
        {
          'v':5
          't':'2015-07-03'
        }
      ]
      bsbg:[
        {
          'v':6.2
          't':'2015-06-04'
        }
        {
          'v':5.3
          't':'2015-06-08'
        }
        {
          'v':4.8
          't':'2015-06-10'
        }
        {
          'v':4
          't':'2015-06-20'
        }
        {
          'v':5
          't':'2015-06-29'
        }
        {
          'v':5
          't':'2015-07-03'
        }
      ]
      asbg:[
        {
          'v':5.2
          't':'2015-06-04'
        }
        {
          'v':6.3
          't':'2015-06-08'
        }
        {
          'v':5.8
          't':'2015-06-10'
        }
        {
          'v':6
          't':'2015-06-20'
        }
        {
          'v':4
          't':'2015-06-29'
        }
        {
          'v':5
          't':'2015-07-03'
        }
      ]
      ac:[
        {
          'step':100
          't':'2015-06-04'
        }
        {
          'step':60
          't':'2015-06-08'
        }
        {
          'step':40
          't':'2015-06-10'
        }
        {
          'step':50
          't':'2015-06-20'
        }
        {
          'step':60
          't':'2015-06-29'
        }
        {
          'step':70
          't':'2015-07-03'
        }
      ]
      bp:[
        {
          'hr':60
          'hv':100
          'lv':80
          't':'2015-06-04'
        }
        {
          'hr':65
          'hv':130
          'lv':90
          't':'2015-06-08'
        }
        {
          'hr':80
          'hv':110
          'lv':85
          't':'2015-06-10'
        }
        {
          'hr':89
          'hv':115
          'lv':89
          't':'2015-06-20'
        }
        {
          'hr':86
          'hv':113
          'lv':90
          't':'2015-06-29'
        }
        {
          'hr':88
          'hv':110
          'lv':85
          't':'2015-07-03'
        }
      ]
      ld:{
        wt:
          'v':68
          't':'2015-07-3'
        bo:
          'v':90
          't':'2015-07-03'
        bg:
          'v':6.5
          't':'2015-07-03'
        bp:
          'hr':88
          'hv':110
          'lv':85
          't':'2015-07-03'
        ac:
          'step':70
          't':'2015-07-03'
      }
      mh:{
        mt:"脑血管畸形"
        fh: [tags[0][0]._id,tags[0][2]._id,tags[0][5]._id]
        ad: [tags[1][0]._id,tags[1][2]._id,tags[1][5]._id]
        fca: [tags[2][0]._id,tags[2][2]._id,tags[2][5]._id]
        vac: [tags[3][0]._id,tags[3][1]._id,tags[3][3]._id]
        ana: [tags[4][0]._id,tags[4][2]._id,tags[4][4]._id]
      }
      mirs:[
        {
          _id:rep._id
          pat:pat.profile.name
          age:pat.profile.age
          sex:pat.profile.sex
          dev:rep.dev
          exmpt:rep.exmpt
          exmitm:rep.exmitm
          st:rep.st
        }
      ]
      ds:[
        {
          _id:dicom._id
          pn:dicom.pn
          sd:dicom.sd
          mod:dicom.mod
          des:dicom.des
        }
      ]
      omr:omrs

    Laniakea.Collection.HealthRecords.insert(h)
  else
    h=
      _id:pat?._id
      wt:[
        {
          'v':50
          't':'2015-06-04'
        }
        {
          'v':70
          't':'2015-06-08'
        }
        {
          'v':60
          't':'2015-06-10'
        }
        {
          'v':65
          't':'2015-06-24'
        }
        {
          'v':64
          't':'2015-06-28'
        }
        {
          'v':69
          't':'2015-07-2'
        }
        {
          'v':68
          't':'2015-07-3'
        }
      ]

      bo:[
        {
          'v':90
          't':'2015-06-04'
        }
        {
          'v':89
          't':'2015-06-08'
        }
        {
          'v':85
          't':'2015-06-10'
        }
        {
          'v':96
          't':'2015-06-20'
        }
        {
          'v':89
          't':'2015-06-29'
        }
        {
          'v':90
          't':'2015-07-03'
        }
      ]
      bbbg:[
        {
          'v':5
          't':'2015-06-04'
        }
        {
          'v':6.3
          't':'2015-06-08'
        }
        {
          'v':4.8
          't':'2015-06-10'
        }
        {
          'v':5.9
          't':'2015-06-20'
        }
        {
          'v':6
          't':'2015-06-29'
        }
        {
          'v':6.5
          't':'2015-07-03'
        }
      ]
      abbg:[
        {
          'v':5.2
          't':'2015-06-04'
        }
        {
          'v':5.3
          't':'2015-06-08'
        }
        {
          'v':4.8
          't':'2015-06-10'
        }
        {
          'v':4.9
          't':'2015-06-20'
        }
        {
          'v':6
          't':'2015-06-29'
        }
        {
          'v':5
          't':'2015-07-03'
        }
      ]
      blbg:[
        {
          'v':4.2
          't':'2015-06-04'
        }
        {
          'v':5.3
          't':'2015-06-08'
        }
        {
          'v':5.8
          't':'2015-06-10'
        }
        {
          'v':4.9
          't':'2015-06-20'
        }
        {
          'v':5
          't':'2015-06-29'
        }
        {
          'v':6
          't':'2015-07-03'
        }
      ]
      albg:[
        {
          'v':5.2
          't':'2015-06-04'
        }
        {
          'v':5.3
          't':'2015-06-08'
        }
        {
          'v':6.8
          't':'2015-06-10'
        }
        {
          'v':5
          't':'2015-06-20'
        }
        {
          'v':6
          't':'2015-06-29'
        }
        {
          'v':5
          't':'2015-07-03'
        }
      ]
      bdbg:[
        {
          'v':4.2
          't':'2015-06-04'
        }
        {
          'v':6.3
          't':'2015-06-08'
        }
        {
          'v':6.8
          't':'2015-06-10'
        }
        {
          'v':6
          't':'2015-06-20'
        }
        {
          'v':5
          't':'2015-06-29'
        }
        {
          'v':4
          't':'2015-07-03'
        }
      ]
      adbg:[
        {
          'v':5.2
          't':'2015-06-04'
        }
        {
          'v':5.3
          't':'2015-06-08'
        }
        {
          'v':4.8
          't':'2015-06-10'
        }
        {
          'v':5
          't':'2015-06-20'
        }
        {
          'v':6
          't':'2015-06-29'
        }
        {
          'v':5
          't':'2015-07-03'
        }
      ]
      bsbg:[
        {
          'v':6.2
          't':'2015-06-04'
        }
        {
          'v':5.3
          't':'2015-06-08'
        }
        {
          'v':4.8
          't':'2015-06-10'
        }
        {
          'v':4
          't':'2015-06-20'
        }
        {
          'v':5
          't':'2015-06-29'
        }
        {
          'v':5
          't':'2015-07-03'
        }
      ]
      asbg:[
        {
          'v':5.2
          't':'2015-06-04'
        }
        {
          'v':6.3
          't':'2015-06-08'
        }
        {
          'v':5.8
          't':'2015-06-10'
        }
        {
          'v':6
          't':'2015-06-20'
        }
        {
          'v':4
          't':'2015-06-29'
        }
        {
          'v':5
          't':'2015-07-03'
        }
      ]
      ac:[
        {
          'step':100
          't':'2015-06-04'
        }
        {
          'step':60
          't':'2015-06-08'
        }
        {
          'step':40
          't':'2015-06-10'
        }
        {
          'step':50
          't':'2015-06-20'
        }
        {
          'step':60
          't':'2015-06-29'
        }
        {
          'step':70
          't':'2015-07-03'
        }
      ]
      bp:[
        {
          'hr':60
          'hv':100
          'lv':80
          't':'2015-06-04'
        }
        {
          'hr':65
          'hv':130
          'lv':90
          't':'2015-06-08'
        }
        {
          'hr':80
          'hv':110
          'lv':85
          't':'2015-06-10'
        }
        {
          'hr':89
          'hv':115
          'lv':89
          't':'2015-06-20'
        }
        {
          'hr':86
          'hv':113
          'lv':90
          't':'2015-06-29'
        }
        {
          'hr':88
          'hv':110
          'lv':85
          't':'2015-07-03'
        }
      ]
      ld:{
        wt:
          'v':68
          't':'2015-07-3'
        bo:
          'v':90
          't':'2015-07-03'
        bg:
          'v':6.5
          't':'2015-07-03'
        bp:
          'hr':88
          'hv':110
          'lv':85
          't':'2015-07-03'
        ac:
          'step':70
          't':'2015-07-03'
      }
      mh:{
        mt:"脑血管畸形"
        fh: [tags[0][1]._id,tags[0][2]._id,tags[0][4]._id]
        ad: [tags[1][0]._id,tags[1][3]._id,tags[1][5]._id]
        fca: [tags[2][0]._id,tags[2][4]._id,tags[2][6]._id]
        vac: [tags[3][0]._id,tags[3][1]._id,tags[3][3]._id]
        ana: [tags[4][0]._id,tags[4][2]._id,tags[4][4]._id]
      }
      mirs:[
        {
          _id:rep._id
          pat:pat.profile.name
          age:pat.profile.age
          sex:pat.profile.sex
          dev:rep.dev
          exmpt:rep.exmpt
          exmitm:rep.exmitm
          st:rep.st
        }
      ]
      omr:omrs
      ecg:[
        {
          '_id':'98'
          't': '2015-07-03'
          'e': 'a0thUWpZL3NqOU9QMzQvcGo4R1FoNUNoai9HUWtaQ0FrTENROTVEWmtNdVF0WkRYa1pLUmw1SEFrYmVSbFpEOWtaeVJ0Skc3a2ZlU21KS0VrZFdSenBIa2tjeVJwcEQ2a09xUXhKQ3JrTU9Rbm8vMmoreVAwWStzajUyTzlZNzZqNVdQZ1krZGo2R084NDdmajR1TzdJK1NqNmVQb0krb2o2dVBwNCt0ajdpUHJZK05qNStQNVkvY2o5S1BzbytMajZXUHI0K3JqNk9QcVkvSGorS1B5NCs0ajZ1UHBZK0pqNnlQazQrR2o1bVBrWSt3ajgrUGxvKzJqOWFQbG8ramo2S1BwNCt4ajZ5UDNZL09qdnFQZzQrQ2o2aVAxby9Sajl1UC9JL3NqOCtQdkkrdmo2K1AxWS81a0phUDhvL0NqNnVPOG83TGp2YVBrSSt2ajhlUHBZK2tqOWFQMlkvYmorNlJsNU9jbEtlVm5aV1ZrOXVSZzQrc2o1T1BySS9oais2UDJZL1prSjJRdkkvMWorNlA1WSs2aitLUWtaQ0ZqK21QNkpEQWtOQ1FsWS9za0xXUmpaR2RrUFNRNHBESGtQYVJycEhMa2E2UnJKR3FrUGVSNlpLcGtjV1J4cEhxa2N5UnRaRzhrUDZRNEpEeWtOK1F2NUNlai9pUHBZKzBqN0dQcnBDWWtJcVB0NCtTajY2UHFvNzZqNmlQckkvQ2orNlB0SStKajVtUHFvL3pqOTZQblkvWmo5aVAzWS9Zajh5UHc0L2drSXVQNzQvYWovYVA0by9WajdxUGxvK3RqOWVQMFkrbGo0V1B1NC9qaitpUDhJL1ZqN09Qb28rNWo5MlFnSS9SajR5UGtZL01qL0tQMFkvRWovaVB4NCtrajhHUHU0K1RqNmVQelkraGo1V1BtWStQajRhUGk0K01qNHFPLzQrUGo1aVAxcENPa002UnRKTGFrOE9VbTVUZWs5R1JxSS9MajdhUHhvL0NrSWlRaDQvRGo2cVB4WS9EajhHUDU1Q3RrSTZQN0kvQ2p2dVBpby9la0lTUXdKRDVrTWVRNVpEeGtOeVF5WkRva1k2Um9wR21rUDZSanBIOWtmK1J3NUhBa2NpUm1wSEJrYitSeHBIYmthQ1E3NURBa01pUXI1Q0lqOHlQcUkrNWo0eU96WTcwajdhUG1ZNzRqNmFQclkrUWo0K1B1WS9KajgyUHNJK2ZqN1dQcEk3SGpzbVBvSS9lajlTUGxvKzhqL1NQd1krd2o3YVBnbyt5a0lHUHU0K3VqK0dQOEkvaWo4T1BxSSt4ajZPUHRvL1pqOEdQbW83d2o2NlArby9laitlUDhZL0VqL1dRb0kvdWorcVFqNUNBajlhUHdZL1dqNWVQcW8rcGo0YVBzSS9PajYrUGdZK0tqNXVQbDQrU2o2T1B1by8xa05LUndwTGRsSUdVdzVTSmtxbVFsNCtKanZTUHJaQ0trSXlQK1kvN2oraVAyNC85a0lXUDFJKzRqK0tQOFkvZmovV1F5cEdOa1lLUTJaQ3drS0dRdDVEVGtQZVJ2Skcxa2JPUnFKRzNrYlNScHBIR2tjT1IyWkgza295U25aS01rZHlSeHBHaGthcVJrcEN6a0lTUDk1Q1prSStQMEkrSGp2eVBuWS9Uajd1UHNJK1dqdm1QZ1krcmo2T080WTdrajYrUHI0K1hqN09QdW8rYWo2eVAwSS9JajZTUG1vK2dqNzJQNDQvSmo4bVB3NCt3ajdLUHBvL0RqK0NQNFkrcmp2U081WTd2ajV1UGpJK0FqdTZPM0k3Z2o2R1BuWStiajQ2T3k0NzBqNnlQd1kvR2o1K1BoNCtlajdhUHRvK0dqNHFQdUkvSGp2YU85WStEajQ2TytZK2JqNzJQa0k3N2pzdU95WSt0ajl5UHBJK2hrSXFSbVpLbWs0bVR3cFNWay9PUnhZK3hqNHFQeUkveWtJQ1AzSStCajZLUWtZLzJqKytRbzVDY2tJaVFrNUNyai82UDFZLzRrSWlRaTVDWmtMMlExSkRUa1lXUmo1R2JrZFNSNTVHNmthbVJ3cEhLa2NXUnJaSEFrb0tTclpLVmtlbVJyWkdoa2F1Umw1REprTHlRblkvdGorQ1AyWS9GajYyUHQ0K3BqNXlQaEk3Tmo0aVB4by9HajZXTy9vN0Zqc1NQbkkrbGo0YVB1SSsyajdLUHBJK05qNWFQdlkveWovYVA2NC8vaithUHc0Ky9qNitQa1krMmo5R1ByWStFajV1UG9ZK1ZqOU9QOUkvYWo3dVB3NCtXajdDUDFJKy9qNmFQcDQrVGo0eVA4WS8xajhXUWlvL3lqL1dRaFkvMWovU1AwNC9Fajd5UGs0K3pqOEtQMTQvSGo1T1BrWSttajVhUGo0K3RqNHlQaDQrNmovNlE3cEtWazd5VXlwV1ZsTXlUaXBEQ2o2V1B1by9zaitLUDdvLzBqLzJQN1kvS2o3R1AxNC81aisyUC9aQ0lrSW1RaUpDb2tLdVA1WS9za002UTM1R0FrWmVRNzVEamtZK1J6cEhDa2FLUm81R3ZrYXVSeXBLbGtwcVIyNUc5a2NHUndKR2trWW1SalpHRWtNQ1FvSS81ajkyUHZZK3NqN1dQdjQrb2o0R08ySTY0ajUrUHdJK2JqdmFPNDQ3cGo2T1BubytLajZHUG1vN2tqNUtQeVkrM2o2YVBxWStpanYyUHJvL1VqN2VQdEkrN2o2V1Btbys4ajhxUG5JK3BqOCtQbkkrQWo2YVB0WStsajR5UHBJL0JqNnFQcm8rcmo1K1BtWS9YaitDUHRZK0tqNCtQeDQvSmo4R1A5NC8vajg2UHZJL2hqK1dQMzQvS2o0dU8ybzdaajUrUHA0K3NqNkdQam8rb2o2eVB5SS9OajlPUXRwSEhrdCtUeEpURWxPeVV3WkxVai8yUGlvK3ZqOGlQMVkrNGorT1FocENHa0p1UCs0L1pqK09QNFkvV2o5MlB5WS9qa0txUXVaQzhrS2lRM3BEb2tQV1E3WkM3a082US9aR1ZrZHVSNFpIUGtiMlIwcEhWa2NLUjBaS0drZTZSdnBHZmthQ1JqSkR2a1BHUXQ1Q1RrSUtQMDQrM2o3bVBwbytKajV5UGtJK0lqNTZQajQrRmo2eVBvWStOajVhUGpvK0ZqdjZQbzQrSWp2S08rSTc2ajRXUHZZKzlqN3FQM0kvSmo2U1BxNCt5ajlxUHo0K1BqNXlQc0krT2o1U1BwbytYajYrUHZJKzhqOGVQMVkrOGo3MlB5by9iaittUDJZKzdqN09Qdm8rZmp1V082STdxajRhUG1ZK0FqNmlQb0krZmo2YVBqWStZajlLUXlKSEprNFNVeEpXV2xhT1QrSkdVajR1TzNvK2NqOWlQMG8rL2orU1A5SS9GajkrUDdJL3VqKzJQOTQvOWovV1A4SS9Zais2UXBwQ3drSk9RaUpEaWthdVJxSkdQa1lxUmxKR1drYWlSdTVHL2tkcVI5cEgya2VxUno1SEdrZFNSdTVIUWtiQ1E5SkRpa01LUWpvL3FqOHlQdEkrK2o4V1ByWStXanZLUHFZKy9qNkdQbW8rTGo1R1BxNCtlajVpUHpJL0lqNTJQaEkrS2o2aVB2WStWajVDUHlZL0xqNnlQcDQrY2o3NlBrSTd2ajlHUDc0L01qOHFQdW8rbmo4R1BqbytMajVxUHk0L1hqdlNQanBDQmovaVA0NC9hajdTUHBZK25qNm1QdEkrVGp2YU8xbzdVajRXUGlvN2Zqc0tPMlkrQ2o0S1Btbzc4anVhUHRaQ1BrUG1SOEpMYmsrQ1U2cFN3a3JtUWlJN1NqdEdQbUkrcGo3cVFnSkNGaitLUDFJL1FqOGVQc0kvaWtMR1F0NURQa0s2UDhZL1ZqL0dRbHBEYmtObVF6SkRja1llUm5aR25rYXVSbXBHV2tiYVI0cEhZa2I2UnhaRzFrYVdSNEpIeGtaYVE0WkRla09xUXJwQ1ZrSnlRZ1kvV2o3U1B2SSttajRxUGpJK0FqNTJQbUkrUGo2R1BsNDcvanVHT3FvNjlqNHFQb28rNmo4NlBzNCtKanYyUGo0K09qNHlQaFkvRWo5V1Bxby9KajdtUHVJL0NqNGlPMUk3MWo1NlBoWStSajhTUHdvL0lqOG1QMm8vWWo4R1BxWS9IaithUDFZL1pqNnlPOTQ3R2p0R08vSStkajdhUHNJK1ZqdTJPNUk3NGo0T08vNCtFanVHUGxKQ0NrTzJSN0pMcGsrMlV3Wk81a2JtUHNZNzlqNzJQeDQvQmo3T1BsSSs3a0o2UWpJL0VqNnFQdUkvSWo3NlA3cENNa0llUXBKQzFrSkNRbkpEUmtOeVEzSkRBa0x1UTBKRGlrTjJSZzVHMGtiK1IxNUgxa2NhUnhwS0xrcFNSNjVIWWtiR1JvWkR6a01LUW9vLy9qK0NQeUkveGtJK1A3WS9CajV5UGlJN3hqdStPM283L2o3V1BpNCtyajcrUHJvKy9qOENQbjQrUGo2S1B1bytOajhPUDZZL25qOW1QMEkvdWo3MlB2SS84ajlxUG5JK3pqOFNQekkvTWorZVA3SS9VajlLUHRJK25qN21Qdm8rbWo4NlArWS92ajcyUG1ZL0RqK3lQd0kvY2tJNlAzNC9XajdDUHJJL2NqK0tQM0kvQWo2cU85STdzajVpUGw0K2JqOGFQdm8ramo4cVA1cENqa2F1UzJwTytsSUtVaFpQZGtzV1AvNCt0ajc2UHZJL2lqLytQKzQvVGo5T1A4WkNBaitHUDVJL3NrSkdRc3BDYmtMaVFycENEa0xhUXlKQy9rTmlRK0pEYmtPQ1J0NUhya2NXUm41R0xrY0NSK3BLbmtwbVI4Wkh1a2UyUi9KSDRrYmVSb0pHWWtZK1E5WkNva0p1UWxZLytrSWFQejQrSWo0Q1BzNCtlajRPUG9JK3dqNWVQaDQrYWo1S1BpNCtRajRhUHFZKzlqNTJQZ1krV2o4Q1AxSSs2ajcrUDFvKzBqNXlQblkra2o4NlA0SSs2ajVlUHM0L3FqOUNQc0krYWo2R1BvSStuajdpUGtvK0lqNnVQcUkrYmo2U1BwNCt1ajhDUDI0L0ZqNStQbm8rNWo2cVB2WS9sajgrUHZJL2JrSW1QNTQvWWorU1AzNC9HajV5UHFvL01qOHFQcFkrVmo0eVBtbytnajVxUHhvLzZqOTZQNVpDdmtaV1N3WlBDaytHVDg1U0lrdmFRNW8vYmorcVFpSkNFa0l5UC80L2NqN2VQeVpDS2tKaVFrcENJait1UDVaQ0VrS21RcDVDcWtNT1E3WkR6a1lPUmhwRG9rUFNScVpHbmtPMlJoSkdqa2I2UnM1SDBrcHlSLzVIeWtkK1JySkd1a2RXUnpwSDZrZjZSeTVEdGtKNlFySkNTajlLUDBJL0tqN2lQeG8vQWo3U1AwNC9Tajh1UDVZL0RqOHlQMjQrM2o2bVBvWS9Dai9DUHk0K1JqdCtQaVkvSmovU1A4WSs2ajYrUDJZLzFqOGFQclkrZmp2YU84NCtPajZTUDFvL1hqN3VQNjQvYWo3V1B1WStTanVpUG40L0pqNmlPOW83cmo0YVBxWStmajZXUGtJK3FqOENQMVkvSWo1S1BrNC9lai9pUDdJL3FqOCtQeEkrK2o2MlBsNCtvai9pUXBJL25qOXVQNFkvbWorK1B1SStTajRlUGxZK2pqNzJQdDQrS2o2ZVBwNCtaaisrUWk0Ly9qL1NRcVpHRmtkS1M5NVMzbGE2VjRaVGdrcEdQNEkrV2o0ZVAxWkNQai82UC9wQ2trS0NQKzQvR2ovR1B0SStwa01hUTE1Q2RrSjZRdEpDVGtJNlAvWS9Ja0pxUm5wRDNrTnVSajVHcGthS1EvcERza1pHU2hKSDNrY0dSdVpHNGtZZVE4NUd0a2NpUm5KR2ZrWUtRLzVEcmtKR1B4WS9EajdxUGlvKzJqNitPOUkrb2o3S1BrSTcwanVHTzZJN3pqNVdQbkk3L2o2T1AzSSt1anZxTzNZN0pqdk9QbTQrK2orYVA0WS9iajZxUGhvNzlqNUtQbG8rd2o1NlB1SS9Xajh1UDBZK3dqdG1QbW8vaWo2V1BrbytEanVPTzZZN1dqdVNQcEkvSmo1eVBpSSt4ajcyUDFZKzdqN1dQdTQrK2o4bVB4NC9JajlHUDVJL09qNVNPOW83OGo0U1B5WS9OajR5TzVJN2lqNHlQcFkvSGo3cVBxWSszajZhUHlwRFBrZjJUdUpTZ2xLQ1M3NURoajVtUGdZL0VqOFdQdEkvdmovQ1A3WkNUaittUHJvKzlqOVNQelkrdGo4bVFpSS90a0xHUXZKQ0prS2lRejVHQ2tQV1EwcER6a1BXUS9aR1ZrWTJSajVHY2tZS1JtcEhra2VhUjZwSExrWW1RdzVENmtkMlJ0SkRFa01hUTU1RGNrS0tQM1krWmo2R1AwbytaajZLUHZZK3pqNVNQalkrRGo0R1BrWStRajVXUHhJK3FqdmFQaFkrT2o2MlB4bysyajhpUDFZL0hqOTJQelkrZmo1MlBoNCtLajVDTy80NzRqK1NQN1krOGo3bVAyby9pajYrTzVZNytqOHlQdkkrOGo3MlB1NCsxajZhUG9JL01qNnlQcVkvQmo2dVAxSS9ZajhtUDNJLzFqN1NQclkvSWo5U1FrSS9jajhpUWhaQ1BrSlNRbEpDQ2tJdVA4NC9IajVPUHBZKzFqNjZQeW8vQWo2S1BqWStSajcrUHdZL1NrSk9RMlpIR2t1YVR6NVNnbFBDVXNKSzdrS2FQdUkrMWo3aVB6cENma0pxUDZwQ0prS3VQL0pDUmtMYVFxSkNua0o2UWhvL3FqOW1Rb1pEeWtOK1F3SkRua091Umk1R3lrWnFSc3BHOGtabVJ1NUhua2RDUjNaSFhrYytScEpIbWtvZVNnNUg1a2FHUS81R1JrWTJRODVEMGtNMlFwcENSajhHUGxvK3dqOUNQdm8rSGo0ZVBpSStuajUyTzdZKzlqOWFQcm83K2o4aVA0byt3ajZ5UHZvKzdqNjZQcEkrNmovcVFoby96ajdpUG80KzFqN3VQMFkvaGo4dVBzNCtyajZLUDFZL3dqK0tQNW8veGo5cVB2NC9DajQyTytJK3NqN2VQeDQvT2o3cU8vNDc5ajlLUHo0L2JrSmFQN0kvRGo5K1FwSkNQa0lTUDlvL3VqK1NQN1kvN2tJeVB6WStRajZ1UDBJKzlqNXFQbW8vY2o4YVB5bysyajR5UHRvL29qK2lRb1pEMmtwcVQyNVNNbE51VXZKS2NqKzZPMlk3N2o3V1BvbytvajZ5UGlJK1dqOU9QeG8rZmo0T1ByNC9CajdTUHpJL3JqNjZQaTQvWGtLaVFpWS9Nait5UXNwRE1rTFNRMVpEMWtOT1F4NURZa05TUStwR2lrWnlRN1pEb2tQcVE4cEQ5a051UXlKQytrS1dRa28va2o5T1AyWS9VajhPUGxvN3NqdWVQeFkrN2o0bVBoWTd0anZlTzQ0NjhqdmVQakk3Z2p1Q1B0NCt6ajZPUHlJL0xqN2lQb283emp0MlBvWS9WajVHTy9ZK2tqNkNQeUkrdGo0NlBqbzcyajRpUHpvKzJqNitQaW8rR2o3T1A1WS9TajZPUHVJL3VqK3VQd28rdmo3bVB3by9Iajh1UDE0L2hqL2VQLzVDRGtJbVA2NC9KajlPUHA0NzBqNFNQdEkrbGo1NlBnbzdOajRxUHRJK0pqNDJQdkkvc2tJYVAzcENza2NhU3ZwUEFsSWVVbHBPb2tjK1B6NCtNajdXUDVJLzNqOXVQMnBDQWtJbVA1by9FajhtUWdKRERrS3lRb1pDYWtKaVFxWkRia09lUXNwREZrT2VSZ3BEemtQV1JsSkc4a2RlUjRaSHVrZStSelpIVmtjV1J2cEgwa2ZhUjFKSENrZHVSeFpHNWthV1JpWkRwa0xpUDdvK3NqNlNQM28vVmo2aVBvbyt2ajgrUHQ0KzBqNUdQbFkrY2o1aVBnSStrajlPUHpvL0FqNVNQdW8rMmo0T1Bwbyt4ajZ1UDBvK29qNk9Qc1krZGo3cVB1bytnajQrUG5vL0FqN3lQdG8raWp1MlBobytVajVpUHFvK09qNEtQaEk3N2o2T1B4byt4ajhtUHZZK1NqNlNQdW8vQWo5R1BxWTc4anVpUGpZKzFqNm1QblkrOGo3aVBwNCtjajR5UGhJN3lqdWVPM28rTGo1Q1BtNCtTajc2UXhwSHdrNGFUNjVTNmxMS1M2NUNyajRtUGlvL0lqK0tQdVkrN2o4bVB3WStxajdHUHlZLzRqKytQem8vT2tJQ1FzSkNNa0ltUWw1Q0VrS2VRdXBDMmtQcVJnNURxa1BxUm81RzJrYmFSdXBIQ2tjZVJ2NUhka29LUjBKSE1rZUNSMEpIM2tmS1J6SkdKa1BDUTE1REJrS1dQNVkvU2o4ZVB1WStoanZxUHFvL0NqNmlQd28rMWo1ZVB1WS9WajdXUGpZK0xqNk9QdVkrdGo2K1BvWS9Eai8rUWdJL0VqN2lQMEkvc2ovV1B3SStKajQ2UHY0L0hqN09Qd28rL2o4YVB4SStpajRHUHFvL01qOGFQdVkrcWo2S1BuSSsyajZPUGg0K3ZqOW1QM0krN2o5bVA5NC9yai9xUC9ZL1RqNnFQcW8reWo3YVBuWTcwajRxUGpZK3FqNzJQcTQrSGp1eVBvbys3ajVhTzQ0K1FrSVdSaEpLaGs3YVVuNVR2bGFHVHZKQ3BqdXlQa28vTGovT1A2WSt6ajVHUHJJL0FqNzJQMm8vWGo2dVA3WkNaaitPUCs1Q3BqK3FQMVpDdmtMR1FrSkM5a015UmhKR2JrUGVRNEpHRWthR1J1cEcza2FHUnRaSE9rY2FSdHBHN2tjcVJ6Wkdwa1B1UmlwRHlrTWFRNXBETGovK1B3NCszajc2UHZZK0tqdVdPOFkrK2oraVB6WSs0ajZDTzhvK0hqOFdQM28rdGo2cVBxNCtnajRxUHZJL3JqL2VQMjQrNmo3aVB4WS9DaitXUDRvK3NqNCtQdG8rMGo2Q1AzSS9pajdhUGxvK2RqOFdQMlkvQWo3K1BxNCtkajdhUDJvL1lqOUtQdW8rY2o2aVBsbys2ajlpUHc0L0hqL1NRZ1kvZ2orbVA0SS90aisrUDBZL2lqK09QelkvSWo4dVBxWStxaitDUDZvL09qNTZQbVkvYmo5cVAxSkNaa05HU2paU1lsWTJWd3BYWWxJYVJ1SS9pajZTUDA1Q0lrSitQLzQvc2orYVA2WS9wajlLUW5KQ2VrS0tRaFkveWovNlFzWkRBa0srUXNwQ01rSmFRMDVEZmtQbVJpcEdGa1lLUm01R2drYWVTaFpLSWtkeVI5Wkhla1l5Umk1SEprZCtSejVHQWtLZVF3SkM1a0t5UXA1Q0FqKzZQeUkrWWo1eVBtby9laitPUG40NzZqdE9PODQ3eWp2K1BxNCtSanVXTytZKzBqN09PL28rQ2o2YVBybyttajdDUHBJK09qNXlQdW8rVWp2U1BnNCtrajVXUHA0K3JqdldQalkvR2o1Mk8yNDdZajZhUDBvKzVqNWFQa0krWGo1cU8vWTdwajd5UHVZK09qNWlQclkvRWo5S1FqWkNKajlpUHVZNzJqc2VQbTQvRmo3aVB1WSthanM2TzQ0K2VqNk9QcUkvU2o3Q084NDdqajhLUXFKR0drZktTMXBQUmxOdVV6cEsvai9xUG1ZL0pqOStQOVkvTWo3K1AwNC9MaisyUDhvL3VrSWVQL1pDQWoveVA2SS8wa0lDUW1wQy9rTWlRMFpER2tONlF1WkRqa2JTUnM1SGZrZktSejVISGtjeVJxSkc1a2VhUi9KSGhrYjJSeDVIU2tjU1JrNURoa00rUTJwQzdrSktRa3BDTWo5Q1Bzbys3ajdDTzk0N2lqNFdQMG8vbmo3YVBxbyt5ajdDUG9vK2ZqNUdQejQvb2orR1A4by8xajd5UHFvK1VqN0tQeUkvRGo2YVBvbysyajlTUHlZKzFqOHlQem8vVWo4aVBrSTcvajZDUHZZL0pqN21QajQramo3cVBrNDdjajRpUDFJL0JqNnFQbTQrMWo1K084WSttajd5UHFvL2RqOE9QdEkvbWorK1A5by9yajlhUHk0K3NqNTZQblkrUmo0NlBtWSs5ajhlUHBJK3FqNU9POFkrYmoraVF4Skhia3ZXVWpwV25sYjZVZ3BHMWo3bVBxNC9pa0xtUXZKQ1lrSTJRalkvM2ovU1FpNC85a0tDUTZaRE1rTGVRdnBERmtLT1FzSkRha05hUXc1RHprWldRNlpHdGtkZVJ2cEhOa2NlUjNwS3VrcDJSNkpLaGtwYVI4cEtva3JXU2xwSDNrYjZSazVEL2tQS1F3NURHa01XUXZaQ2dqOUtQMEkvUGo2ZU84WTc3ajUrUHlJKy9qNTJPLzQrSmo2MlBrSStQajhPUHU0K3hqOUNQNkkvbWo5aVAySS9UajVhUG5JK2tqN1dQdkkvQ2o4dVB5NC9sajg2UHJJL1BqKzZQNlkvcGo5Q1B0WS9NajgrUHVvK2RqNXVQLzQvd2o5bVA1by9BajhxUDNvL1RqOEtQdjQramo0Q1BrNC9TaitXUC9ZLzBqOTZQMVkvS2o1K1B6NUNia0lXUDlZL25qOFNQZ0krNmtKT1A2SSs1ajVHTzlvK05qNlNQcVkrRmp0U094bzdnanRlUGlZL3lrTGlRL3BIWGt0R1QycFM4bE5lVHE1RFpqdm1POEkrTWorR1A5SS9hajlpUDBZL1lrSVdRam8veWtJcVFtby96ais2UWtKQy9rUFdRNkpDNWtLNlF3NUNua0ppUTdKRzVrYldScXBHaGtaMlJ1cEhka2NHUnpKSGVrY21ScHBIT2tkR1JvSkQxa095UTZwRFFrS21RazVDQWovZVAzWS9LajVlUGg0N1lqcitPMjQ2aGpyV08zSStCajVpUGpJK2JqNktPK1k3dmo3Q1B4NC9jais2UHRvK3NqN2lQcTQrb2o4bVA0by80ai82UDFvL2NqN2lQcEkvQ2o4dVBzSStOajVtUDRvL1NqditQaTQvVWo3cVA0by9wajcrUHFJNzNqdm1QZzQ3L2p2Mk8zbzdianQ2T3pJN01qNE9QelkvVWo5K1A3SS9raittUHpvK0FqN2FQOW8vUWo2T1BrbysxajdXUHBJK1FqNHFQdVkvTmo2NlBwWkNGa1ltU3BwUFBsTCtVNkpTMGt1V1EyWS9Uajd5UHNvL21rSlNRZ0pDTGtLeVFwWkNYa0lxUXBwQ2RrSStRc1pDMGtOV1EzcEM3a05PUTY1R0trWVNRK3BEMGtZNlJuWkdoa2JpUno1SFFrY09Sa3BHdWtjbVJ2Skd2a2JPUnI1SEZrYmFRK0pEQmtKMlFoWkNIa0lxUDRJK3pqN09Qc28rYWp2aU8xbzY0anRHT3ZJN1RqdmFPeUk3bGo1dVBrWTc2anVhTzA0N0pqcmFPNUk3YWp1YVBwbytianZxTzNvN21qdktPOW83dWp2ZU83WTdrajRPTzlZN2lqNEdQa1k3L2p0Mk96STdCanN5T3RJNjRqdCtPN28rRWp2bU82NCtEajRPTzhJNzRqdnFPOUkrUmp2ZU8zSStkaitxUDNJK2RqNkdQZzQ3VGpzbU83bytLajUrUHZZL2RqN0tQb1kvYmovQ1B5byt5ajZhUGxJKzRqNmVQbkkrVGo0S1B2SS9vajc2UGpZNzZqNkNQd1krL2o2T1BtWS9Pa0tDUno1TGhrOG1VeEpTems0S1E3SS9JajhTUDdKQ1RrTFNRcDQvL2oreVFoNUM5a01HUXpaRFZrTGlRbVpDcWtPcVJqcEQra09lUTZaR1BrZFdSelpHaWtaNlJzNUhIa2NPUnlaS21rdU9TMlpLZGtwT1NwNUsza3BtU2hKS01rZitSOVpIeGtkNlJ3WkhHa2F5UTc1RENrSUtQNTVDTWtNZVF3by9xajlXUDM0L3NrSW1RZzQrM2o1dVA2WkNTai9XUDg0LzlqL3lQOHBDRWovbVA1by9uait1UDlZL3NqK0NQNEkvU2o2aVBzWS9MajhXUHBJK1ZqNmlQMTQvRWo1R1BnNC9IaithUHhJK2tqN3VQNDQvVmo3YVByNC9OajlDUHRJK0xqdE9PKzQvSGo3MlByWStnajZLUGpvK2pqOTZQMEkrTWo1aVAxWS9QajZLUG5JKytqNVNPNjQ3aGp2cU8vNCtDanZ5TzM0NjdqdFNPNVk3b2o1R1AxcEdCa3NXVDVwVFFsUE9UN3BITmorV1BxSSs2a0kyUWtvL2lqL0dRaUkvdWo5S1AzWS9tajkrUDU0L3RqL0tQK1kvVGo3NlAxSkNRa01HUXNwQ2FrSXlRd1pESGtPbVJsSkdCa09tUS9KRCtrWk9ScVpHZ2thdVJxNUdQa1lxUnQ1RzFrWU9RL0pEYmtMQ1FwNUNva0llUDRJK3hqNWVPOEk3Z2p2dU81NDcvanYyUGpvK01qdnVPOFk3dWp2V081bzdsanZLT3lvN0RqNFdPNm8rb2o5MlAwNC9CajZxUGxJNzNqdmlQaG8rUmp2aVBnbytkajZxUHBvK3RqNGFPK28rb2o3bVBtSTdjanVtTzRvN2pqNGlQbDQ3Nmo0T1B2byswajgyUDlZL3lqOWFQekpDSmtKNlFrSkNya01XUXZKQ3prSXFQK0pDT2tKT1FpWkNJaisrUDhZL1pqOW1RbUpDcmtKaVAwSSsrajhLUHZvLzhrSUtRa1pEb2tjU1M2NVNKbE95VXpKTDJrUE9Qd1krY2o0eVBzWkNEajlhUHFvL0tqOU9QdW8vQmorQ1A0NC9wajlpUHlJL1BqOW1QN0kvbWorMlFvNUM2ai9TUW1KREtrWXVSZ1pENGtQT1JocEc4a2I2Unc1RzdrY1NScUpHVGtZbVJuNUdXa1lLUmg1RHRrTUdRaUkvOWorU1B4bytranRDT3JZN2VqdTZQazQrRGp1dU82NDdpanVXTzVZNnZqZnlPd1k3OGp2U081WTdzajZTUHQ0L09qK21QMVkrOWo3YVB1SS9JaitLUHc0L05qK2lQMW8raGo0MlBobytCanZhUGhvNzdqdnlQbUkrQ2p0Mk8ySStVajYrUDJKQ0ZqOXFQcG8rNmo3T1BvSSsyajZTUGpJK2FqNE9QdjVDQWovU1FoNUNva0oyUW9wQ0ZqKzZRaEpDY2tJK1A3WkNLa0t1UW1vL09qNDJQdlkvWmorS1FsNC8rajhLUDVvL3pqL3FRblpEZWtiYVM1WlNMbFBHVm81V3JrK1dSazQvaGo4dVA3SkM0a05TUXVKQ3hrS0tRb1pDbmtLdVEwNUNraitDUWw1RExrSytRcFpDZmtJS1FzSkRoa1lHUTdKRGFrT21SZ3BENmtZeVJ0NUhaa2VlU2pKS1ZrcHFTbFpIOGtlbVJzcEd4a2NhUnM1R09rT0tRMUpEb2tOR1Fuby8rai95UWdKQ0NqK2VQdEkvRWo4T1B4WS9Kajc2UHlJK21qdjJPMVk3TGp2NlBqNDczajdDUDNZL05qN0dQeFkrWmo1K1B0WSt5ajk2UDNZL2NqOUdQckkrbWo3dVBzSS9GaitpUHc0KzRqNldQcDQvQmo3aVBzSStuajZPUHFvL0ZqOCtQcjQvS2orV1B0bytLajdPUHU0K0pqN0dRZ28vUmo2dVBxby9Gai9lUDhZL0lqNXlQbUkvVmorbVA4NC9ZajhLUDJJLzZrSldQL0kvdWorK1A2NC9XaitxUC9ZK3RqNmVQMVkvUGo5dVAwbys1ajdPUHdvL1JqK0dQcUkrTmo4R1F0NUd6a3FlVDJwV0FsZXlWMFpQR2tPT1BwSStka0p5UTFwQ2xrSU9QOFpDQmtKMlFvcENFa0pDUXNwQ3hrSldRaTVDQWtKaVE1cER1a09LUXg1Qy9rT0NSaVpHTWthMlJ1Wkcwa2JHUjFwSGJrYkdSK1pLNWtwV1NoNUhza2NXUjRaSHZrZkNTbTVLQ2tjcVJnNURLa0t1UC80LzFqK1NQem8rdGo1Q1BxSSthajdpUHdZK2RqOHFQN0kvRGp2eVBwby8wai9DUHdvL1VqOHlQdjQrbmp1ZU81NCt4ajcrUHRvK1VqNldQem8vRWo3Q1B2SS9qajg2UHA0L0VqK09QNDQvVWo3cVB3bytnanZlUG1vKzJqOHlQdDQrUWp2K08rNDdwanVTTzVJN2RqdHlPN1k3MGo2bVBnWTdIanRTUG1ZK1VqNENPOFk3M2o1NlBuWStxajVtUGlZK3FqOENQdjQraWo1U1BqbythajlTUHY0K1FqdnlQdW8vRmo1R090NDdyanY2Ty9vN3pqdEtPeTQ3WWp2R084NCsyai8yUXM1SGtrNUtUKzVUcGxNU1N5NUNWanR5T3BZNi9qN2lQL28vSmo0YU8rNDcyajRhUHpvKzRqNmFQelkvK2o5dVB3WS8yai9xUWxaQzlrSkNQN3BDTGtKU1FuNURUa05tUTJwRHdrWXFSa1pHVGtaK1JySkhLa2ZhUi81SFNrYitSeDVHaGtZNlJnSkRQa0wrUXZwQ2RqL0NQMVpDaGtMZVAvSSsxajZPUHdvL2pqK0tQcjQrc2o1bVBsSStJajhhUDdZK3BqNHVQa0krY2o1dVBySS9EajhlUHVZKy9qN3VQdzQvR2o5cVFnby92ajhpUHdZKzdqNmlQdkkvRGo2ZVBuSSs0ajltUDhJL3dqKytQeUkrcWo2R1BqWStYajZpUHZZL1ZqNDZQalkvWGo5K1AwWS9Iai9PUWxwQ2JqL0dQN0pDS2ovK1A5WkNMa0lXUWpJL1dqNUNQckkvaWo2bVBuWSs0ajhxUHlZL0ZqNitQcW8rNmo2cVBnWStXajllUWxKR3ZrdE9UM0pUd2xhQ1VqWkhza0lLUDBZLzJrSjZRakkvOWo4K1A2WS8vai9pUDA0L3BrTGVRczVDWWtKS1FtWkNla0tTUTFKRGRrUFdSazVHU2tQK1E5SkRsa1pPUmw1R0ZrYStSeUpIcmtmT1J4NUhDa2VPUjhaSGVrY2FSckpHUGtZR1JoWkR4a0oyUWtKQ1FqK0tQdEkrOWo4MlB2NCs2ajdPUGdJN2pqdmVPNkk3Nmo0eVByWSs0ajUyUGtvK2FqNTJQakkrS2o1cVBqbytqajZTUHFJKzhqOG1QczQvT2orQ1Axby9YajlLUHBvL0tqL09QOVkvdWo2V08yNCtRajlPUHQ0K0lqdmVQaFk3emp2R1BqWStYajRhUGlJNzRqdGVPMW83aGp1ZU95bzdUanZlTzBvN1JqdkdQaTQrTWp1K084bzdaanMrTzBJN2ZqdHlPMFk3cWo0bVBuSSsxajlXUDlJL3dqOVNQdG8rL2o4MlAxNC9na0lPUWtvLzBqOEtQem8rL2o4T1Azby9sajlTUHVZK0xqNEtQK0pDYWordVArNUM1a1pPU2pKT0RrL3VWbFpYZmxKR1J0SS9FajQ2UG40L0ZqOFdQMFkvVGo5K1AxNCtmajZDUDA0L0FqOTJRckpDZWtKaVFtWkNUa0tDUXQ1RCtrWXlRNDVEbGtQV1EvSkdRa2JXUnNaR3ZrY1NSNFpIZmtlYVNpNUtPa3BPU21aS1Brb09SM0pIQWthaVE4WkRxa05hUXpwRFVrS0dQODQvY2o4eVAxSStqajZpUDRZL2dqNitQbUkrZGo3R1B3NCt1ajVHUG9ZL0xqOXVQNlkrOGo3R1B4WS9BajZ1UHVvKzJqN1NQMjQvemo4NlBuNC9pajlDUHdJL0pqNzZQelkvRGo3bVB1bysrajdDUHA0K09qNGFQcVkvT2o4cVBvSS9ma0lpUDFZL0NqOHlQeDQrd2o2U1Bubys2ajhDUDI0L25qNzZQdm8vTGo2Q1BvWSt4ajhLUDQ0L2xqNzZQdjQvTmo5K1AwNC9oajllUHZJL2RqK0dQMFkvZGo4ZVAySS95ajhtUHlJLzVqL3FQeVkremo4YVB1by94ajlxUHBZKzBqNzZQakkrVGo2V1Bzby90ais2UDlaRGhrb1NUdFpTL2xhYVZ3NVRIa3BLUXFZL3RqLzJRdVpDdmtJR1A0WS9laitXUHo0L2pqL3VRa1pDcmtMcVFvWkNva01hUXRaQ21rTEdRM3BEcmtPR1E2NUdCa1lXUmdwRzlrZG1SeUpHNGtjQ1IxcEh4a2ZHUjlaS09rZWFSeVpIV2tjV1J6WkhYa2NTUm5KRHRrTUNQKzQvV2ordVAxWSs2ajZDUGtZK0hqNGVPOW8rU2o3bVAySS9WajY2UGxJK2JqNDZQazQraGp2dU84byt0ajhhUHQ0K2VqNCtQcUkvT2o2bVBybyt6ajZDUGpJK2ZqN3lQdTQraGo1V1BrbytkajQyUGtvK3FqOGFQcFk3dmp1V1BoWStsajdhUG5vK1dqNWFPKzQ3L2p1dVBrSS9Bajh5UHdvK3ZqNTZPK283d2o0YVBpWStXajhHUDBZK3pqNHlPN0krRWo1V1BtWStwajdDUHpJKzZqNnVQdm8vYmtLS1FtSS95ajkrUDdvL2RqNjZQMDQvV2o4YVB4bys4ajgrUG80K29qN1NQcFkvSGorU1B1SStkajhlUWpaRDhrZEtTeEpQZmxNV1U3WlNKa2ZhUWlZKzJqOWFRbFpDUWorT1A4cENpai9DUHY0L2xrS2FRcEpDdGtKQ1FncENZa0tpUXo1Q21rS09ReUpEamtQV1JoNUdPa1pHUmtKR0xrYUtSdEpIWmtkV1IzcEh0a2V1UjlwSHhrb2FTbnBLemtveVIySkd3a2JhUnBaRGtrSjJRbW8vaWo4U1A5SkNEa0lhUDI0K3pqNVdQZ28rUGo2R1B1WSt4ajdpUGtZK0hqNitQeDQvY2o4dVBwbytUajVXUHdvLzNqOHlQblkrbGo4K1B3WS9JaitpUDBJKzZqNitQdTQvQWo3eVB5SS9TaitHUWlJL3RqN3VQcUkrdWo3dVB3bytvajZ5UHJJK3pqN21QdEkreGo1eVB3WS9uait5UDNJL2JqK2FQdEkrcGo4U1B6SS9JajhPUDBJKzVqNWVQb1krSWo2R1Ayby9BajlXUDJwQ1VqL0tQdUkrK2o3NlB5WSt1ajQrUHBZL0tqNzJQdm8vbWorbVAxWS9oai9DUDVZL3BqK2VQNm8vOGtKV1FuSS90ajh5UHQ0L2JqL0NQK0kvcmo5Q1AwNC92aitLUHpJL1hqK3VQNjQvSGo3YVB5NC9sai82UW5aREhrYXlTdXBPamxNK1Z6WldzazZpUTBJK21qOG1RcjVERGtJK1A2cENGa0pLUXNwREZqL09QMzVDTGtKNlFxby84aisyUDU0LzdrTGFRMkpENGtZZVJoSkdEa1AyUStwR2JrYVNRKzVEM2thYVI3Wkhna2NTUnlaSGtrZmVSOFpIWmtiZVJ0WkhJa1pTUXpwQytrUDZRODVDVWorQ1A2NC9OajRhTzVvNy9qNW1QajQ3Wmp1V084WTdQanFhT3A0NjNqdXlPNTQ3cGpyK09zbzdmanR5TzlZK1RqdldPNEk3Ymp1K08rSTduanVhUGo0K2JqNEtPNlkrRGo1K1BsbytLajVLUHVZL1lqOGVQckkrc2o1ZVBvWSsrajhTUDJZL2tqOWFQeW8vQ2o4ZVAzWS9YajgyUDJJL2lqOEdQMlkvdWo4MlB2NC9VaitXUDhKQ0FqL3FQMUkvamordVAzcENUa0pxUDVvL0xqNW1QbTQrdmo0MlBoSSs4ajlDUDNZKzlqOHVQeG8rL2oreVA1by9yajYyUGo0K2pqN3FQckkrTWp2V083bytaajdTUGlJN0hqc09POW8rQmo2U1Bzby9Ka0lpUXo1RzZrc0tUNjVUaWxhNlV1cEtka0krUHBZL0FqL2lQL0kvV2o5S1A4cERMa05lUXdaQ3prSVdRbDVDNWtNaVFtWkNka0xxUTVwRDhrTzJRK3BHR2tZU1JnNUQ4a1lhUnVKSGJrZHVSMXBIRmtlR1I2Skgza3BlU3A1S0drZVdSOHBIOGtkZVJ4Skdva1BPUTRwRE9rTW1RdkpDTmo4NlAzSStvajZHUHZZK2tqN0tQaTQ3ZWo2T1A2WS9MajQyUG5JKzhqN3FQcDQrc2o2ZVBsNCtmajZLUG1vK3FqNjZQbm8rY2o3R1B2WS9HajdpUHJvK3VqNGFQa1krdGo3ZVB5WS9GajllUHdZKzVqOUtQMTQrOWo2S1Bxby9Jai9tUCtvL0RqNitQbzQra2o4V1Azby9XajllUDdJL25qOHVQdkkvUWo5cVAyWStGanZXUGlZKzJqN0dQa1krUmo1dVBuNCtmanYyTzZJK0FqdktPelk3UWp2YVBpWSthajdxUG80N21qdHFQbG8rZGp1YU85SStLajVTUHI1Q0FrSk9QL0kvbGo4eVAxby91ai9PUHU0K3lqNnlQcG8rN2o0cVB0SS9MajdLUHc0L1FqNytQd1kvYWtLeVJ4SkxIaytPVTZwWE5sYW1UcXBEZWo4aVA0WkNQa0ppUWtZLzVrSkNQLzQvR2o4V1ArcEN6a0xlUWlaQ0drTE9Rc0pDQWovcVFvSkRBa0w2UTFaR2FrWmlSbjVHYmtQR1JtSkhFa2NxUnpwSFBrZGFSMHBIMWtmMlI1NUh5a2QrUnlaSGFrYytSdXBHWmtOK1F6WkRCa0wyUXFJL3NqOVNQdVkvUmo4U1BvSSs1ajgrUHVZK1FqNW1QazQrc2o2R1B1by9TajgrUHlZK2tqNFNQd0kvYWorYVA4by9UajllUDM0L2RqODZQelkvS2orQ1Azby9jajdXUHpKQ0FrSU9QNG8vaGo3bVAxSS81ajl5UDhZLy9qK3VQMTQvRmo3dVAyNC8vajlPUG9JL0RqL3lQNlkvcWorZVB5SS9Za0lDUHZZK1BqNDZQZzQrbWoraVA0by9SajZlTzRvN3BqNldQbDQ3WWo1R1BuNCtNanZPUGpZK3NqNG1QaTQrYWo1aVBtSStzajdtUHQ0KzFqOVdQNjQvbmo5MlA0SS90ai8yUDc0L2ZqOXVQcFkrZmo2K1B5SS9QaisrUDU0KzdqN2VQMkkvOGtJQ1F0NUdwa3FPVG5wU3psYlNWdVpQbmtZdVB1bytvajhLUDhwQ29rTFdQOFkvaWtKR1FnNUNIa0ppUCs1Q1FrS3FRcjVDMmtNdVF1WkRla1lxUThKRHJrT1dROHBHU2taaVJsWkcza2MyUjU1SGVrZWVSNkpIeWtlZVJ5Wkcza2I2UndwRzJrYnlSeFpHc2tQNlF5WkN1a0l5UCtJL2RqNVNQb0kvQmo2dVBpWTc4anUrTytvK2ZqNWVQZzQrQWo0NlB2NC9HajVpUG5ZL0VqOGlQdkkrbWo2NlBzbys4ajhlUHc0KzVqOCtQejQrbmo0dU84bzcwajVXUG5vNzRqNTJQdUkrY2o0U08vWStIanY2UGlZK1pqNnVQZ0k3aWp1bVBqWSttajVPTy9ZK0tqNFNQcDQrd2o0aVBqSStUajZtUHJJKzlqOHlQMkkvaGorQ1A4SS9SajdpUHY1Q0ZrTGVRczVDTmorV1A1WS8zajl1UHE0L0xqNjJQcW8vcGovQ1Awby9JajdxUHM0L0xqOUNQdDQvY2ovMlA5NC94aitLUDFvL01qOWVQd1krdmo3cVBzNCtWajRlUHJJK2ZqNFdQbFkrTGo1K1BuNCtCajVTUHk0L2RrTHFSejVMRGsrcVU0cFRtazdxUmdvKzVqNEdQa1krM2o5R1B3NC9NaithUDA0L29qKzZQcTQrNGovQ1AwNC9NajlpUDY1Q0prSUtQNm8vcWoveVFtWkMya0orUWtaRGhrWmlSbFpHRGtQZVE0WkRva1o2UnFwR2hrYWVSbXBHWmtacVJpWkdia1BXUTdaQzFrSXlRcFpDQ2o3aVB0WSs5ajZlUHBvK2pqNmFQbzQrWmo2aVB6WS9tajltUDVJL01qODJQOUkvdmo5ZVA3WkNPai9HUHo0LytrSkdRaUpDYmtKZVFrWS8vai82UXFaQzRrTVNReUpDWGtJV1FuWkNLai9PUDc1Q2JrS2VQNkkveGtKR1A3WS9vajhLUHBZK3ZqOCtQam8rRGo2V1B0byt1ajVxUHI0KzJqN1dQa0k3NWo2T1B2SStwajVHTzg0K2FqOHVQdDQrZ2o2YVBrbytuajhTUG1ZK3FqK2lQMW8vSWorZVFnNUNJai91UDBvL0hqL0dRZ0pDU2ovcVFsWkN5a0pDUWdaQ1JrSnlQMDQvSmtKYVFqSS9tajhLUHVZL3JqK3VQOVkvZGo5cVFpWkM0a1BxUng1TFRrLytVNFpXZ2xZV1RnSkRoa0tlUXNwQ3ZrSnFRbTVDNGtLcVFqWkNxa01DUWo0L2xqK2FRbzVEU2tMdVF1cERna09DUXlwREdrTmVROXBEL2tQU1EzSkRKa01tUStwR1hrWkdScUpHR2tOMlJyWkh6a2NlUnU1SEZrYStRL1pEZ2tadVJ1WkdSa0w2UW5aQzBrS2FQNm8vZ2oveVA3WS9najhXUHBvK2FqNjZQeEkvZGo4aVB6by9FajZpUGw0K0tqN3FQM28rbmo2YVB3byt2ajhlUDRZL0FqOENQeFkrdWo0cVBoWStxajZ5TytvN1NqdXVQa28rQ2o1V1BsWStMajRpUGpvK2RqNXVQazQrR2p2Nk8ybzdUanZDUHA0K1lqdWFPMW83eGo2T1B5by9UajdXUHJJK2NqNDJQbm8raGo2T1B0by9CajZtUG1JK1FqNEtQaDQrT2o0MlBqNCtWajQyUGtZNy9qdnVQcW8rNGo3YVBySSs1ajlDUHI0KzdqN2FQaFkrc2o3U1BySSs1ajRlUGhZK2lqN1NQalkrVmo5R1AxSSsvajVDUHZvL05qOEtRaHBEbGthNlNzWlBZbFBDVm9wV2drK0tSaTQvQ2o4R1AvWkN0a0orUWhaQ1drTUNRdnBDeWtKV1FxSkRCa05lUTVaQ3prTEtRMVpEWWtObVE4cEdHa1A2Um1aSERrYzJSMXBIWmtjcVJ4SkhQa2VlUjZwS09rcStTbHBLM2t0R1NuWktXa29PUjhKS0hrb1dSMUpHVGtOMlExSkR1a051UXQ1Q2FqK1dQd0kvTGo4cVAwby9Uajh1UHg0KzlqN2FQbDQrWGo4MlFnSkNBa0lTUDZZKzhqN3VQNW8vY2orYVA1by9Wai9hUWhwQ1NrSmFQMFkrcg=='
        }
        {
          '_id':'99'
          't': '2015-07-05'
          'e': 'a0thUWpZL3NqOU9QMzQvcGo4R1FoNUNoai9HUWtaQ0FrTENROTVEWmtNdVF0WkRYa1pLUmw1SEFrYmVSbFpEOWtaeVJ0Skc3a2ZlU21KS0VrZFdSenBIa2tjeVJwcEQ2a09xUXhKQ3JrTU9Rbm8vMmoreVAwWStzajUyTzlZNzZqNVdQZ1krZGo2R084NDdmajR1TzdJK1NqNmVQb0krb2o2dVBwNCt0ajdpUHJZK05qNStQNVkvY2o5S1BzbytMajZXUHI0K3JqNk9QcVkvSGorS1B5NCs0ajZ1UHBZK0pqNnlQazQrR2o1bVBrWSt3ajgrUGxvKzJqOWFQbG8ramo2S1BwNCt4ajZ5UDNZL09qdnFQZzQrQ2o2aVAxby9Sajl1UC9JL3NqOCtQdkkrdmo2K1AxWS81a0phUDhvL0NqNnVPOG83TGp2YVBrSSt2ajhlUHBZK2tqOWFQMlkvYmorNlJsNU9jbEtlVm5aV1ZrOXVSZzQrc2o1T1BySS9oais2UDJZL1prSjJRdkkvMWorNlA1WSs2aitLUWtaQ0ZqK21QNkpEQWtOQ1FsWS9za0xXUmpaR2RrUFNRNHBESGtQYVJycEhMa2E2UnJKR3FrUGVSNlpLcGtjV1J4cEhxa2N5UnRaRzhrUDZRNEpEeWtOK1F2NUNlai9pUHBZKzBqN0dQcnBDWWtJcVB0NCtTajY2UHFvNzZqNmlQckkvQ2orNlB0SStKajVtUHFvL3pqOTZQblkvWmo5aVAzWS9Zajh5UHc0L2drSXVQNzQvYWovYVA0by9WajdxUGxvK3RqOWVQMFkrbGo0V1B1NC9qaitpUDhJL1ZqN09Qb28rNWo5MlFnSS9SajR5UGtZL01qL0tQMFkvRWovaVB4NCtrajhHUHU0K1RqNmVQelkraGo1V1BtWStQajRhUGk0K01qNHFPLzQrUGo1aVAxcENPa002UnRKTGFrOE9VbTVUZWs5R1JxSS9MajdhUHhvL0NrSWlRaDQvRGo2cVB4WS9EajhHUDU1Q3RrSTZQN0kvQ2p2dVBpby9la0lTUXdKRDVrTWVRNVpEeGtOeVF5WkRva1k2Um9wR21rUDZSanBIOWtmK1J3NUhBa2NpUm1wSEJrYitSeHBIYmthQ1E3NURBa01pUXI1Q0lqOHlQcUkrNWo0eU96WTcwajdhUG1ZNzRqNmFQclkrUWo0K1B1WS9KajgyUHNJK2ZqN1dQcEk3SGpzbVBvSS9lajlTUGxvKzhqL1NQd1krd2o3YVBnbyt5a0lHUHU0K3VqK0dQOEkvaWo4T1BxSSt4ajZPUHRvL1pqOEdQbW83d2o2NlArby9laitlUDhZL0VqL1dRb0kvdWorcVFqNUNBajlhUHdZL1dqNWVQcW8rcGo0YVBzSS9PajYrUGdZK0tqNXVQbDQrU2o2T1B1by8xa05LUndwTGRsSUdVdzVTSmtxbVFsNCtKanZTUHJaQ0trSXlQK1kvN2oraVAyNC85a0lXUDFJKzRqK0tQOFkvZmovV1F5cEdOa1lLUTJaQ3drS0dRdDVEVGtQZVJ2Skcxa2JPUnFKRzNrYlNScHBIR2tjT1IyWkgza295U25aS01rZHlSeHBHaGthcVJrcEN6a0lTUDk1Q1prSStQMEkrSGp2eVBuWS9Uajd1UHNJK1dqdm1QZ1krcmo2T080WTdrajYrUHI0K1hqN09QdW8rYWo2eVAwSS9JajZTUG1vK2dqNzJQNDQvSmo4bVB3NCt3ajdLUHBvL0RqK0NQNFkrcmp2U081WTd2ajV1UGpJK0FqdTZPM0k3Z2o2R1BuWStiajQ2T3k0NzBqNnlQd1kvR2o1K1BoNCtlajdhUHRvK0dqNHFQdUkvSGp2YU85WStEajQ2TytZK2JqNzJQa0k3N2pzdU95WSt0ajl5UHBJK2hrSXFSbVpLbWs0bVR3cFNWay9PUnhZK3hqNHFQeUkveWtJQ1AzSStCajZLUWtZLzJqKytRbzVDY2tJaVFrNUNyai82UDFZLzRrSWlRaTVDWmtMMlExSkRUa1lXUmo1R2JrZFNSNTVHNmthbVJ3cEhLa2NXUnJaSEFrb0tTclpLVmtlbVJyWkdoa2F1Umw1REprTHlRblkvdGorQ1AyWS9GajYyUHQ0K3BqNXlQaEk3Tmo0aVB4by9HajZXTy9vN0Zqc1NQbkkrbGo0YVB1SSsyajdLUHBJK05qNWFQdlkveWovYVA2NC8vaithUHc0Ky9qNitQa1krMmo5R1ByWStFajV1UG9ZK1ZqOU9QOUkvYWo3dVB3NCtXajdDUDFJKy9qNmFQcDQrVGo0eVA4WS8xajhXUWlvL3lqL1dRaFkvMWovU1AwNC9Fajd5UGs0K3pqOEtQMTQvSGo1T1BrWSttajVhUGo0K3RqNHlQaDQrNmovNlE3cEtWazd5VXlwV1ZsTXlUaXBEQ2o2V1B1by9zaitLUDdvLzBqLzJQN1kvS2o3R1AxNC81aisyUC9aQ0lrSW1RaUpDb2tLdVA1WS9za002UTM1R0FrWmVRNzVEamtZK1J6cEhDa2FLUm81R3ZrYXVSeXBLbGtwcVIyNUc5a2NHUndKR2trWW1SalpHRWtNQ1FvSS81ajkyUHZZK3NqN1dQdjQrb2o0R08ySTY0ajUrUHdJK2JqdmFPNDQ3cGo2T1BubytLajZHUG1vN2tqNUtQeVkrM2o2YVBxWStpanYyUHJvL1VqN2VQdEkrN2o2V1Btbys4ajhxUG5JK3BqOCtQbkkrQWo2YVB0WStsajR5UHBJL0JqNnFQcm8rcmo1K1BtWS9YaitDUHRZK0tqNCtQeDQvSmo4R1A5NC8vajg2UHZJL2hqK1dQMzQvS2o0dU8ybzdaajUrUHA0K3NqNkdQam8rb2o2eVB5SS9OajlPUXRwSEhrdCtUeEpURWxPeVV3WkxVai8yUGlvK3ZqOGlQMVkrNGorT1FocENHa0p1UCs0L1pqK09QNFkvV2o5MlB5WS9qa0txUXVaQzhrS2lRM3BEb2tQV1E3WkM3a082US9aR1ZrZHVSNFpIUGtiMlIwcEhWa2NLUjBaS0drZTZSdnBHZmthQ1JqSkR2a1BHUXQ1Q1RrSUtQMDQrM2o3bVBwbytKajV5UGtJK0lqNTZQajQrRmo2eVBvWStOajVhUGpvK0ZqdjZQbzQrSWp2S08rSTc2ajRXUHZZKzlqN3FQM0kvSmo2U1BxNCt5ajlxUHo0K1BqNXlQc0krT2o1U1BwbytYajYrUHZJKzhqOGVQMVkrOGo3MlB5by9iaittUDJZKzdqN09Qdm8rZmp1V082STdxajRhUG1ZK0FqNmlQb0krZmo2YVBqWStZajlLUXlKSEprNFNVeEpXV2xhT1QrSkdVajR1TzNvK2NqOWlQMG8rL2orU1A5SS9GajkrUDdJL3VqKzJQOTQvOWovV1A4SS9Zais2UXBwQ3drSk9RaUpEaWthdVJxSkdQa1lxUmxKR1drYWlSdTVHL2tkcVI5cEgya2VxUno1SEdrZFNSdTVIUWtiQ1E5SkRpa01LUWpvL3FqOHlQdEkrK2o4V1ByWStXanZLUHFZKy9qNkdQbW8rTGo1R1BxNCtlajVpUHpJL0lqNTJQaEkrS2o2aVB2WStWajVDUHlZL0xqNnlQcDQrY2o3NlBrSTd2ajlHUDc0L01qOHFQdW8rbmo4R1BqbytMajVxUHk0L1hqdlNQanBDQmovaVA0NC9hajdTUHBZK25qNm1QdEkrVGp2YU8xbzdVajRXUGlvN2Zqc0tPMlkrQ2o0S1Btbzc4anVhUHRaQ1BrUG1SOEpMYmsrQ1U2cFN3a3JtUWlJN1NqdEdQbUkrcGo3cVFnSkNGaitLUDFJL1FqOGVQc0kvaWtMR1F0NURQa0s2UDhZL1ZqL0dRbHBEYmtObVF6SkRja1llUm5aR25rYXVSbXBHV2tiYVI0cEhZa2I2UnhaRzFrYVdSNEpIeGtaYVE0WkRla09xUXJwQ1ZrSnlRZ1kvV2o3U1B2SSttajRxUGpJK0FqNTJQbUkrUGo2R1BsNDcvanVHT3FvNjlqNHFQb28rNmo4NlBzNCtKanYyUGo0K09qNHlQaFkvRWo5V1Bxby9KajdtUHVJL0NqNGlPMUk3MWo1NlBoWStSajhTUHdvL0lqOG1QMm8vWWo4R1BxWS9IaithUDFZL1pqNnlPOTQ3R2p0R08vSStkajdhUHNJK1ZqdTJPNUk3NGo0T08vNCtFanVHUGxKQ0NrTzJSN0pMcGsrMlV3Wk81a2JtUHNZNzlqNzJQeDQvQmo3T1BsSSs3a0o2UWpJL0VqNnFQdUkvSWo3NlA3cENNa0llUXBKQzFrSkNRbkpEUmtOeVEzSkRBa0x1UTBKRGlrTjJSZzVHMGtiK1IxNUgxa2NhUnhwS0xrcFNSNjVIWWtiR1JvWkR6a01LUW9vLy9qK0NQeUkveGtJK1A3WS9CajV5UGlJN3hqdStPM283L2o3V1BpNCtyajcrUHJvKy9qOENQbjQrUGo2S1B1bytOajhPUDZZL25qOW1QMEkvdWo3MlB2SS84ajlxUG5JK3pqOFNQekkvTWorZVA3SS9VajlLUHRJK25qN21Qdm8rbWo4NlArWS92ajcyUG1ZL0RqK3lQd0kvY2tJNlAzNC9XajdDUHJJL2NqK0tQM0kvQWo2cU85STdzajVpUGw0K2JqOGFQdm8ramo4cVA1cENqa2F1UzJwTytsSUtVaFpQZGtzV1AvNCt0ajc2UHZJL2lqLytQKzQvVGo5T1A4WkNBaitHUDVJL3NrSkdRc3BDYmtMaVFycENEa0xhUXlKQy9rTmlRK0pEYmtPQ1J0NUhya2NXUm41R0xrY0NSK3BLbmtwbVI4Wkh1a2UyUi9KSDRrYmVSb0pHWWtZK1E5WkNva0p1UWxZLytrSWFQejQrSWo0Q1BzNCtlajRPUG9JK3dqNWVQaDQrYWo1S1BpNCtRajRhUHFZKzlqNTJQZ1krV2o4Q1AxSSs2ajcrUDFvKzBqNXlQblkra2o4NlA0SSs2ajVlUHM0L3FqOUNQc0krYWo2R1BvSStuajdpUGtvK0lqNnVQcUkrYmo2U1BwNCt1ajhDUDI0L0ZqNStQbm8rNWo2cVB2WS9sajgrUHZJL2JrSW1QNTQvWWorU1AzNC9HajV5UHFvL01qOHFQcFkrVmo0eVBtbytnajVxUHhvLzZqOTZQNVpDdmtaV1N3WlBDaytHVDg1U0lrdmFRNW8vYmorcVFpSkNFa0l5UC80L2NqN2VQeVpDS2tKaVFrcENJait1UDVaQ0VrS21RcDVDcWtNT1E3WkR6a1lPUmhwRG9rUFNScVpHbmtPMlJoSkdqa2I2UnM1SDBrcHlSLzVIeWtkK1JySkd1a2RXUnpwSDZrZjZSeTVEdGtKNlFySkNTajlLUDBJL0tqN2lQeG8vQWo3U1AwNC9Tajh1UDVZL0RqOHlQMjQrM2o2bVBvWS9Dai9DUHk0K1JqdCtQaVkvSmovU1A4WSs2ajYrUDJZLzFqOGFQclkrZmp2YU84NCtPajZTUDFvL1hqN3VQNjQvYWo3V1B1WStTanVpUG40L0pqNmlPOW83cmo0YVBxWStmajZXUGtJK3FqOENQMVkvSWo1S1BrNC9lai9pUDdJL3FqOCtQeEkrK2o2MlBsNCtvai9pUXBJL25qOXVQNFkvbWorK1B1SStTajRlUGxZK2pqNzJQdDQrS2o2ZVBwNCtaaisrUWk0Ly9qL1NRcVpHRmtkS1M5NVMzbGE2VjRaVGdrcEdQNEkrV2o0ZVAxWkNQai82UC9wQ2trS0NQKzQvR2ovR1B0SStwa01hUTE1Q2RrSjZRdEpDVGtJNlAvWS9Ja0pxUm5wRDNrTnVSajVHcGthS1EvcERza1pHU2hKSDNrY0dSdVpHNGtZZVE4NUd0a2NpUm5KR2ZrWUtRLzVEcmtKR1B4WS9EajdxUGlvKzJqNitPOUkrb2o3S1BrSTcwanVHTzZJN3pqNVdQbkk3L2o2T1AzSSt1anZxTzNZN0pqdk9QbTQrK2orYVA0WS9iajZxUGhvNzlqNUtQbG8rd2o1NlB1SS9Xajh1UDBZK3dqdG1QbW8vaWo2V1BrbytEanVPTzZZN1dqdVNQcEkvSmo1eVBpSSt4ajcyUDFZKzdqN1dQdTQrK2o4bVB4NC9JajlHUDVJL09qNVNPOW83OGo0U1B5WS9OajR5TzVJN2lqNHlQcFkvSGo3cVBxWSszajZhUHlwRFBrZjJUdUpTZ2xLQ1M3NURoajVtUGdZL0VqOFdQdEkvdmovQ1A3WkNUaittUHJvKzlqOVNQelkrdGo4bVFpSS90a0xHUXZKQ0prS2lRejVHQ2tQV1EwcER6a1BXUS9aR1ZrWTJSajVHY2tZS1JtcEhra2VhUjZwSExrWW1RdzVENmtkMlJ0SkRFa01hUTU1RGNrS0tQM1krWmo2R1AwbytaajZLUHZZK3pqNVNQalkrRGo0R1BrWStRajVXUHhJK3FqdmFQaFkrT2o2MlB4bysyajhpUDFZL0hqOTJQelkrZmo1MlBoNCtLajVDTy80NzRqK1NQN1krOGo3bVAyby9pajYrTzVZNytqOHlQdkkrOGo3MlB1NCsxajZhUG9JL01qNnlQcVkvQmo2dVAxSS9ZajhtUDNJLzFqN1NQclkvSWo5U1FrSS9jajhpUWhaQ1BrSlNRbEpDQ2tJdVA4NC9IajVPUHBZKzFqNjZQeW8vQWo2S1BqWStSajcrUHdZL1NrSk9RMlpIR2t1YVR6NVNnbFBDVXNKSzdrS2FQdUkrMWo3aVB6cENma0pxUDZwQ0prS3VQL0pDUmtMYVFxSkNua0o2UWhvL3FqOW1Rb1pEeWtOK1F3SkRua091Umk1R3lrWnFSc3BHOGtabVJ1NUhua2RDUjNaSFhrYytScEpIbWtvZVNnNUg1a2FHUS81R1JrWTJRODVEMGtNMlFwcENSajhHUGxvK3dqOUNQdm8rSGo0ZVBpSStuajUyTzdZKzlqOWFQcm83K2o4aVA0byt3ajZ5UHZvKzdqNjZQcEkrNmovcVFoby96ajdpUG80KzFqN3VQMFkvaGo4dVBzNCtyajZLUDFZL3dqK0tQNW8veGo5cVB2NC9DajQyTytJK3NqN2VQeDQvT2o3cU8vNDc5ajlLUHo0L2JrSmFQN0kvRGo5K1FwSkNQa0lTUDlvL3VqK1NQN1kvN2tJeVB6WStRajZ1UDBJKzlqNXFQbW8vY2o4YVB5bysyajR5UHRvL29qK2lRb1pEMmtwcVQyNVNNbE51VXZKS2NqKzZPMlk3N2o3V1BvbytvajZ5UGlJK1dqOU9QeG8rZmo0T1ByNC9CajdTUHpJL3JqNjZQaTQvWGtLaVFpWS9Nait5UXNwRE1rTFNRMVpEMWtOT1F4NURZa05TUStwR2lrWnlRN1pEb2tQcVE4cEQ5a051UXlKQytrS1dRa28va2o5T1AyWS9VajhPUGxvN3NqdWVQeFkrN2o0bVBoWTd0anZlTzQ0NjhqdmVQakk3Z2p1Q1B0NCt6ajZPUHlJL0xqN2lQb283emp0MlBvWS9WajVHTy9ZK2tqNkNQeUkrdGo0NlBqbzcyajRpUHpvKzJqNitQaW8rR2o3T1A1WS9TajZPUHVJL3VqK3VQd28rdmo3bVB3by9Iajh1UDE0L2hqL2VQLzVDRGtJbVA2NC9KajlPUHA0NzBqNFNQdEkrbGo1NlBnbzdOajRxUHRJK0pqNDJQdkkvc2tJYVAzcENza2NhU3ZwUEFsSWVVbHBPb2tjK1B6NCtNajdXUDVJLzNqOXVQMnBDQWtJbVA1by9FajhtUWdKRERrS3lRb1pDYWtKaVFxWkRia09lUXNwREZrT2VSZ3BEemtQV1JsSkc4a2RlUjRaSHVrZStSelpIVmtjV1J2cEgwa2ZhUjFKSENrZHVSeFpHNWthV1JpWkRwa0xpUDdvK3NqNlNQM28vVmo2aVBvbyt2ajgrUHQ0KzBqNUdQbFkrY2o1aVBnSStrajlPUHpvL0FqNVNQdW8rMmo0T1Bwbyt4ajZ1UDBvK29qNk9Qc1krZGo3cVB1bytnajQrUG5vL0FqN3lQdG8raWp1MlBobytVajVpUHFvK09qNEtQaEk3N2o2T1B4byt4ajhtUHZZK1NqNlNQdW8vQWo5R1BxWTc4anVpUGpZKzFqNm1QblkrOGo3aVBwNCtjajR5UGhJN3lqdWVPM28rTGo1Q1BtNCtTajc2UXhwSHdrNGFUNjVTNmxMS1M2NUNyajRtUGlvL0lqK0tQdVkrN2o4bVB3WStxajdHUHlZLzRqKytQem8vT2tJQ1FzSkNNa0ltUWw1Q0VrS2VRdXBDMmtQcVJnNURxa1BxUm81RzJrYmFSdXBIQ2tjZVJ2NUhka29LUjBKSE1rZUNSMEpIM2tmS1J6SkdKa1BDUTE1REJrS1dQNVkvU2o4ZVB1WStoanZxUHFvL0NqNmlQd28rMWo1ZVB1WS9WajdXUGpZK0xqNk9QdVkrdGo2K1BvWS9Eai8rUWdJL0VqN2lQMEkvc2ovV1B3SStKajQ2UHY0L0hqN09Qd28rL2o4YVB4SStpajRHUHFvL01qOGFQdVkrcWo2S1BuSSsyajZPUGg0K3ZqOW1QM0krN2o5bVA5NC9yai9xUC9ZL1RqNnFQcW8reWo3YVBuWTcwajRxUGpZK3FqNzJQcTQrSGp1eVBvbys3ajVhTzQ0K1FrSVdSaEpLaGs3YVVuNVR2bGFHVHZKQ3BqdXlQa28vTGovT1A2WSt6ajVHUHJJL0FqNzJQMm8vWGo2dVA3WkNaaitPUCs1Q3BqK3FQMVpDdmtMR1FrSkM5a015UmhKR2JrUGVRNEpHRWthR1J1cEcza2FHUnRaSE9rY2FSdHBHN2tjcVJ6Wkdwa1B1UmlwRHlrTWFRNXBETGovK1B3NCszajc2UHZZK0tqdVdPOFkrK2oraVB6WSs0ajZDTzhvK0hqOFdQM28rdGo2cVBxNCtnajRxUHZJL3JqL2VQMjQrNmo3aVB4WS9DaitXUDRvK3NqNCtQdG8rMGo2Q1AzSS9pajdhUGxvK2RqOFdQMlkvQWo3K1BxNCtkajdhUDJvL1lqOUtQdW8rY2o2aVBsbys2ajlpUHc0L0hqL1NRZ1kvZ2orbVA0SS90aisrUDBZL2lqK09QelkvSWo4dVBxWStxaitDUDZvL09qNTZQbVkvYmo5cVAxSkNaa05HU2paU1lsWTJWd3BYWWxJYVJ1SS9pajZTUDA1Q0lrSitQLzQvc2orYVA2WS9wajlLUW5KQ2VrS0tRaFkveWovNlFzWkRBa0srUXNwQ01rSmFRMDVEZmtQbVJpcEdGa1lLUm01R2drYWVTaFpLSWtkeVI5Wkhla1l5Umk1SEprZCtSejVHQWtLZVF3SkM1a0t5UXA1Q0FqKzZQeUkrWWo1eVBtby9laitPUG40NzZqdE9PODQ3eWp2K1BxNCtSanVXTytZKzBqN09PL28rQ2o2YVBybyttajdDUHBJK09qNXlQdW8rVWp2U1BnNCtrajVXUHA0K3JqdldQalkvR2o1Mk8yNDdZajZhUDBvKzVqNWFQa0krWGo1cU8vWTdwajd5UHVZK09qNWlQclkvRWo5S1FqWkNKajlpUHVZNzJqc2VQbTQvRmo3aVB1WSthanM2TzQ0K2VqNk9QcUkvU2o3Q084NDdqajhLUXFKR0drZktTMXBQUmxOdVV6cEsvai9xUG1ZL0pqOStQOVkvTWo3K1AwNC9MaisyUDhvL3VrSWVQL1pDQWoveVA2SS8wa0lDUW1wQy9rTWlRMFpER2tONlF1WkRqa2JTUnM1SGZrZktSejVISGtjeVJxSkc1a2VhUi9KSGhrYjJSeDVIU2tjU1JrNURoa00rUTJwQzdrSktRa3BDTWo5Q1Bzbys3ajdDTzk0N2lqNFdQMG8vbmo3YVBxbyt5ajdDUG9vK2ZqNUdQejQvb2orR1A4by8xajd5UHFvK1VqN0tQeUkvRGo2YVBvbysyajlTUHlZKzFqOHlQem8vVWo4aVBrSTcvajZDUHZZL0pqN21QajQramo3cVBrNDdjajRpUDFJL0JqNnFQbTQrMWo1K084WSttajd5UHFvL2RqOE9QdEkvbWorK1A5by9yajlhUHk0K3NqNTZQblkrUmo0NlBtWSs5ajhlUHBJK3FqNU9POFkrYmoraVF4Skhia3ZXVWpwV25sYjZVZ3BHMWo3bVBxNC9pa0xtUXZKQ1lrSTJRalkvM2ovU1FpNC85a0tDUTZaRE1rTGVRdnBERmtLT1FzSkRha05hUXc1RHprWldRNlpHdGtkZVJ2cEhOa2NlUjNwS3VrcDJSNkpLaGtwYVI4cEtva3JXU2xwSDNrYjZSazVEL2tQS1F3NURHa01XUXZaQ2dqOUtQMEkvUGo2ZU84WTc3ajUrUHlJKy9qNTJPLzQrSmo2MlBrSStQajhPUHU0K3hqOUNQNkkvbWo5aVAySS9UajVhUG5JK2tqN1dQdkkvQ2o4dVB5NC9sajg2UHJJL1BqKzZQNlkvcGo5Q1B0WS9NajgrUHVvK2RqNXVQLzQvd2o5bVA1by9BajhxUDNvL1RqOEtQdjQramo0Q1BrNC9TaitXUC9ZLzBqOTZQMVkvS2o1K1B6NUNia0lXUDlZL25qOFNQZ0krNmtKT1A2SSs1ajVHTzlvK05qNlNQcVkrRmp0U094bzdnanRlUGlZL3lrTGlRL3BIWGt0R1QycFM4bE5lVHE1RFpqdm1POEkrTWorR1A5SS9hajlpUDBZL1lrSVdRam8veWtJcVFtby96ais2UWtKQy9rUFdRNkpDNWtLNlF3NUNua0ppUTdKRzVrYldScXBHaGtaMlJ1cEhka2NHUnpKSGVrY21ScHBIT2tkR1JvSkQxa095UTZwRFFrS21RazVDQWovZVAzWS9LajVlUGg0N1lqcitPMjQ2aGpyV08zSStCajVpUGpJK2JqNktPK1k3dmo3Q1B4NC9jais2UHRvK3NqN2lQcTQrb2o4bVA0by80ai82UDFvL2NqN2lQcEkvQ2o4dVBzSStOajVtUDRvL1NqditQaTQvVWo3cVA0by9wajcrUHFJNzNqdm1QZzQ3L2p2Mk8zbzdianQ2T3pJN01qNE9QelkvVWo5K1A3SS9raittUHpvK0FqN2FQOW8vUWo2T1BrbysxajdXUHBJK1FqNHFQdVkvTmo2NlBwWkNGa1ltU3BwUFBsTCtVNkpTMGt1V1EyWS9Uajd5UHNvL21rSlNRZ0pDTGtLeVFwWkNYa0lxUXBwQ2RrSStRc1pDMGtOV1EzcEM3a05PUTY1R0trWVNRK3BEMGtZNlJuWkdoa2JpUno1SFFrY09Sa3BHdWtjbVJ2Skd2a2JPUnI1SEZrYmFRK0pEQmtKMlFoWkNIa0lxUDRJK3pqN09Qc28rYWp2aU8xbzY0anRHT3ZJN1RqdmFPeUk3bGo1dVBrWTc2anVhTzA0N0pqcmFPNUk3YWp1YVBwbytianZxTzNvN21qdktPOW83dWp2ZU83WTdrajRPTzlZN2lqNEdQa1k3L2p0Mk96STdCanN5T3RJNjRqdCtPN28rRWp2bU82NCtEajRPTzhJNzRqdnFPOUkrUmp2ZU8zSStkaitxUDNJK2RqNkdQZzQ3VGpzbU83bytLajUrUHZZL2RqN0tQb1kvYmovQ1B5byt5ajZhUGxJKzRqNmVQbkkrVGo0S1B2SS9vajc2UGpZNzZqNkNQd1krL2o2T1BtWS9Pa0tDUno1TGhrOG1VeEpTems0S1E3SS9JajhTUDdKQ1RrTFNRcDQvL2oreVFoNUM5a01HUXpaRFZrTGlRbVpDcWtPcVJqcEQra09lUTZaR1BrZFdSelpHaWtaNlJzNUhIa2NPUnlaS21rdU9TMlpLZGtwT1NwNUsza3BtU2hKS01rZitSOVpIeGtkNlJ3WkhHa2F5UTc1RENrSUtQNTVDTWtNZVF3by9xajlXUDM0L3NrSW1RZzQrM2o1dVA2WkNTai9XUDg0LzlqL3lQOHBDRWovbVA1by9uait1UDlZL3NqK0NQNEkvU2o2aVBzWS9MajhXUHBJK1ZqNmlQMTQvRWo1R1BnNC9IaithUHhJK2tqN3VQNDQvVmo3YVByNC9OajlDUHRJK0xqdE9PKzQvSGo3MlByWStnajZLUGpvK2pqOTZQMEkrTWo1aVAxWS9QajZLUG5JKytqNVNPNjQ3aGp2cU8vNCtDanZ5TzM0NjdqdFNPNVk3b2o1R1AxcEdCa3NXVDVwVFFsUE9UN3BITmorV1BxSSs2a0kyUWtvL2lqL0dRaUkvdWo5S1AzWS9tajkrUDU0L3RqL0tQK1kvVGo3NlAxSkNRa01HUXNwQ2FrSXlRd1pESGtPbVJsSkdCa09tUS9KRCtrWk9ScVpHZ2thdVJxNUdQa1lxUnQ1RzFrWU9RL0pEYmtMQ1FwNUNva0llUDRJK3hqNWVPOEk3Z2p2dU81NDcvanYyUGpvK01qdnVPOFk3dWp2V081bzdsanZLT3lvN0RqNFdPNm8rb2o5MlAwNC9CajZxUGxJNzNqdmlQaG8rUmp2aVBnbytkajZxUHBvK3RqNGFPK28rb2o3bVBtSTdjanVtTzRvN2pqNGlQbDQ3Nmo0T1B2byswajgyUDlZL3lqOWFQekpDSmtKNlFrSkNya01XUXZKQ3prSXFQK0pDT2tKT1FpWkNJaisrUDhZL1pqOW1RbUpDcmtKaVAwSSsrajhLUHZvLzhrSUtRa1pEb2tjU1M2NVNKbE95VXpKTDJrUE9Qd1krY2o0eVBzWkNEajlhUHFvL0tqOU9QdW8vQmorQ1A0NC9wajlpUHlJL1BqOW1QN0kvbWorMlFvNUM2ai9TUW1KREtrWXVSZ1pENGtQT1JocEc4a2I2Unc1RzdrY1NScUpHVGtZbVJuNUdXa1lLUmg1RHRrTUdRaUkvOWorU1B4bytranRDT3JZN2VqdTZQazQrRGp1dU82NDdpanVXTzVZNnZqZnlPd1k3OGp2U081WTdzajZTUHQ0L09qK21QMVkrOWo3YVB1SS9JaitLUHc0L05qK2lQMW8raGo0MlBobytCanZhUGhvNzdqdnlQbUkrQ2p0Mk8ySStVajYrUDJKQ0ZqOXFQcG8rNmo3T1BvSSsyajZTUGpJK2FqNE9QdjVDQWovU1FoNUNva0oyUW9wQ0ZqKzZRaEpDY2tJK1A3WkNLa0t1UW1vL09qNDJQdlkvWmorS1FsNC8rajhLUDVvL3pqL3FRblpEZWtiYVM1WlNMbFBHVm81V3JrK1dSazQvaGo4dVA3SkM0a05TUXVKQ3hrS0tRb1pDbmtLdVEwNUNraitDUWw1RExrSytRcFpDZmtJS1FzSkRoa1lHUTdKRGFrT21SZ3BENmtZeVJ0NUhaa2VlU2pKS1ZrcHFTbFpIOGtlbVJzcEd4a2NhUnM1R09rT0tRMUpEb2tOR1Fuby8rai95UWdKQ0NqK2VQdEkvRWo4T1B4WS9Kajc2UHlJK21qdjJPMVk3TGp2NlBqNDczajdDUDNZL05qN0dQeFkrWmo1K1B0WSt5ajk2UDNZL2NqOUdQckkrbWo3dVBzSS9GaitpUHc0KzRqNldQcDQvQmo3aVBzSStuajZPUHFvL0ZqOCtQcjQvS2orV1B0bytLajdPUHU0K0pqN0dRZ28vUmo2dVBxby9Gai9lUDhZL0lqNXlQbUkvVmorbVA4NC9ZajhLUDJJLzZrSldQL0kvdWorK1A2NC9XaitxUC9ZK3RqNmVQMVkvUGo5dVAwbys1ajdPUHdvL1JqK0dQcUkrTmo4R1F0NUd6a3FlVDJwV0FsZXlWMFpQR2tPT1BwSStka0p5UTFwQ2xrSU9QOFpDQmtKMlFvcENFa0pDUXNwQ3hrSldRaTVDQWtKaVE1cER1a09LUXg1Qy9rT0NSaVpHTWthMlJ1Wkcwa2JHUjFwSGJrYkdSK1pLNWtwV1NoNUhza2NXUjRaSHZrZkNTbTVLQ2tjcVJnNURLa0t1UC80LzFqK1NQem8rdGo1Q1BxSSthajdpUHdZK2RqOHFQN0kvRGp2eVBwby8wai9DUHdvL1VqOHlQdjQrbmp1ZU81NCt4ajcrUHRvK1VqNldQem8vRWo3Q1B2SS9qajg2UHA0L0VqK09QNDQvVWo3cVB3bytnanZlUG1vKzJqOHlQdDQrUWp2K08rNDdwanVTTzVJN2RqdHlPN1k3MGo2bVBnWTdIanRTUG1ZK1VqNENPOFk3M2o1NlBuWStxajVtUGlZK3FqOENQdjQraWo1U1BqbythajlTUHY0K1FqdnlQdW8vRmo1R090NDdyanY2Ty9vN3pqdEtPeTQ3WWp2R084NCsyai8yUXM1SGtrNUtUKzVUcGxNU1N5NUNWanR5T3BZNi9qN2lQL28vSmo0YU8rNDcyajRhUHpvKzRqNmFQelkvK2o5dVB3WS8yai9xUWxaQzlrSkNQN3BDTGtKU1FuNURUa05tUTJwRHdrWXFSa1pHVGtaK1JySkhLa2ZhUi81SFNrYitSeDVHaGtZNlJnSkRQa0wrUXZwQ2RqL0NQMVpDaGtMZVAvSSsxajZPUHdvL2pqK0tQcjQrc2o1bVBsSStJajhhUDdZK3BqNHVQa0krY2o1dVBySS9EajhlUHVZKy9qN3VQdzQvR2o5cVFnby92ajhpUHdZKzdqNmlQdkkvRGo2ZVBuSSs0ajltUDhJL3dqKytQeUkrcWo2R1BqWStYajZpUHZZL1ZqNDZQalkvWGo5K1AwWS9Iai9PUWxwQ2JqL0dQN0pDS2ovK1A5WkNMa0lXUWpJL1dqNUNQckkvaWo2bVBuWSs0ajhxUHlZL0ZqNitQcW8rNmo2cVBnWStXajllUWxKR3ZrdE9UM0pUd2xhQ1VqWkhza0lLUDBZLzJrSjZRakkvOWo4K1A2WS8vai9pUDA0L3BrTGVRczVDWWtKS1FtWkNla0tTUTFKRGRrUFdSazVHU2tQK1E5SkRsa1pPUmw1R0ZrYStSeUpIcmtmT1J4NUhDa2VPUjhaSGVrY2FSckpHUGtZR1JoWkR4a0oyUWtKQ1FqK0tQdEkrOWo4MlB2NCs2ajdPUGdJN2pqdmVPNkk3Nmo0eVByWSs0ajUyUGtvK2FqNTJQakkrS2o1cVBqbytqajZTUHFJKzhqOG1QczQvT2orQ1Axby9YajlLUHBvL0tqL09QOVkvdWo2V08yNCtRajlPUHQ0K0lqdmVQaFk3emp2R1BqWStYajRhUGlJNzRqdGVPMW83aGp1ZU95bzdUanZlTzBvN1JqdkdQaTQrTWp1K084bzdaanMrTzBJN2ZqdHlPMFk3cWo0bVBuSSsxajlXUDlJL3dqOVNQdG8rL2o4MlAxNC9na0lPUWtvLzBqOEtQem8rL2o4T1Azby9sajlTUHVZK0xqNEtQK0pDYWordVArNUM1a1pPU2pKT0RrL3VWbFpYZmxKR1J0SS9FajQ2UG40L0ZqOFdQMFkvVGo5K1AxNCtmajZDUDA0L0FqOTJRckpDZWtKaVFtWkNUa0tDUXQ1RCtrWXlRNDVEbGtQV1EvSkdRa2JXUnNaR3ZrY1NSNFpIZmtlYVNpNUtPa3BPU21aS1Brb09SM0pIQWthaVE4WkRxa05hUXpwRFVrS0dQODQvY2o4eVAxSStqajZpUDRZL2dqNitQbUkrZGo3R1B3NCt1ajVHUG9ZL0xqOXVQNlkrOGo3R1B4WS9BajZ1UHVvKzJqN1NQMjQvemo4NlBuNC9pajlDUHdJL0pqNzZQelkvRGo3bVB1bysrajdDUHA0K09qNGFQcVkvT2o4cVBvSS9ma0lpUDFZL0NqOHlQeDQrd2o2U1Bubys2ajhDUDI0L25qNzZQdm8vTGo2Q1BvWSt4ajhLUDQ0L2xqNzZQdjQvTmo5K1AwNC9oajllUHZJL2RqK0dQMFkvZGo4ZVAySS95ajhtUHlJLzVqL3FQeVkremo4YVB1by94ajlxUHBZKzBqNzZQakkrVGo2V1Bzby90ais2UDlaRGhrb1NUdFpTL2xhYVZ3NVRIa3BLUXFZL3RqLzJRdVpDdmtJR1A0WS9laitXUHo0L2pqL3VRa1pDcmtMcVFvWkNva01hUXRaQ21rTEdRM3BEcmtPR1E2NUdCa1lXUmdwRzlrZG1SeUpHNGtjQ1IxcEh4a2ZHUjlaS09rZWFSeVpIV2tjV1J6WkhYa2NTUm5KRHRrTUNQKzQvV2ordVAxWSs2ajZDUGtZK0hqNGVPOW8rU2o3bVAySS9WajY2UGxJK2JqNDZQazQraGp2dU84byt0ajhhUHQ0K2VqNCtQcUkvT2o2bVBybyt6ajZDUGpJK2ZqN3lQdTQraGo1V1BrbytkajQyUGtvK3FqOGFQcFk3dmp1V1BoWStsajdhUG5vK1dqNWFPKzQ3L2p1dVBrSS9Bajh5UHdvK3ZqNTZPK283d2o0YVBpWStXajhHUDBZK3pqNHlPN0krRWo1V1BtWStwajdDUHpJKzZqNnVQdm8vYmtLS1FtSS95ajkrUDdvL2RqNjZQMDQvV2o4YVB4bys4ajgrUG80K29qN1NQcFkvSGorU1B1SStkajhlUWpaRDhrZEtTeEpQZmxNV1U3WlNKa2ZhUWlZKzJqOWFRbFpDUWorT1A4cENpai9DUHY0L2xrS2FRcEpDdGtKQ1FncENZa0tpUXo1Q21rS09ReUpEamtQV1JoNUdPa1pHUmtKR0xrYUtSdEpIWmtkV1IzcEh0a2V1UjlwSHhrb2FTbnBLemtveVIySkd3a2JhUnBaRGtrSjJRbW8vaWo4U1A5SkNEa0lhUDI0K3pqNVdQZ28rUGo2R1B1WSt4ajdpUGtZK0hqNitQeDQvY2o4dVBwbytUajVXUHdvLzNqOHlQblkrbGo4K1B3WS9JaitpUDBJKzZqNitQdTQvQWo3eVB5SS9TaitHUWlJL3RqN3VQcUkrdWo3dVB3bytvajZ5UHJJK3pqN21QdEkreGo1eVB3WS9uait5UDNJL2JqK2FQdEkrcGo4U1B6SS9JajhPUDBJKzVqNWVQb1krSWo2R1Ayby9BajlXUDJwQ1VqL0tQdUkrK2o3NlB5WSt1ajQrUHBZL0tqNzJQdm8vbWorbVAxWS9oai9DUDVZL3BqK2VQNm8vOGtKV1FuSS90ajh5UHQ0L2JqL0NQK0kvcmo5Q1AwNC92aitLUHpJL1hqK3VQNjQvSGo3YVB5NC9sai82UW5aREhrYXlTdXBPamxNK1Z6WldzazZpUTBJK21qOG1RcjVERGtJK1A2cENGa0pLUXNwREZqL09QMzVDTGtKNlFxby84aisyUDU0LzdrTGFRMkpENGtZZVJoSkdEa1AyUStwR2JrYVNRKzVEM2thYVI3Wkhna2NTUnlaSGtrZmVSOFpIWmtiZVJ0WkhJa1pTUXpwQytrUDZRODVDVWorQ1A2NC9OajRhTzVvNy9qNW1QajQ3Wmp1V084WTdQanFhT3A0NjNqdXlPNTQ3cGpyK09zbzdmanR5TzlZK1RqdldPNEk3Ymp1K08rSTduanVhUGo0K2JqNEtPNlkrRGo1K1BsbytLajVLUHVZL1lqOGVQckkrc2o1ZVBvWSsrajhTUDJZL2tqOWFQeW8vQ2o4ZVAzWS9YajgyUDJJL2lqOEdQMlkvdWo4MlB2NC9VaitXUDhKQ0FqL3FQMUkvamordVAzcENUa0pxUDVvL0xqNW1QbTQrdmo0MlBoSSs4ajlDUDNZKzlqOHVQeG8rL2oreVA1by9yajYyUGo0K2pqN3FQckkrTWp2V083bytaajdTUGlJN0hqc09POW8rQmo2U1Bzby9Ka0lpUXo1RzZrc0tUNjVUaWxhNlV1cEtka0krUHBZL0FqL2lQL0kvV2o5S1A4cERMa05lUXdaQ3prSVdRbDVDNWtNaVFtWkNka0xxUTVwRDhrTzJRK3BHR2tZU1JnNUQ4a1lhUnVKSGJrZHVSMXBIRmtlR1I2Skgza3BlU3A1S0drZVdSOHBIOGtkZVJ4Skdva1BPUTRwRE9rTW1RdkpDTmo4NlAzSStvajZHUHZZK2tqN0tQaTQ3ZWo2T1A2WS9MajQyUG5JKzhqN3FQcDQrc2o2ZVBsNCtmajZLUG1vK3FqNjZQbm8rY2o3R1B2WS9HajdpUHJvK3VqNGFQa1krdGo3ZVB5WS9GajllUHdZKzVqOUtQMTQrOWo2S1Bxby9Jai9tUCtvL0RqNitQbzQra2o4V1Azby9XajllUDdJL25qOHVQdkkvUWo5cVAyWStGanZXUGlZKzJqN0dQa1krUmo1dVBuNCtmanYyTzZJK0FqdktPelk3UWp2YVBpWSthajdxUG80N21qdHFQbG8rZGp1YU85SStLajVTUHI1Q0FrSk9QL0kvbGo4eVAxby91ai9PUHU0K3lqNnlQcG8rN2o0cVB0SS9MajdLUHc0L1FqNytQd1kvYWtLeVJ4SkxIaytPVTZwWE5sYW1UcXBEZWo4aVA0WkNQa0ppUWtZLzVrSkNQLzQvR2o4V1ArcEN6a0xlUWlaQ0drTE9Rc0pDQWovcVFvSkRBa0w2UTFaR2FrWmlSbjVHYmtQR1JtSkhFa2NxUnpwSFBrZGFSMHBIMWtmMlI1NUh5a2QrUnlaSGFrYytSdXBHWmtOK1F6WkRCa0wyUXFJL3NqOVNQdVkvUmo4U1BvSSs1ajgrUHVZK1FqNW1QazQrc2o2R1B1by9TajgrUHlZK2tqNFNQd0kvYWorYVA4by9UajllUDM0L2RqODZQelkvS2orQ1Azby9jajdXUHpKQ0FrSU9QNG8vaGo3bVAxSS81ajl5UDhZLy9qK3VQMTQvRmo3dVAyNC8vajlPUG9JL0RqL3lQNlkvcWorZVB5SS9Za0lDUHZZK1BqNDZQZzQrbWoraVA0by9SajZlTzRvN3BqNldQbDQ3WWo1R1BuNCtNanZPUGpZK3NqNG1QaTQrYWo1aVBtSStzajdtUHQ0KzFqOVdQNjQvbmo5MlA0SS90ai8yUDc0L2ZqOXVQcFkrZmo2K1B5SS9QaisrUDU0KzdqN2VQMkkvOGtJQ1F0NUdwa3FPVG5wU3psYlNWdVpQbmtZdVB1bytvajhLUDhwQ29rTFdQOFkvaWtKR1FnNUNIa0ppUCs1Q1FrS3FRcjVDMmtNdVF1WkRla1lxUThKRHJrT1dROHBHU2taaVJsWkcza2MyUjU1SGVrZWVSNkpIeWtlZVJ5Wkcza2I2UndwRzJrYnlSeFpHc2tQNlF5WkN1a0l5UCtJL2RqNVNQb0kvQmo2dVBpWTc4anUrTytvK2ZqNWVQZzQrQWo0NlB2NC9HajVpUG5ZL0VqOGlQdkkrbWo2NlBzbys4ajhlUHc0KzVqOCtQejQrbmo0dU84bzcwajVXUG5vNzRqNTJQdUkrY2o0U08vWStIanY2UGlZK1pqNnVQZ0k3aWp1bVBqWSttajVPTy9ZK0tqNFNQcDQrd2o0aVBqSStUajZtUHJJKzlqOHlQMkkvaGorQ1A4SS9SajdpUHY1Q0ZrTGVRczVDTmorV1A1WS8zajl1UHE0L0xqNjJQcW8vcGovQ1Awby9JajdxUHM0L0xqOUNQdDQvY2ovMlA5NC94aitLUDFvL01qOWVQd1krdmo3cVBzNCtWajRlUHJJK2ZqNFdQbFkrTGo1K1BuNCtCajVTUHk0L2RrTHFSejVMRGsrcVU0cFRtazdxUmdvKzVqNEdQa1krM2o5R1B3NC9NaithUDA0L29qKzZQcTQrNGovQ1AwNC9NajlpUDY1Q0prSUtQNm8vcWoveVFtWkMya0orUWtaRGhrWmlSbFpHRGtQZVE0WkRva1o2UnFwR2hrYWVSbXBHWmtacVJpWkdia1BXUTdaQzFrSXlRcFpDQ2o3aVB0WSs5ajZlUHBvK2pqNmFQbzQrWmo2aVB6WS9tajltUDVJL01qODJQOUkvdmo5ZVA3WkNPai9HUHo0LytrSkdRaUpDYmtKZVFrWS8vai82UXFaQzRrTVNReUpDWGtJV1FuWkNLai9PUDc1Q2JrS2VQNkkveGtKR1A3WS9vajhLUHBZK3ZqOCtQam8rRGo2V1B0byt1ajVxUHI0KzJqN1dQa0k3NWo2T1B2SStwajVHTzg0K2FqOHVQdDQrZ2o2YVBrbytuajhTUG1ZK3FqK2lQMW8vSWorZVFnNUNJai91UDBvL0hqL0dRZ0pDU2ovcVFsWkN5a0pDUWdaQ1JrSnlQMDQvSmtKYVFqSS9tajhLUHVZL3JqK3VQOVkvZGo5cVFpWkM0a1BxUng1TFRrLytVNFpXZ2xZV1RnSkRoa0tlUXNwQ3ZrSnFRbTVDNGtLcVFqWkNxa01DUWo0L2xqK2FRbzVEU2tMdVF1cERna09DUXlwREdrTmVROXBEL2tQU1EzSkRKa01tUStwR1hrWkdScUpHR2tOMlJyWkh6a2NlUnU1SEZrYStRL1pEZ2tadVJ1WkdSa0w2UW5aQzBrS2FQNm8vZ2oveVA3WS9najhXUHBvK2FqNjZQeEkvZGo4aVB6by9FajZpUGw0K0tqN3FQM28rbmo2YVB3byt2ajhlUDRZL0FqOENQeFkrdWo0cVBoWStxajZ5TytvN1NqdXVQa28rQ2o1V1BsWStMajRpUGpvK2RqNXVQazQrR2p2Nk8ybzdUanZDUHA0K1lqdWFPMW83eGo2T1B5by9UajdXUHJJK2NqNDJQbm8raGo2T1B0by9CajZtUG1JK1FqNEtQaDQrT2o0MlBqNCtWajQyUGtZNy9qdnVQcW8rNGo3YVBySSs1ajlDUHI0KzdqN2FQaFkrc2o3U1BySSs1ajRlUGhZK2lqN1NQalkrVmo5R1AxSSsvajVDUHZvL05qOEtRaHBEbGthNlNzWlBZbFBDVm9wV2drK0tSaTQvQ2o4R1AvWkN0a0orUWhaQ1drTUNRdnBDeWtKV1FxSkRCa05lUTVaQ3prTEtRMVpEWWtObVE4cEdHa1A2Um1aSERrYzJSMXBIWmtjcVJ4SkhQa2VlUjZwS09rcStTbHBLM2t0R1NuWktXa29PUjhKS0hrb1dSMUpHVGtOMlExSkR1a051UXQ1Q2FqK1dQd0kvTGo4cVAwby9Uajh1UHg0KzlqN2FQbDQrWGo4MlFnSkNBa0lTUDZZKzhqN3VQNW8vY2orYVA1by9Wai9hUWhwQ1NrSmFQMFkrcg=='
        }
        {
          '_id':'100'
          't': '2015-07-05'
          'e': 'a0thUWpZL3NqOU9QMzQvcGo4R1FoNUNoai9HUWtaQ0FrTENROTVEWmtNdVF0WkRYa1pLUmw1SEFrYmVSbFpEOWtaeVJ0Skc3a2ZlU21KS0VrZFdSenBIa2tjeVJwcEQ2a09xUXhKQ3JrTU9Rbm8vMmoreVAwWStzajUyTzlZNzZqNVdQZ1krZGo2R084NDdmajR1TzdJK1NqNmVQb0krb2o2dVBwNCt0ajdpUHJZK05qNStQNVkvY2o5S1BzbytMajZXUHI0K3JqNk9QcVkvSGorS1B5NCs0ajZ1UHBZK0pqNnlQazQrR2o1bVBrWSt3ajgrUGxvKzJqOWFQbG8ramo2S1BwNCt4ajZ5UDNZL09qdnFQZzQrQ2o2aVAxby9Sajl1UC9JL3NqOCtQdkkrdmo2K1AxWS81a0phUDhvL0NqNnVPOG83TGp2YVBrSSt2ajhlUHBZK2tqOWFQMlkvYmorNlJsNU9jbEtlVm5aV1ZrOXVSZzQrc2o1T1BySS9oais2UDJZL1prSjJRdkkvMWorNlA1WSs2aitLUWtaQ0ZqK21QNkpEQWtOQ1FsWS9za0xXUmpaR2RrUFNRNHBESGtQYVJycEhMa2E2UnJKR3FrUGVSNlpLcGtjV1J4cEhxa2N5UnRaRzhrUDZRNEpEeWtOK1F2NUNlai9pUHBZKzBqN0dQcnBDWWtJcVB0NCtTajY2UHFvNzZqNmlQckkvQ2orNlB0SStKajVtUHFvL3pqOTZQblkvWmo5aVAzWS9Zajh5UHc0L2drSXVQNzQvYWovYVA0by9WajdxUGxvK3RqOWVQMFkrbGo0V1B1NC9qaitpUDhJL1ZqN09Qb28rNWo5MlFnSS9SajR5UGtZL01qL0tQMFkvRWovaVB4NCtrajhHUHU0K1RqNmVQelkraGo1V1BtWStQajRhUGk0K01qNHFPLzQrUGo1aVAxcENPa002UnRKTGFrOE9VbTVUZWs5R1JxSS9MajdhUHhvL0NrSWlRaDQvRGo2cVB4WS9EajhHUDU1Q3RrSTZQN0kvQ2p2dVBpby9la0lTUXdKRDVrTWVRNVpEeGtOeVF5WkRva1k2Um9wR21rUDZSanBIOWtmK1J3NUhBa2NpUm1wSEJrYitSeHBIYmthQ1E3NURBa01pUXI1Q0lqOHlQcUkrNWo0eU96WTcwajdhUG1ZNzRqNmFQclkrUWo0K1B1WS9KajgyUHNJK2ZqN1dQcEk3SGpzbVBvSS9lajlTUGxvKzhqL1NQd1krd2o3YVBnbyt5a0lHUHU0K3VqK0dQOEkvaWo4T1BxSSt4ajZPUHRvL1pqOEdQbW83d2o2NlArby9laitlUDhZL0VqL1dRb0kvdWorcVFqNUNBajlhUHdZL1dqNWVQcW8rcGo0YVBzSS9PajYrUGdZK0tqNXVQbDQrU2o2T1B1by8xa05LUndwTGRsSUdVdzVTSmtxbVFsNCtKanZTUHJaQ0trSXlQK1kvN2oraVAyNC85a0lXUDFJKzRqK0tQOFkvZmovV1F5cEdOa1lLUTJaQ3drS0dRdDVEVGtQZVJ2Skcxa2JPUnFKRzNrYlNScHBIR2tjT1IyWkgza295U25aS01rZHlSeHBHaGthcVJrcEN6a0lTUDk1Q1prSStQMEkrSGp2eVBuWS9Uajd1UHNJK1dqdm1QZ1krcmo2T080WTdrajYrUHI0K1hqN09QdW8rYWo2eVAwSS9JajZTUG1vK2dqNzJQNDQvSmo4bVB3NCt3ajdLUHBvL0RqK0NQNFkrcmp2U081WTd2ajV1UGpJK0FqdTZPM0k3Z2o2R1BuWStiajQ2T3k0NzBqNnlQd1kvR2o1K1BoNCtlajdhUHRvK0dqNHFQdUkvSGp2YU85WStEajQ2TytZK2JqNzJQa0k3N2pzdU95WSt0ajl5UHBJK2hrSXFSbVpLbWs0bVR3cFNWay9PUnhZK3hqNHFQeUkveWtJQ1AzSStCajZLUWtZLzJqKytRbzVDY2tJaVFrNUNyai82UDFZLzRrSWlRaTVDWmtMMlExSkRUa1lXUmo1R2JrZFNSNTVHNmthbVJ3cEhLa2NXUnJaSEFrb0tTclpLVmtlbVJyWkdoa2F1Umw1REprTHlRblkvdGorQ1AyWS9GajYyUHQ0K3BqNXlQaEk3Tmo0aVB4by9HajZXTy9vN0Zqc1NQbkkrbGo0YVB1SSsyajdLUHBJK05qNWFQdlkveWovYVA2NC8vaithUHc0Ky9qNitQa1krMmo5R1ByWStFajV1UG9ZK1ZqOU9QOUkvYWo3dVB3NCtXajdDUDFJKy9qNmFQcDQrVGo0eVA4WS8xajhXUWlvL3lqL1dRaFkvMWovU1AwNC9Fajd5UGs0K3pqOEtQMTQvSGo1T1BrWSttajVhUGo0K3RqNHlQaDQrNmovNlE3cEtWazd5VXlwV1ZsTXlUaXBEQ2o2V1B1by9zaitLUDdvLzBqLzJQN1kvS2o3R1AxNC81aisyUC9aQ0lrSW1RaUpDb2tLdVA1WS9za002UTM1R0FrWmVRNzVEamtZK1J6cEhDa2FLUm81R3ZrYXVSeXBLbGtwcVIyNUc5a2NHUndKR2trWW1SalpHRWtNQ1FvSS81ajkyUHZZK3NqN1dQdjQrb2o0R08ySTY0ajUrUHdJK2JqdmFPNDQ3cGo2T1BubytLajZHUG1vN2tqNUtQeVkrM2o2YVBxWStpanYyUHJvL1VqN2VQdEkrN2o2V1Btbys4ajhxUG5JK3BqOCtQbkkrQWo2YVB0WStsajR5UHBJL0JqNnFQcm8rcmo1K1BtWS9YaitDUHRZK0tqNCtQeDQvSmo4R1A5NC8vajg2UHZJL2hqK1dQMzQvS2o0dU8ybzdaajUrUHA0K3NqNkdQam8rb2o2eVB5SS9OajlPUXRwSEhrdCtUeEpURWxPeVV3WkxVai8yUGlvK3ZqOGlQMVkrNGorT1FocENHa0p1UCs0L1pqK09QNFkvV2o5MlB5WS9qa0txUXVaQzhrS2lRM3BEb2tQV1E3WkM3a082US9aR1ZrZHVSNFpIUGtiMlIwcEhWa2NLUjBaS0drZTZSdnBHZmthQ1JqSkR2a1BHUXQ1Q1RrSUtQMDQrM2o3bVBwbytKajV5UGtJK0lqNTZQajQrRmo2eVBvWStOajVhUGpvK0ZqdjZQbzQrSWp2S08rSTc2ajRXUHZZKzlqN3FQM0kvSmo2U1BxNCt5ajlxUHo0K1BqNXlQc0krT2o1U1BwbytYajYrUHZJKzhqOGVQMVkrOGo3MlB5by9iaittUDJZKzdqN09Qdm8rZmp1V082STdxajRhUG1ZK0FqNmlQb0krZmo2YVBqWStZajlLUXlKSEprNFNVeEpXV2xhT1QrSkdVajR1TzNvK2NqOWlQMG8rL2orU1A5SS9GajkrUDdJL3VqKzJQOTQvOWovV1A4SS9Zais2UXBwQ3drSk9RaUpEaWthdVJxSkdQa1lxUmxKR1drYWlSdTVHL2tkcVI5cEgya2VxUno1SEdrZFNSdTVIUWtiQ1E5SkRpa01LUWpvL3FqOHlQdEkrK2o4V1ByWStXanZLUHFZKy9qNkdQbW8rTGo1R1BxNCtlajVpUHpJL0lqNTJQaEkrS2o2aVB2WStWajVDUHlZL0xqNnlQcDQrY2o3NlBrSTd2ajlHUDc0L01qOHFQdW8rbmo4R1BqbytMajVxUHk0L1hqdlNQanBDQmovaVA0NC9hajdTUHBZK25qNm1QdEkrVGp2YU8xbzdVajRXUGlvN2Zqc0tPMlkrQ2o0S1Btbzc4anVhUHRaQ1BrUG1SOEpMYmsrQ1U2cFN3a3JtUWlJN1NqdEdQbUkrcGo3cVFnSkNGaitLUDFJL1FqOGVQc0kvaWtMR1F0NURQa0s2UDhZL1ZqL0dRbHBEYmtObVF6SkRja1llUm5aR25rYXVSbXBHV2tiYVI0cEhZa2I2UnhaRzFrYVdSNEpIeGtaYVE0WkRla09xUXJwQ1ZrSnlRZ1kvV2o3U1B2SSttajRxUGpJK0FqNTJQbUkrUGo2R1BsNDcvanVHT3FvNjlqNHFQb28rNmo4NlBzNCtKanYyUGo0K09qNHlQaFkvRWo5V1Bxby9KajdtUHVJL0NqNGlPMUk3MWo1NlBoWStSajhTUHdvL0lqOG1QMm8vWWo4R1BxWS9IaithUDFZL1pqNnlPOTQ3R2p0R08vSStkajdhUHNJK1ZqdTJPNUk3NGo0T08vNCtFanVHUGxKQ0NrTzJSN0pMcGsrMlV3Wk81a2JtUHNZNzlqNzJQeDQvQmo3T1BsSSs3a0o2UWpJL0VqNnFQdUkvSWo3NlA3cENNa0llUXBKQzFrSkNRbkpEUmtOeVEzSkRBa0x1UTBKRGlrTjJSZzVHMGtiK1IxNUgxa2NhUnhwS0xrcFNSNjVIWWtiR1JvWkR6a01LUW9vLy9qK0NQeUkveGtJK1A3WS9CajV5UGlJN3hqdStPM283L2o3V1BpNCtyajcrUHJvKy9qOENQbjQrUGo2S1B1bytOajhPUDZZL25qOW1QMEkvdWo3MlB2SS84ajlxUG5JK3pqOFNQekkvTWorZVA3SS9VajlLUHRJK25qN21Qdm8rbWo4NlArWS92ajcyUG1ZL0RqK3lQd0kvY2tJNlAzNC9XajdDUHJJL2NqK0tQM0kvQWo2cU85STdzajVpUGw0K2JqOGFQdm8ramo4cVA1cENqa2F1UzJwTytsSUtVaFpQZGtzV1AvNCt0ajc2UHZJL2lqLytQKzQvVGo5T1A4WkNBaitHUDVJL3NrSkdRc3BDYmtMaVFycENEa0xhUXlKQy9rTmlRK0pEYmtPQ1J0NUhya2NXUm41R0xrY0NSK3BLbmtwbVI4Wkh1a2UyUi9KSDRrYmVSb0pHWWtZK1E5WkNva0p1UWxZLytrSWFQejQrSWo0Q1BzNCtlajRPUG9JK3dqNWVQaDQrYWo1S1BpNCtRajRhUHFZKzlqNTJQZ1krV2o4Q1AxSSs2ajcrUDFvKzBqNXlQblkra2o4NlA0SSs2ajVlUHM0L3FqOUNQc0krYWo2R1BvSStuajdpUGtvK0lqNnVQcUkrYmo2U1BwNCt1ajhDUDI0L0ZqNStQbm8rNWo2cVB2WS9sajgrUHZJL2JrSW1QNTQvWWorU1AzNC9HajV5UHFvL01qOHFQcFkrVmo0eVBtbytnajVxUHhvLzZqOTZQNVpDdmtaV1N3WlBDaytHVDg1U0lrdmFRNW8vYmorcVFpSkNFa0l5UC80L2NqN2VQeVpDS2tKaVFrcENJait1UDVaQ0VrS21RcDVDcWtNT1E3WkR6a1lPUmhwRG9rUFNScVpHbmtPMlJoSkdqa2I2UnM1SDBrcHlSLzVIeWtkK1JySkd1a2RXUnpwSDZrZjZSeTVEdGtKNlFySkNTajlLUDBJL0tqN2lQeG8vQWo3U1AwNC9Tajh1UDVZL0RqOHlQMjQrM2o2bVBvWS9Dai9DUHk0K1JqdCtQaVkvSmovU1A4WSs2ajYrUDJZLzFqOGFQclkrZmp2YU84NCtPajZTUDFvL1hqN3VQNjQvYWo3V1B1WStTanVpUG40L0pqNmlPOW83cmo0YVBxWStmajZXUGtJK3FqOENQMVkvSWo1S1BrNC9lai9pUDdJL3FqOCtQeEkrK2o2MlBsNCtvai9pUXBJL25qOXVQNFkvbWorK1B1SStTajRlUGxZK2pqNzJQdDQrS2o2ZVBwNCtaaisrUWk0Ly9qL1NRcVpHRmtkS1M5NVMzbGE2VjRaVGdrcEdQNEkrV2o0ZVAxWkNQai82UC9wQ2trS0NQKzQvR2ovR1B0SStwa01hUTE1Q2RrSjZRdEpDVGtJNlAvWS9Ja0pxUm5wRDNrTnVSajVHcGthS1EvcERza1pHU2hKSDNrY0dSdVpHNGtZZVE4NUd0a2NpUm5KR2ZrWUtRLzVEcmtKR1B4WS9EajdxUGlvKzJqNitPOUkrb2o3S1BrSTcwanVHTzZJN3pqNVdQbkk3L2o2T1AzSSt1anZxTzNZN0pqdk9QbTQrK2orYVA0WS9iajZxUGhvNzlqNUtQbG8rd2o1NlB1SS9Xajh1UDBZK3dqdG1QbW8vaWo2V1BrbytEanVPTzZZN1dqdVNQcEkvSmo1eVBpSSt4ajcyUDFZKzdqN1dQdTQrK2o4bVB4NC9JajlHUDVJL09qNVNPOW83OGo0U1B5WS9OajR5TzVJN2lqNHlQcFkvSGo3cVBxWSszajZhUHlwRFBrZjJUdUpTZ2xLQ1M3NURoajVtUGdZL0VqOFdQdEkvdmovQ1A3WkNUaittUHJvKzlqOVNQelkrdGo4bVFpSS90a0xHUXZKQ0prS2lRejVHQ2tQV1EwcER6a1BXUS9aR1ZrWTJSajVHY2tZS1JtcEhra2VhUjZwSExrWW1RdzVENmtkMlJ0SkRFa01hUTU1RGNrS0tQM1krWmo2R1AwbytaajZLUHZZK3pqNVNQalkrRGo0R1BrWStRajVXUHhJK3FqdmFQaFkrT2o2MlB4bysyajhpUDFZL0hqOTJQelkrZmo1MlBoNCtLajVDTy80NzRqK1NQN1krOGo3bVAyby9pajYrTzVZNytqOHlQdkkrOGo3MlB1NCsxajZhUG9JL01qNnlQcVkvQmo2dVAxSS9ZajhtUDNJLzFqN1NQclkvSWo5U1FrSS9jajhpUWhaQ1BrSlNRbEpDQ2tJdVA4NC9IajVPUHBZKzFqNjZQeW8vQWo2S1BqWStSajcrUHdZL1NrSk9RMlpIR2t1YVR6NVNnbFBDVXNKSzdrS2FQdUkrMWo3aVB6cENma0pxUDZwQ0prS3VQL0pDUmtMYVFxSkNua0o2UWhvL3FqOW1Rb1pEeWtOK1F3SkRua091Umk1R3lrWnFSc3BHOGtabVJ1NUhua2RDUjNaSFhrYytScEpIbWtvZVNnNUg1a2FHUS81R1JrWTJRODVEMGtNMlFwcENSajhHUGxvK3dqOUNQdm8rSGo0ZVBpSStuajUyTzdZKzlqOWFQcm83K2o4aVA0byt3ajZ5UHZvKzdqNjZQcEkrNmovcVFoby96ajdpUG80KzFqN3VQMFkvaGo4dVBzNCtyajZLUDFZL3dqK0tQNW8veGo5cVB2NC9DajQyTytJK3NqN2VQeDQvT2o3cU8vNDc5ajlLUHo0L2JrSmFQN0kvRGo5K1FwSkNQa0lTUDlvL3VqK1NQN1kvN2tJeVB6WStRajZ1UDBJKzlqNXFQbW8vY2o4YVB5bysyajR5UHRvL29qK2lRb1pEMmtwcVQyNVNNbE51VXZKS2NqKzZPMlk3N2o3V1BvbytvajZ5UGlJK1dqOU9QeG8rZmo0T1ByNC9CajdTUHpJL3JqNjZQaTQvWGtLaVFpWS9Nait5UXNwRE1rTFNRMVpEMWtOT1F4NURZa05TUStwR2lrWnlRN1pEb2tQcVE4cEQ5a051UXlKQytrS1dRa28va2o5T1AyWS9VajhPUGxvN3NqdWVQeFkrN2o0bVBoWTd0anZlTzQ0NjhqdmVQakk3Z2p1Q1B0NCt6ajZPUHlJL0xqN2lQb283emp0MlBvWS9WajVHTy9ZK2tqNkNQeUkrdGo0NlBqbzcyajRpUHpvKzJqNitQaW8rR2o3T1A1WS9TajZPUHVJL3VqK3VQd28rdmo3bVB3by9Iajh1UDE0L2hqL2VQLzVDRGtJbVA2NC9KajlPUHA0NzBqNFNQdEkrbGo1NlBnbzdOajRxUHRJK0pqNDJQdkkvc2tJYVAzcENza2NhU3ZwUEFsSWVVbHBPb2tjK1B6NCtNajdXUDVJLzNqOXVQMnBDQWtJbVA1by9FajhtUWdKRERrS3lRb1pDYWtKaVFxWkRia09lUXNwREZrT2VSZ3BEemtQV1JsSkc4a2RlUjRaSHVrZStSelpIVmtjV1J2cEgwa2ZhUjFKSENrZHVSeFpHNWthV1JpWkRwa0xpUDdvK3NqNlNQM28vVmo2aVBvbyt2ajgrUHQ0KzBqNUdQbFkrY2o1aVBnSStrajlPUHpvL0FqNVNQdW8rMmo0T1Bwbyt4ajZ1UDBvK29qNk9Qc1krZGo3cVB1bytnajQrUG5vL0FqN3lQdG8raWp1MlBobytVajVpUHFvK09qNEtQaEk3N2o2T1B4byt4ajhtUHZZK1NqNlNQdW8vQWo5R1BxWTc4anVpUGpZKzFqNm1QblkrOGo3aVBwNCtjajR5UGhJN3lqdWVPM28rTGo1Q1BtNCtTajc2UXhwSHdrNGFUNjVTNmxMS1M2NUNyajRtUGlvL0lqK0tQdVkrN2o4bVB3WStxajdHUHlZLzRqKytQem8vT2tJQ1FzSkNNa0ltUWw1Q0VrS2VRdXBDMmtQcVJnNURxa1BxUm81RzJrYmFSdXBIQ2tjZVJ2NUhka29LUjBKSE1rZUNSMEpIM2tmS1J6SkdKa1BDUTE1REJrS1dQNVkvU2o4ZVB1WStoanZxUHFvL0NqNmlQd28rMWo1ZVB1WS9WajdXUGpZK0xqNk9QdVkrdGo2K1BvWS9Eai8rUWdJL0VqN2lQMEkvc2ovV1B3SStKajQ2UHY0L0hqN09Qd28rL2o4YVB4SStpajRHUHFvL01qOGFQdVkrcWo2S1BuSSsyajZPUGg0K3ZqOW1QM0krN2o5bVA5NC9yai9xUC9ZL1RqNnFQcW8reWo3YVBuWTcwajRxUGpZK3FqNzJQcTQrSGp1eVBvbys3ajVhTzQ0K1FrSVdSaEpLaGs3YVVuNVR2bGFHVHZKQ3BqdXlQa28vTGovT1A2WSt6ajVHUHJJL0FqNzJQMm8vWGo2dVA3WkNaaitPUCs1Q3BqK3FQMVpDdmtMR1FrSkM5a015UmhKR2JrUGVRNEpHRWthR1J1cEcza2FHUnRaSE9rY2FSdHBHN2tjcVJ6Wkdwa1B1UmlwRHlrTWFRNXBETGovK1B3NCszajc2UHZZK0tqdVdPOFkrK2oraVB6WSs0ajZDTzhvK0hqOFdQM28rdGo2cVBxNCtnajRxUHZJL3JqL2VQMjQrNmo3aVB4WS9DaitXUDRvK3NqNCtQdG8rMGo2Q1AzSS9pajdhUGxvK2RqOFdQMlkvQWo3K1BxNCtkajdhUDJvL1lqOUtQdW8rY2o2aVBsbys2ajlpUHc0L0hqL1NRZ1kvZ2orbVA0SS90aisrUDBZL2lqK09QelkvSWo4dVBxWStxaitDUDZvL09qNTZQbVkvYmo5cVAxSkNaa05HU2paU1lsWTJWd3BYWWxJYVJ1SS9pajZTUDA1Q0lrSitQLzQvc2orYVA2WS9wajlLUW5KQ2VrS0tRaFkveWovNlFzWkRBa0srUXNwQ01rSmFRMDVEZmtQbVJpcEdGa1lLUm01R2drYWVTaFpLSWtkeVI5Wkhla1l5Umk1SEprZCtSejVHQWtLZVF3SkM1a0t5UXA1Q0FqKzZQeUkrWWo1eVBtby9laitPUG40NzZqdE9PODQ3eWp2K1BxNCtSanVXTytZKzBqN09PL28rQ2o2YVBybyttajdDUHBJK09qNXlQdW8rVWp2U1BnNCtrajVXUHA0K3JqdldQalkvR2o1Mk8yNDdZajZhUDBvKzVqNWFQa0krWGo1cU8vWTdwajd5UHVZK09qNWlQclkvRWo5S1FqWkNKajlpUHVZNzJqc2VQbTQvRmo3aVB1WSthanM2TzQ0K2VqNk9QcUkvU2o3Q084NDdqajhLUXFKR0drZktTMXBQUmxOdVV6cEsvai9xUG1ZL0pqOStQOVkvTWo3K1AwNC9MaisyUDhvL3VrSWVQL1pDQWoveVA2SS8wa0lDUW1wQy9rTWlRMFpER2tONlF1WkRqa2JTUnM1SGZrZktSejVISGtjeVJxSkc1a2VhUi9KSGhrYjJSeDVIU2tjU1JrNURoa00rUTJwQzdrSktRa3BDTWo5Q1Bzbys3ajdDTzk0N2lqNFdQMG8vbmo3YVBxbyt5ajdDUG9vK2ZqNUdQejQvb2orR1A4by8xajd5UHFvK1VqN0tQeUkvRGo2YVBvbysyajlTUHlZKzFqOHlQem8vVWo4aVBrSTcvajZDUHZZL0pqN21QajQramo3cVBrNDdjajRpUDFJL0JqNnFQbTQrMWo1K084WSttajd5UHFvL2RqOE9QdEkvbWorK1A5by9yajlhUHk0K3NqNTZQblkrUmo0NlBtWSs5ajhlUHBJK3FqNU9POFkrYmoraVF4Skhia3ZXVWpwV25sYjZVZ3BHMWo3bVBxNC9pa0xtUXZKQ1lrSTJRalkvM2ovU1FpNC85a0tDUTZaRE1rTGVRdnBERmtLT1FzSkRha05hUXc1RHprWldRNlpHdGtkZVJ2cEhOa2NlUjNwS3VrcDJSNkpLaGtwYVI4cEtva3JXU2xwSDNrYjZSazVEL2tQS1F3NURHa01XUXZaQ2dqOUtQMEkvUGo2ZU84WTc3ajUrUHlJKy9qNTJPLzQrSmo2MlBrSStQajhPUHU0K3hqOUNQNkkvbWo5aVAySS9UajVhUG5JK2tqN1dQdkkvQ2o4dVB5NC9sajg2UHJJL1BqKzZQNlkvcGo5Q1B0WS9NajgrUHVvK2RqNXVQLzQvd2o5bVA1by9BajhxUDNvL1RqOEtQdjQramo0Q1BrNC9TaitXUC9ZLzBqOTZQMVkvS2o1K1B6NUNia0lXUDlZL25qOFNQZ0krNmtKT1A2SSs1ajVHTzlvK05qNlNQcVkrRmp0U094bzdnanRlUGlZL3lrTGlRL3BIWGt0R1QycFM4bE5lVHE1RFpqdm1POEkrTWorR1A5SS9hajlpUDBZL1lrSVdRam8veWtJcVFtby96ais2UWtKQy9rUFdRNkpDNWtLNlF3NUNua0ppUTdKRzVrYldScXBHaGtaMlJ1cEhka2NHUnpKSGVrY21ScHBIT2tkR1JvSkQxa095UTZwRFFrS21RazVDQWovZVAzWS9LajVlUGg0N1lqcitPMjQ2aGpyV08zSStCajVpUGpJK2JqNktPK1k3dmo3Q1B4NC9jais2UHRvK3NqN2lQcTQrb2o4bVA0by80ai82UDFvL2NqN2lQcEkvQ2o4dVBzSStOajVtUDRvL1NqditQaTQvVWo3cVA0by9wajcrUHFJNzNqdm1QZzQ3L2p2Mk8zbzdianQ2T3pJN01qNE9QelkvVWo5K1A3SS9raittUHpvK0FqN2FQOW8vUWo2T1BrbysxajdXUHBJK1FqNHFQdVkvTmo2NlBwWkNGa1ltU3BwUFBsTCtVNkpTMGt1V1EyWS9Uajd5UHNvL21rSlNRZ0pDTGtLeVFwWkNYa0lxUXBwQ2RrSStRc1pDMGtOV1EzcEM3a05PUTY1R0trWVNRK3BEMGtZNlJuWkdoa2JpUno1SFFrY09Sa3BHdWtjbVJ2Skd2a2JPUnI1SEZrYmFRK0pEQmtKMlFoWkNIa0lxUDRJK3pqN09Qc28rYWp2aU8xbzY0anRHT3ZJN1RqdmFPeUk3bGo1dVBrWTc2anVhTzA0N0pqcmFPNUk3YWp1YVBwbytianZxTzNvN21qdktPOW83dWp2ZU83WTdrajRPTzlZN2lqNEdQa1k3L2p0Mk96STdCanN5T3RJNjRqdCtPN28rRWp2bU82NCtEajRPTzhJNzRqdnFPOUkrUmp2ZU8zSStkaitxUDNJK2RqNkdQZzQ3VGpzbU83bytLajUrUHZZL2RqN0tQb1kvYmovQ1B5byt5ajZhUGxJKzRqNmVQbkkrVGo0S1B2SS9vajc2UGpZNzZqNkNQd1krL2o2T1BtWS9Pa0tDUno1TGhrOG1VeEpTems0S1E3SS9JajhTUDdKQ1RrTFNRcDQvL2oreVFoNUM5a01HUXpaRFZrTGlRbVpDcWtPcVJqcEQra09lUTZaR1BrZFdSelpHaWtaNlJzNUhIa2NPUnlaS21rdU9TMlpLZGtwT1NwNUsza3BtU2hKS01rZitSOVpIeGtkNlJ3WkhHa2F5UTc1RENrSUtQNTVDTWtNZVF3by9xajlXUDM0L3NrSW1RZzQrM2o1dVA2WkNTai9XUDg0LzlqL3lQOHBDRWovbVA1by9uait1UDlZL3NqK0NQNEkvU2o2aVBzWS9MajhXUHBJK1ZqNmlQMTQvRWo1R1BnNC9IaithUHhJK2tqN3VQNDQvVmo3YVByNC9OajlDUHRJK0xqdE9PKzQvSGo3MlByWStnajZLUGpvK2pqOTZQMEkrTWo1aVAxWS9QajZLUG5JKytqNVNPNjQ3aGp2cU8vNCtDanZ5TzM0NjdqdFNPNVk3b2o1R1AxcEdCa3NXVDVwVFFsUE9UN3BITmorV1BxSSs2a0kyUWtvL2lqL0dRaUkvdWo5S1AzWS9tajkrUDU0L3RqL0tQK1kvVGo3NlAxSkNRa01HUXNwQ2FrSXlRd1pESGtPbVJsSkdCa09tUS9KRCtrWk9ScVpHZ2thdVJxNUdQa1lxUnQ1RzFrWU9RL0pEYmtMQ1FwNUNva0llUDRJK3hqNWVPOEk3Z2p2dU81NDcvanYyUGpvK01qdnVPOFk3dWp2V081bzdsanZLT3lvN0RqNFdPNm8rb2o5MlAwNC9CajZxUGxJNzNqdmlQaG8rUmp2aVBnbytkajZxUHBvK3RqNGFPK28rb2o3bVBtSTdjanVtTzRvN2pqNGlQbDQ3Nmo0T1B2byswajgyUDlZL3lqOWFQekpDSmtKNlFrSkNya01XUXZKQ3prSXFQK0pDT2tKT1FpWkNJaisrUDhZL1pqOW1RbUpDcmtKaVAwSSsrajhLUHZvLzhrSUtRa1pEb2tjU1M2NVNKbE95VXpKTDJrUE9Qd1krY2o0eVBzWkNEajlhUHFvL0tqOU9QdW8vQmorQ1A0NC9wajlpUHlJL1BqOW1QN0kvbWorMlFvNUM2ai9TUW1KREtrWXVSZ1pENGtQT1JocEc4a2I2Unc1RzdrY1NScUpHVGtZbVJuNUdXa1lLUmg1RHRrTUdRaUkvOWorU1B4bytranRDT3JZN2VqdTZQazQrRGp1dU82NDdpanVXTzVZNnZqZnlPd1k3OGp2U081WTdzajZTUHQ0L09qK21QMVkrOWo3YVB1SS9JaitLUHc0L05qK2lQMW8raGo0MlBobytCanZhUGhvNzdqdnlQbUkrQ2p0Mk8ySStVajYrUDJKQ0ZqOXFQcG8rNmo3T1BvSSsyajZTUGpJK2FqNE9QdjVDQWovU1FoNUNva0oyUW9wQ0ZqKzZRaEpDY2tJK1A3WkNLa0t1UW1vL09qNDJQdlkvWmorS1FsNC8rajhLUDVvL3pqL3FRblpEZWtiYVM1WlNMbFBHVm81V3JrK1dSazQvaGo4dVA3SkM0a05TUXVKQ3hrS0tRb1pDbmtLdVEwNUNraitDUWw1RExrSytRcFpDZmtJS1FzSkRoa1lHUTdKRGFrT21SZ3BENmtZeVJ0NUhaa2VlU2pKS1ZrcHFTbFpIOGtlbVJzcEd4a2NhUnM1R09rT0tRMUpEb2tOR1Fuby8rai95UWdKQ0NqK2VQdEkvRWo4T1B4WS9Kajc2UHlJK21qdjJPMVk3TGp2NlBqNDczajdDUDNZL05qN0dQeFkrWmo1K1B0WSt5ajk2UDNZL2NqOUdQckkrbWo3dVBzSS9GaitpUHc0KzRqNldQcDQvQmo3aVBzSStuajZPUHFvL0ZqOCtQcjQvS2orV1B0bytLajdPUHU0K0pqN0dRZ28vUmo2dVBxby9Gai9lUDhZL0lqNXlQbUkvVmorbVA4NC9ZajhLUDJJLzZrSldQL0kvdWorK1A2NC9XaitxUC9ZK3RqNmVQMVkvUGo5dVAwbys1ajdPUHdvL1JqK0dQcUkrTmo4R1F0NUd6a3FlVDJwV0FsZXlWMFpQR2tPT1BwSStka0p5UTFwQ2xrSU9QOFpDQmtKMlFvcENFa0pDUXNwQ3hrSldRaTVDQWtKaVE1cER1a09LUXg1Qy9rT0NSaVpHTWthMlJ1Wkcwa2JHUjFwSGJrYkdSK1pLNWtwV1NoNUhza2NXUjRaSHZrZkNTbTVLQ2tjcVJnNURLa0t1UC80LzFqK1NQem8rdGo1Q1BxSSthajdpUHdZK2RqOHFQN0kvRGp2eVBwby8wai9DUHdvL1VqOHlQdjQrbmp1ZU81NCt4ajcrUHRvK1VqNldQem8vRWo3Q1B2SS9qajg2UHA0L0VqK09QNDQvVWo3cVB3bytnanZlUG1vKzJqOHlQdDQrUWp2K08rNDdwanVTTzVJN2RqdHlPN1k3MGo2bVBnWTdIanRTUG1ZK1VqNENPOFk3M2o1NlBuWStxajVtUGlZK3FqOENQdjQraWo1U1BqbythajlTUHY0K1FqdnlQdW8vRmo1R090NDdyanY2Ty9vN3pqdEtPeTQ3WWp2R084NCsyai8yUXM1SGtrNUtUKzVUcGxNU1N5NUNWanR5T3BZNi9qN2lQL28vSmo0YU8rNDcyajRhUHpvKzRqNmFQelkvK2o5dVB3WS8yai9xUWxaQzlrSkNQN3BDTGtKU1FuNURUa05tUTJwRHdrWXFSa1pHVGtaK1JySkhLa2ZhUi81SFNrYitSeDVHaGtZNlJnSkRQa0wrUXZwQ2RqL0NQMVpDaGtMZVAvSSsxajZPUHdvL2pqK0tQcjQrc2o1bVBsSStJajhhUDdZK3BqNHVQa0krY2o1dVBySS9EajhlUHVZKy9qN3VQdzQvR2o5cVFnby92ajhpUHdZKzdqNmlQdkkvRGo2ZVBuSSs0ajltUDhJL3dqKytQeUkrcWo2R1BqWStYajZpUHZZL1ZqNDZQalkvWGo5K1AwWS9Iai9PUWxwQ2JqL0dQN0pDS2ovK1A5WkNMa0lXUWpJL1dqNUNQckkvaWo2bVBuWSs0ajhxUHlZL0ZqNitQcW8rNmo2cVBnWStXajllUWxKR3ZrdE9UM0pUd2xhQ1VqWkhza0lLUDBZLzJrSjZRakkvOWo4K1A2WS8vai9pUDA0L3BrTGVRczVDWWtKS1FtWkNla0tTUTFKRGRrUFdSazVHU2tQK1E5SkRsa1pPUmw1R0ZrYStSeUpIcmtmT1J4NUhDa2VPUjhaSGVrY2FSckpHUGtZR1JoWkR4a0oyUWtKQ1FqK0tQdEkrOWo4MlB2NCs2ajdPUGdJN2pqdmVPNkk3Nmo0eVByWSs0ajUyUGtvK2FqNTJQakkrS2o1cVBqbytqajZTUHFJKzhqOG1QczQvT2orQ1Axby9YajlLUHBvL0tqL09QOVkvdWo2V08yNCtRajlPUHQ0K0lqdmVQaFk3emp2R1BqWStYajRhUGlJNzRqdGVPMW83aGp1ZU95bzdUanZlTzBvN1JqdkdQaTQrTWp1K084bzdaanMrTzBJN2ZqdHlPMFk3cWo0bVBuSSsxajlXUDlJL3dqOVNQdG8rL2o4MlAxNC9na0lPUWtvLzBqOEtQem8rL2o4T1Azby9sajlTUHVZK0xqNEtQK0pDYWordVArNUM1a1pPU2pKT0RrL3VWbFpYZmxKR1J0SS9FajQ2UG40L0ZqOFdQMFkvVGo5K1AxNCtmajZDUDA0L0FqOTJRckpDZWtKaVFtWkNUa0tDUXQ1RCtrWXlRNDVEbGtQV1EvSkdRa2JXUnNaR3ZrY1NSNFpIZmtlYVNpNUtPa3BPU21aS1Brb09SM0pIQWthaVE4WkRxa05hUXpwRFVrS0dQODQvY2o4eVAxSStqajZpUDRZL2dqNitQbUkrZGo3R1B3NCt1ajVHUG9ZL0xqOXVQNlkrOGo3R1B4WS9BajZ1UHVvKzJqN1NQMjQvemo4NlBuNC9pajlDUHdJL0pqNzZQelkvRGo3bVB1bysrajdDUHA0K09qNGFQcVkvT2o4cVBvSS9ma0lpUDFZL0NqOHlQeDQrd2o2U1Bubys2ajhDUDI0L25qNzZQdm8vTGo2Q1BvWSt4ajhLUDQ0L2xqNzZQdjQvTmo5K1AwNC9oajllUHZJL2RqK0dQMFkvZGo4ZVAySS95ajhtUHlJLzVqL3FQeVkremo4YVB1by94ajlxUHBZKzBqNzZQakkrVGo2V1Bzby90ais2UDlaRGhrb1NUdFpTL2xhYVZ3NVRIa3BLUXFZL3RqLzJRdVpDdmtJR1A0WS9laitXUHo0L2pqL3VRa1pDcmtMcVFvWkNva01hUXRaQ21rTEdRM3BEcmtPR1E2NUdCa1lXUmdwRzlrZG1SeUpHNGtjQ1IxcEh4a2ZHUjlaS09rZWFSeVpIV2tjV1J6WkhYa2NTUm5KRHRrTUNQKzQvV2ordVAxWSs2ajZDUGtZK0hqNGVPOW8rU2o3bVAySS9WajY2UGxJK2JqNDZQazQraGp2dU84byt0ajhhUHQ0K2VqNCtQcUkvT2o2bVBybyt6ajZDUGpJK2ZqN3lQdTQraGo1V1BrbytkajQyUGtvK3FqOGFQcFk3dmp1V1BoWStsajdhUG5vK1dqNWFPKzQ3L2p1dVBrSS9Bajh5UHdvK3ZqNTZPK283d2o0YVBpWStXajhHUDBZK3pqNHlPN0krRWo1V1BtWStwajdDUHpJKzZqNnVQdm8vYmtLS1FtSS95ajkrUDdvL2RqNjZQMDQvV2o4YVB4bys4ajgrUG80K29qN1NQcFkvSGorU1B1SStkajhlUWpaRDhrZEtTeEpQZmxNV1U3WlNKa2ZhUWlZKzJqOWFRbFpDUWorT1A4cENpai9DUHY0L2xrS2FRcEpDdGtKQ1FncENZa0tpUXo1Q21rS09ReUpEamtQV1JoNUdPa1pHUmtKR0xrYUtSdEpIWmtkV1IzcEh0a2V1UjlwSHhrb2FTbnBLemtveVIySkd3a2JhUnBaRGtrSjJRbW8vaWo4U1A5SkNEa0lhUDI0K3pqNVdQZ28rUGo2R1B1WSt4ajdpUGtZK0hqNitQeDQvY2o4dVBwbytUajVXUHdvLzNqOHlQblkrbGo4K1B3WS9JaitpUDBJKzZqNitQdTQvQWo3eVB5SS9TaitHUWlJL3RqN3VQcUkrdWo3dVB3bytvajZ5UHJJK3pqN21QdEkreGo1eVB3WS9uait5UDNJL2JqK2FQdEkrcGo4U1B6SS9JajhPUDBJKzVqNWVQb1krSWo2R1Ayby9BajlXUDJwQ1VqL0tQdUkrK2o3NlB5WSt1ajQrUHBZL0tqNzJQdm8vbWorbVAxWS9oai9DUDVZL3BqK2VQNm8vOGtKV1FuSS90ajh5UHQ0L2JqL0NQK0kvcmo5Q1AwNC92aitLUHpJL1hqK3VQNjQvSGo3YVB5NC9sai82UW5aREhrYXlTdXBPamxNK1Z6WldzazZpUTBJK21qOG1RcjVERGtJK1A2cENGa0pLUXNwREZqL09QMzVDTGtKNlFxby84aisyUDU0LzdrTGFRMkpENGtZZVJoSkdEa1AyUStwR2JrYVNRKzVEM2thYVI3Wkhna2NTUnlaSGtrZmVSOFpIWmtiZVJ0WkhJa1pTUXpwQytrUDZRODVDVWorQ1A2NC9OajRhTzVvNy9qNW1QajQ3Wmp1V084WTdQanFhT3A0NjNqdXlPNTQ3cGpyK09zbzdmanR5TzlZK1RqdldPNEk3Ymp1K08rSTduanVhUGo0K2JqNEtPNlkrRGo1K1BsbytLajVLUHVZL1lqOGVQckkrc2o1ZVBvWSsrajhTUDJZL2tqOWFQeW8vQ2o4ZVAzWS9YajgyUDJJL2lqOEdQMlkvdWo4MlB2NC9VaitXUDhKQ0FqL3FQMUkvamordVAzcENUa0pxUDVvL0xqNW1QbTQrdmo0MlBoSSs4ajlDUDNZKzlqOHVQeG8rL2oreVA1by9yajYyUGo0K2pqN3FQckkrTWp2V083bytaajdTUGlJN0hqc09POW8rQmo2U1Bzby9Ka0lpUXo1RzZrc0tUNjVUaWxhNlV1cEtka0krUHBZL0FqL2lQL0kvV2o5S1A4cERMa05lUXdaQ3prSVdRbDVDNWtNaVFtWkNka0xxUTVwRDhrTzJRK3BHR2tZU1JnNUQ4a1lhUnVKSGJrZHVSMXBIRmtlR1I2Skgza3BlU3A1S0drZVdSOHBIOGtkZVJ4Skdva1BPUTRwRE9rTW1RdkpDTmo4NlAzSStvajZHUHZZK2tqN0tQaTQ3ZWo2T1A2WS9MajQyUG5JKzhqN3FQcDQrc2o2ZVBsNCtmajZLUG1vK3FqNjZQbm8rY2o3R1B2WS9HajdpUHJvK3VqNGFQa1krdGo3ZVB5WS9GajllUHdZKzVqOUtQMTQrOWo2S1Bxby9Jai9tUCtvL0RqNitQbzQra2o4V1Azby9XajllUDdJL25qOHVQdkkvUWo5cVAyWStGanZXUGlZKzJqN0dQa1krUmo1dVBuNCtmanYyTzZJK0FqdktPelk3UWp2YVBpWSthajdxUG80N21qdHFQbG8rZGp1YU85SStLajVTUHI1Q0FrSk9QL0kvbGo4eVAxby91ai9PUHU0K3lqNnlQcG8rN2o0cVB0SS9MajdLUHc0L1FqNytQd1kvYWtLeVJ4SkxIaytPVTZwWE5sYW1UcXBEZWo4aVA0WkNQa0ppUWtZLzVrSkNQLzQvR2o4V1ArcEN6a0xlUWlaQ0drTE9Rc0pDQWovcVFvSkRBa0w2UTFaR2FrWmlSbjVHYmtQR1JtSkhFa2NxUnpwSFBrZGFSMHBIMWtmMlI1NUh5a2QrUnlaSGFrYytSdXBHWmtOK1F6WkRCa0wyUXFJL3NqOVNQdVkvUmo4U1BvSSs1ajgrUHVZK1FqNW1QazQrc2o2R1B1by9TajgrUHlZK2tqNFNQd0kvYWorYVA4by9UajllUDM0L2RqODZQelkvS2orQ1Azby9jajdXUHpKQ0FrSU9QNG8vaGo3bVAxSS81ajl5UDhZLy9qK3VQMTQvRmo3dVAyNC8vajlPUG9JL0RqL3lQNlkvcWorZVB5SS9Za0lDUHZZK1BqNDZQZzQrbWoraVA0by9SajZlTzRvN3BqNldQbDQ3WWo1R1BuNCtNanZPUGpZK3NqNG1QaTQrYWo1aVBtSStzajdtUHQ0KzFqOVdQNjQvbmo5MlA0SS90ai8yUDc0L2ZqOXVQcFkrZmo2K1B5SS9QaisrUDU0KzdqN2VQMkkvOGtJQ1F0NUdwa3FPVG5wU3psYlNWdVpQbmtZdVB1bytvajhLUDhwQ29rTFdQOFkvaWtKR1FnNUNIa0ppUCs1Q1FrS3FRcjVDMmtNdVF1WkRla1lxUThKRHJrT1dROHBHU2taaVJsWkcza2MyUjU1SGVrZWVSNkpIeWtlZVJ5Wkcza2I2UndwRzJrYnlSeFpHc2tQNlF5WkN1a0l5UCtJL2RqNVNQb0kvQmo2dVBpWTc4anUrTytvK2ZqNWVQZzQrQWo0NlB2NC9HajVpUG5ZL0VqOGlQdkkrbWo2NlBzbys4ajhlUHc0KzVqOCtQejQrbmo0dU84bzcwajVXUG5vNzRqNTJQdUkrY2o0U08vWStIanY2UGlZK1pqNnVQZ0k3aWp1bVBqWSttajVPTy9ZK0tqNFNQcDQrd2o0aVBqSStUajZtUHJJKzlqOHlQMkkvaGorQ1A4SS9SajdpUHY1Q0ZrTGVRczVDTmorV1A1WS8zajl1UHE0L0xqNjJQcW8vcGovQ1Awby9JajdxUHM0L0xqOUNQdDQvY2ovMlA5NC94aitLUDFvL01qOWVQd1krdmo3cVBzNCtWajRlUHJJK2ZqNFdQbFkrTGo1K1BuNCtCajVTUHk0L2RrTHFSejVMRGsrcVU0cFRtazdxUmdvKzVqNEdQa1krM2o5R1B3NC9NaithUDA0L29qKzZQcTQrNGovQ1AwNC9NajlpUDY1Q0prSUtQNm8vcWoveVFtWkMya0orUWtaRGhrWmlSbFpHRGtQZVE0WkRva1o2UnFwR2hrYWVSbXBHWmtacVJpWkdia1BXUTdaQzFrSXlRcFpDQ2o3aVB0WSs5ajZlUHBvK2pqNmFQbzQrWmo2aVB6WS9tajltUDVJL01qODJQOUkvdmo5ZVA3WkNPai9HUHo0LytrSkdRaUpDYmtKZVFrWS8vai82UXFaQzRrTVNReUpDWGtJV1FuWkNLai9PUDc1Q2JrS2VQNkkveGtKR1A3WS9vajhLUHBZK3ZqOCtQam8rRGo2V1B0byt1ajVxUHI0KzJqN1dQa0k3NWo2T1B2SStwajVHTzg0K2FqOHVQdDQrZ2o2YVBrbytuajhTUG1ZK3FqK2lQMW8vSWorZVFnNUNJai91UDBvL0hqL0dRZ0pDU2ovcVFsWkN5a0pDUWdaQ1JrSnlQMDQvSmtKYVFqSS9tajhLUHVZL3JqK3VQOVkvZGo5cVFpWkM0a1BxUng1TFRrLytVNFpXZ2xZV1RnSkRoa0tlUXNwQ3ZrSnFRbTVDNGtLcVFqWkNxa01DUWo0L2xqK2FRbzVEU2tMdVF1cERna09DUXlwREdrTmVROXBEL2tQU1EzSkRKa01tUStwR1hrWkdScUpHR2tOMlJyWkh6a2NlUnU1SEZrYStRL1pEZ2tadVJ1WkdSa0w2UW5aQzBrS2FQNm8vZ2oveVA3WS9najhXUHBvK2FqNjZQeEkvZGo4aVB6by9FajZpUGw0K0tqN3FQM28rbmo2YVB3byt2ajhlUDRZL0FqOENQeFkrdWo0cVBoWStxajZ5TytvN1NqdXVQa28rQ2o1V1BsWStMajRpUGpvK2RqNXVQazQrR2p2Nk8ybzdUanZDUHA0K1lqdWFPMW83eGo2T1B5by9UajdXUHJJK2NqNDJQbm8raGo2T1B0by9CajZtUG1JK1FqNEtQaDQrT2o0MlBqNCtWajQyUGtZNy9qdnVQcW8rNGo3YVBySSs1ajlDUHI0KzdqN2FQaFkrc2o3U1BySSs1ajRlUGhZK2lqN1NQalkrVmo5R1AxSSsvajVDUHZvL05qOEtRaHBEbGthNlNzWlBZbFBDVm9wV2drK0tSaTQvQ2o4R1AvWkN0a0orUWhaQ1drTUNRdnBDeWtKV1FxSkRCa05lUTVaQ3prTEtRMVpEWWtObVE4cEdHa1A2Um1aSERrYzJSMXBIWmtjcVJ4SkhQa2VlUjZwS09rcStTbHBLM2t0R1NuWktXa29PUjhKS0hrb1dSMUpHVGtOMlExSkR1a051UXQ1Q2FqK1dQd0kvTGo4cVAwby9Uajh1UHg0KzlqN2FQbDQrWGo4MlFnSkNBa0lTUDZZKzhqN3VQNW8vY2orYVA1by9Wai9hUWhwQ1NrSmFQMFkrcg=='
        }
      ]

    Laniakea.Collection.HealthRecords.insert(h)

if Meteor.isServer
  Meteor.methods

#  添加体重方法
    'addweight':(healthrecordId,wt)->
      if Meteor.user()?
        unless  wt || healthrecordId
          throw new Meteor.Error("undefinded-error", "healthrecordId or wt is not definded");
        unless  typeof(wt) is 'object'
          throw new Meteor.Error("not-object", "params wt is not a object");
        else
          unless wt.t
            wt.t = new Date()
          tips = {}
          userHR = Laniakea.Collection.HealthRecords.findOne(healthrecordId)
          unless userHR
            tips = Laniakea.Collection.HealthRecords.insert({_id:healthrecordId ,wt:[wt],ld:{wt:wt}})
          else         
            tips = Laniakea.Collection.HealthRecords.update healthrecordId,
                {
                    $push:{
                      wt:{
                        $each:[wt],
                        $slice: -10
                      }
                    },
                    $set:{'ld.wt':wt}
                  }

          Laniakea.Collection.Weights.insert({u:healthrecordId ,t:wt.t, v:wt.v})

          return tips
      else
        throw new Meteor.Error("401", "not authed service");
#添加运动方法
    'addactivity':(healthrecordId,activity)->
      if Meteor.user()?
        unless  activity || healthrecordId
          throw new Meteor.Error("undefinded-error", "healthrecordId or activity is not definded");
        unless  typeof(activity) is 'object'
          throw new Meteor.Error("not-object", "activity is not a object");
        else
          unless activity.t
            activity.t = new Date()
          unless  activity.step
            return
          tips = {}
          userHR = Laniakea.Collection.HealthRecords.findOne(healthrecordId)
          unless userHR
            tips = Laniakea.Collection.HealthRecords.insert({_id:healthrecordId ,ac:[activity],ld:{ac:activity}})
          else
#            tips = Laniakea.Collection.HealthRecords.update healthrecordId,{$push:{ac:activity},$set:{'ld.ac':activity}}
             tips = Laniakea.Collection.HealthRecords.update healthrecordId,
                {
                  $push:{
                    ac:{
                      $each:[activity],
                      $slice: -10
                    }
                  },
                  $set:{'ld.ac':activity}
                }
          Laniakea.Collection.Activitys.insert({u:healthrecordId ,t:activity.t, step:activity.step})
          return tips
      else
        throw new Meteor.Error("401", "not authed service");
#添加血压
    'addbp':(healthrecordId,bp)->
      if Meteor.user()?
        unless  bp || healthrecordId
          throw new Meteor.Error("undefinded-error", "healthrecordId or activity is not definded");
        unless  typeof(bp) is 'object'
          throw new Meteor.Error("not-object", "bp is not a object");
        else
          unless bp.t
            bp.t = new Date()
          tips = {}
          userHR = Laniakea.Collection.HealthRecords.findOne(healthrecordId)
          unless userHR
            tips = Laniakea.Collection.HealthRecords.insert({_id:healthrecordId ,bp:[bp],ld:{bp:bp}})
          else          
            tips = Laniakea.Collection.HealthRecords.update healthrecordId,
                {
                    $push:{
                      bp:{
                        $each:[bp],
                        $slice: -10
                      }
                    },
                    $set:{'ld.bp':bp}
                  }
          bpRecord = Laniakea.Collection.Bps.findOne(healthrecordId)
          unless bpRecord
            Laniakea.Collection.Bps.insert({_id:healthrecordId ,bp:[bp]})
          else
            Laniakea.Collection.Bps.update( healthrecordId , {$push:{bp:bp}})
          return tips
      else
        throw new Meteor.Error("401", "not authed service");
#添加血氧
    'addbo':(healthrecordId,bo)->
      if Meteor.user()?
        unless  bo || healthrecordId
          throw new Meteor.Error("undefinded-error", "healthrecordId or bo is not definded");
        unless  typeof(bo) is 'object'
          throw new Meteor.Error("not-object", "bo is not a object");
        else
          unless bo.t
            bo.t = new Date()
          unless bo.v
            throw new Meteor.Error("null-value", "bo value is null");
          tips = {}
          userHR = Laniakea.Collection.HealthRecords.findOne(healthrecordId)
          unless userHR
            tips = Laniakea.Collection.HealthRecords.insert({_id:healthrecordId ,bo:[bo],ld:{bo:bo}})
          else
            tips = Laniakea.Collection.HealthRecords.update healthrecordId,
              {
                  $push:{
                    bo:{
                      $each:[bo],
                      $slice: -10
                    }
                  },
                  $set:{'ld.bo':bo}
              }
          boRecord = Laniakea.Collection.Bos.findOne(healthrecordId)
          unless boRecord
            Laniakea.Collection.Bos.insert({_id:healthrecordId ,bo:[bo]})
          else
            Laniakea.Collection.Bos.update( healthrecordId , {$push:{bo:bo}})
          return tips
      else
        throw new Meteor.Error("401", "not authed service");
# 添加血糖
    'addbbbg':(healthrecordId,bbbg)->
      if Meteor.user()?
        unless  bbbg || healthrecordId
          throw new Meteor.Error("undefinded-error", "healthrecordId or bbbg is not definded");
        unless  typeof(bbbg) is 'object'
          throw new Meteor.Error("not-object", "bbbg is not a object");
        else
          unless bbbg.t
            bbbg.t = new Date()
          unless bbbg.v
            throw new Meteor.Error("null-value", "bbbg is null");
            return
          tips = {}
          userHR = Laniakea.Collection.HealthRecords.findOne(healthrecordId)
          unless userHR
            tips = Laniakea.Collection.HealthRecords.insert({_id:healthrecordId ,bbbg:[bbbg],ld:{bg:bbbg}})
          else
            tips = Laniakea.Collection.HealthRecords.update healthrecordId,
              {
                $push:{
                  bbbg:{
                    $each:[bbbg],
                    $slice: -10
                  }
                },
                $set:{'ld.bg':bbbg}
              }
#          tips = Laniakea.Collection.HealthRecords.update healthrecordId,{$push:{bbbg:bbbg}}
          bgRecord = Laniakea.Collection.Bgs.findOne(healthrecordId)
          unless bgRecord
            Laniakea.Collection.Bgs.insert({_id:healthrecordId ,bg:[bbbg]})
          else
            Laniakea.Collection.Bgs.update( healthrecordId , {$push:{bg:bbbg}})
          return tips
      else
        throw new Meteor.Error("401", "not authed service");

#  添加心率方法
    'addheartRate':(healthrecordId,heartRate)->
      if Meteor.user()?
        unless  heartRate || healthrecordId
          throw new Meteor.Error("undefinded-error", "healthrecordId or wt is not definded");
        unless  typeof(heartRate) is 'object'
          throw new Meteor.Error("not-object", "params wt is not a object");
        else
          unless heartRate.t
            heartRate.t = new Date()
          tips = {}
          userHR = Laniakea.Collection.HealthRecords.findOne(healthrecordId)
          unless userHR
            tips = Laniakea.Collection.HealthRecords.insert({_id:healthrecordId,hr:[heartRate],ld:[heart:heartRate]})
          else
            tips = Laniakea.Collection.HealthRecords.update healthrecordId,
              {
                $push:{
                  hr: {
                    $each:[heartRate],
                    $slice: -10
                  }
                },
                $set:{'ld.heart':heartRate}
              }

          heartRate.u = healthrecordId
          Laniakea.Collection.HeartRates.insert (heartRate)

          return tips
      else
        throw new Meteor.Error("401", "not authed service");