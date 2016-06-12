##COLLECTION
@Laniakea.Collection.Prescriptions = new Mongo.Collection "prescriptions"

##SCHEMA
@Laniakea.Schema.DrugItem = new SimpleSchema
  _id:
    type:String
    label:' '
    autoform:
      afFieldInput:
        type: 'hidden'

  name:
    type:String
    label:'名称'
    optional: false

  df: #drug format
    type: String
    label: '规格'
    optional: true

  ft: #Factory
    type: String
    label: '厂商'
    optional: true

  price:
    type: Number
    label: '单价'
    optional: true

  du: #drug unit
    type: String
    label: '单位'
    optional: true

  number:
    type: Number
    label: '数量'
    optional: true

  dosage:
    type: String
    label: '用量'
    optional: true

  usage:
    type: String
    label: '用法'
    optional: true

  usedays: #use Medication days
    type:String
    label:'用药天数'
    optional:true

  skt:#skin test
    type:String
    optional:true
    label:'皮试'
    allowedValues: ["是", "否"]
    autoform:
      afFieldInput:
        type:'select-radio-inline'


@Laniakea.Schema.Prescription = new SimpleSchema
  patid:
    type: String
    label: '患者id'
    optional: false

  pat:
    type:String
    label:'患者姓名'
    optional:false

  age:
    type:Number
    label:'患者年龄'
    optional:true
    autoValue: ->
      bir = this.field('birthday').value
      if bir?
        return (new Date).getFullYear() - (new Date(this.field('birthday').value)).getFullYear()
  sex:
    type:String
    optional:true
    label:'性别'
    allowedValues: ["男", "女"]

  patphone:
    type: String
    label:'患者手机'
    regEx: /^1\d{10}$/
    optional:true

  doc:
    type:String
    label:'医生'
    optional:true


  diag:  #diagnosis
    type:String
    label:'诊断'
    optional:true

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

  patstate:
    type: [ String ]
    label: "病生状态"
    allowedValues: [ "妊娠期", "哺乳期"]
    optional: true
    autoform:
      afFieldInput:
        type:'select-checkbox-inline'

  feetype:
    type:String
    label:'费别'
    optional:true

  fee:
    type:Number
    label:'费用'
    optional:true
    autoValue: ->
      if @isInsert
        bir = this.field('fee').value
        if bir?
          bir
        else
          0

  hosid:
    type: String
    label: "医院编号"
    optional: true

  depid:
    type:String
    label:'诊断科室id'
    optional:true

  drugs:
    type:[Laniakea.Schema.DrugItem]
    label:'用药列表'
    optional:true

  state:
    type:String
    label:''
    optional:true
    allowedValues: ["开立","已收费","已取药","取消"]
    autoValue: ->
      if @isInsert
        '开立'
  si:
    type:String
    optional:true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['pat'])

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

@Laniakea.Collection.Prescriptions.attachSchema Laniakea.Schema.Prescription

##PUBLISH
if Meteor.isServer
  Meteor.publish 'singlePrescription',(id)->
    Laniakea.Collection.Prescriptions.find(id)

  Meteor.publish 'prescriptions',(selector,options)->
    if selector?.si
      selector['si'] = new RegExp(selector.si,'i')
#    delete selector['si']
    Laniakea.Collection.Prescriptions.find(
      selector
      options
    )

##PERIMISSION
Laniakea.Collection.Prescriptions.allow
  'insert':(userId,doc)->
    userId
  'update':(userId,doc,fieldNames,modifier)->
    userId
  'remove':(userId,doc,fieldNames,modifier)->
    userId

#SEED
@Laniakea.Seed.PrescriptionsSeeding =(drugs,pat) ->
  pres=[]
  pr =
    patid:pat._id
    pat:pat.profile.name
#      age:
    patphone:pat.profile.phone
    doc:'张彬彬'
    diag:  'I型糖尿病性动眼神经麻痹'
    birthday:pat.profile.birthday
    patstate:[]
    feetype:'自费'
    state:'已收费'
    fee:3000
    company:''
    drugs:[
      {
        '_id':drugs[0]._id
        'name':drugs[0].name
        'df':drugs[0].df
        'ft:':drugs[0].pd
        'number':5
        'price':30
        'du':drugs[0].du
        'dosage':' 每次两粒'
        'usage':'每天两次'
        'usedays':'6天'
        'skt':'否'
      },
      {
        '_id':drugs[1]._id
        'name':drugs[1].name
        'df':drugs[1].df
        'ft:':drugs[1].pd
        'number':6
        'price':15
        'du':drugs[1].du
        'dosage':' 每次三粒'
        'usage':'每天两次'
        'usedays':'7天'
        'skt':'否'
      },
      {
        '_id':drugs[2]._id
        'name':drugs[2].name
        'df':drugs[2].df
        'ft:':drugs[2].pd
        'number':2
        'price':50
        'du':drugs[2].du
        'dosage':' 每次三粒'
        'usage':'每天两次'
        'usedays':'7天'
        'skt':'否'
      }
    ]
  pr._id = Laniakea.Collection.Prescriptions.insert pr
  preitm =
    _id:pr._id
    pat:pr.pat
    state:pr.state
    createdAt:pr.createdAt
  pres.push(preitm)

  pr2 =
    patid:pat._id
    pat:pat.profile.name
#      age:
    patphone:pat.profile.phone
    doc:'菲儿'
    diag: 'I型糖尿病性动眼神经麻痹；I型糖尿病伴有神经系统并发症'
    birthday:pat.profile.birthday
    patstate:[]
    state:'已收费'
    feetype:'自费'
    fee:3000
    company:''
    drugs:[
      {
        '_id':drugs[9]._id
        'name':drugs[9].name
        'df':drugs[9].df
        'ft:':drugs[9].pd
        'number':7
        'price':5
        'du':drugs[9].du
        'dosage':' 每次两粒'
        'usage':'每天两次'
        'usedays':'5天'
        'skt':'否'
      },
      {
        '_id':drugs[4]._id
        'name':drugs[4].name
        'df':drugs[4].df
        'ft:':drugs[4].pd
        'number':6
        'price':16
        'du':drugs[4].du
        'dosage':' 每次三粒'
        'usage':'每天两次'
        'usedays':'7天'
        'skt':'否'
      },
      {
        '_id':drugs[7]._id
        'name':drugs[7].name
        'df':drugs[7].df
        'ft:':drugs[7].pd
        'number':8
        'price':6
        'du':drugs[7].du
        'dosage':' 每次三粒'
        'usage':'每天两次'
        'usedays':'7天'
        'skt':'否'
      }
    ]
  pr2._id = Laniakea.Collection.Prescriptions.insert pr2
  preitm2 =
    _id:pr2._id
    pat:pr2.pat
    state:pr2.state
    createdAt:pr2.createdAt
  pres.push(preitm2)

  pres2=[]
  pr3 =
    patid:pat._id
    pat:pat.profile.name
#      age:
    patphone:pat.profile.phone
    doc:'张彬彬'
    diag:  'I型糖尿病性动眼神经麻痹'
    birthday:pat.profile.birthday
    patstate:[]
    feetype:'自费'
    state:'已收费'
    fee:3000
    company:''
    drugs:[
      {
        '_id':drugs[6]._id
        'name':drugs[6].name
        'df':drugs[6].df
        'ft:':drugs[6].pd
        'number':2
        'price':25
        'du':drugs[6].du
        'dosage':' 每次两粒'
        'usage':'每天两次'
        'usedays':'3天'
        'skt':'否'
      },
      {
        '_id':drugs[5]._id
        'name':drugs[5].name
        'df':drugs[5].df
        'ft:':drugs[5].pd
        'number':5
        'price':30
        'du':drugs[1].du
        'dosage':' 每次三粒'
        'usage':'每天两次'
        'usedays':'10天'
        'skt':'否'
      },
      {
        '_id':drugs[4]._id
        'name':drugs[4].name
        'df':drugs[4].df
        'ft:':drugs[4].pd
        'number':5
        'price':20
        'du':drugs[4].du
        'dosage':' 每次三粒'
        'usage':'每天两次'
        'usedays':'5天'
        'skt':'否'
      }
    ]
  pr3._id = Laniakea.Collection.Prescriptions.insert pr3
  preitm3 =
    _id:pr3._id
    pat:pr3.pat
    state:pr3.state
    createdAt:pr3.createdAt
  pres2.push(preitm3)

  pr4 =
    patid:pat._id
    pat:pat.profile.name
#      age:
    patphone:pat.profile.phone
    doc:'菲儿'
    diag: 'I型糖尿病性动眼神经麻痹；I型糖尿病伴有神经系统并发症'
    birthday:pat.profile.birthday
    patstate:[]
    feetype:'自费'
    fee:3000
    state:'已收费'
    company:''
    drugs:[
      {
        '_id':drugs[3]._id
        'name':drugs[3].name
        'df':drugs[3].df
        'ft:':drugs[3].pd
        'number':3
        'price':10
        'du':drugs[3].du
        'dosage':' 每次两粒'
        'usage':'每天两次'
        'usedays':'5天'
        'skt':'否'
      },
      {
        '_id':drugs[4]._id
        'name':drugs[4].name
        'df':drugs[4].df
        'ft:':drugs[4].pd
        'number':5
        'price':15
        'du':drugs[4].du
        'dosage':' 每次三粒'
        'usage':'每天两次'
        'usedays':'7天'
        'skt':'否'
      },
      {
        '_id':drugs[2]._id
        'name':drugs[2].name
        'df':drugs[2].df
        'ft:':drugs[2].pd
        'number':2
        'price':15
        'du':drugs[2].du
        'dosage':' 每次三粒'
        'usage':'每天两次'
        'usedays':'7天'
        'skt':'否'
      }
    ]
  pr4._id = Laniakea.Collection.Prescriptions.insert pr4

  preitm4 =
    _id:pr4._id
    pat:pr4.pat
    state:pr4.state
    createdAt:pr4.createdAt

  pr5 =
    patid:pat._id
    pat:pat.profile.name
#      age:
    patphone:pat.profile.phone
    doc:'菲儿'
    diag: 'I型糖尿病性动眼神经麻痹；I型糖尿病伴有神经系统并发症'
    birthday:pat.profile.birthday
    patstate:[]
    feetype:'自费'
    fee:3000
    state:'已收费'
    company:''
    drugs:[
      {
        '_id':drugs[9]._id
        'name':drugs[9].name
        'df':drugs[9].df
        'ft:':drugs[9].pd
        'number':7
        'price':15
        'du':drugs[9].du
        'dosage':' 每次两粒'
        'usage':'每天两次'
        'usedays':'9天'
        'skt':'否'
      },
      {
        '_id':drugs[0]._id
        'name':drugs[0].name
        'df':drugs[0].df
        'ft:':drugs[0].pd
        'number':9
        'price':15
        'du':drugs[0].du
        'dosage':' 每次三粒'
        'usage':'每天两次'
        'usedays':'12天'
        'skt':'否'
      },
      {
        '_id':drugs[2]._id
        'name':drugs[2].name
        'df':drugs[2].df
        'ft:':drugs[2].pd
        'number':2
        'price':15
        'du':drugs[2].du
        'dosage':' 每次三粒'
        'usage':'每天两次'
        'usedays':'4天'
        'skt':'否'
      }
    ]
  pr5._id = Laniakea.Collection.Prescriptions.insert pr5
  preitm5 =
    _id:pr5._id
    pat:pr5.pat
    state:pr5.state
    createdAt:pr5.createdAt
  pres2.push(preitm4)
  pres3=[]
  pres3.push(preitm)
  pres3.push(preitm4)
  pres3.push(preitm5)
  omrs = Laniakea.Collection.OutMedRecords.find({patid:pat._id})
  omrIds=[]
  omrs.fetch().forEach (element) ->
    omrIds.push(element._id)
  if omrIds[0]?
    Laniakea.Collection.OutMedRecords.update({_id:omrIds[0]},{$set:{'pres':pres}})
  if omrIds[1]?
    Laniakea.Collection.OutMedRecords.update({_id:omrIds[1]},{$set:{'pres':pres2}})
  if omrIds[2]?
    Laniakea.Collection.OutMedRecords.update({_id:omrIds[2]},{$set:{'pres':pres3}})
#  omrs.fetch().forEach (element) ->
#    Laniakea.Collection.OutMedRecords.update({_id:element._id},{$set:{'pres':pres}})

