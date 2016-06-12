#console.log 'Loading Worklists.coffee'

##COLLECTION
@Laniakea.Collection.Worklists = new Mongo.Collection ("worklists")

##INDEX
if Meteor.isServer
  @Laniakea.Collection.Worklists._ensureIndex {si: 1}
  @Laniakea.Collection.Worklists._ensureIndex {state: 1}
  @Laniakea.Collection.Worklists._ensureIndex {patid: 1}
  @Laniakea.Collection.Worklists._ensureIndex {docid: 1}
  @Laniakea.Collection.Worklists._ensureIndex {apmt: 1}
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
#    type:Number
#    label:'费用'
#    optional:true
##SCHEMA
@Laniakea.Schema.Worklist = new SimpleSchema

  patid:
    type: String
    label: '患者id'
    optional:false

  pat:
    type: String
    label: '患者姓名'

  age:
    type: String
    label: '患者年龄'
    optional: true

  sex:
    type: String
    label: "性别"
    optional: true

  apmt:
    type: Date
    label: "预约时间"
    defaultValue:moment().format 'YYYY-MM-DD HH:mm'
    autoform:
      afFieldInput:
        type: "bootstrap-datetimepicker"
        startDate: moment().format 'YYYY-MM-DD'
        dateTimePickerOptions:
          format: "YYYY-MM-DD HH:mm"
          minDate: moment().format 'YYYY-MM-DD'

  apmtime:
    type:String
    optional:true
    label:'预约区间' #上午 或者 下午 根据此选项进行安排具体的时间点

  dev:
    type:String
    optional:true
    label:'设备名称'
    autoform:
      afFieldInput:
        firstOption:'请选择'

  serv:
    type: String
    label: "服务项目"
    optional:true
    autoform:
      firstOption:'请选择'
      options:->
        options = {}
        if Meteor.user()?.profile?.nurse
          depid = Meteor.user()?.profile?.nurse?.depid
          if depid
            dep = Laniakea.Collection.Departments.findOne(depid)
            if dep
              dep.servs.forEach (element) ->
                options[element] = element
                return
              options
  mod:
    type:String
    optional:true
    label:'模态'
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->#['超声', 'CT', '核磁', 'PET', '胎儿彩超']
      str = ''
      if this.field('serv').value && this.field('serv').value == '超声'
        str = 'US'

      if this.field('serv').value && this.field('serv').value == 'CT'
        str = 'CT'

      if this.field('serv').value && this.field('serv').value == '核磁'
        str = 'MR'

      if this.field('serv').value && this.field('serv').value == 'PET'
        str = 'PET'

      if this.field('serv').value && this.field('serv').value == '胎儿彩超'
        str = 'US'

      return str

#    allowedValues:['US','CT','MR','XR']
#    autoform:
#      afFieldInput:
#        type:"select-radio-inline"
#      options:->
#        US:'US',
#        CT:'CT',
#        MR:'MR',
#        XR:'XR'
#  fee:
#    type:Number
#    label:'费用'
#    optional:true
#    autoform:
#      afFieldInput:
#        type: 'hidden'
#    autoValue: ->
#      f = this.field('exms').value
#      str = 0
#      if f && f.length > 0
#        f.forEach (element) ->
#          str = str + element.fee
#          return
#        str
  apldepid:
    type:String
    optional:true
    autoform:
      afFieldInput:
        firstOption:'请选择'
    label:'申请科室ID'

  apldep:
    type:String
    label:'申请科室'
    optional:true
    autoValue: ->
      if this.field('apldepid').value
        depname = Laniakea.Collection.Departments.findOne(this.field('apldepid').value).name
        if depname
          return depname
  exmdepid:
    type:String
    optional:true
    autoform:
      afFieldInput:
        firstOption:'请选择'
    label:'检查科室'

  exmdep:
    type:String
    label:'检查科室'
    optional:true
    autoValue: ->
      if this.field('exmdepid').value
        depname = Laniakea.Collection.Departments.findOne(this.field('exmdepid').value).name
        if depname
          return depname


  apldocid:
    type:String
    optional:true
    autoform:
      afFieldInput:
        firstOption:'请选择'
    label:'申请医生'

  apldoc:
    type:String
    optional:true
    label:'申请医生'
    autoValue: ->
      if this.field('apldocid').value
        return Meteor.users.findOne(this.field('apldocid').value).profile.name

  docid:
    type:String
    optional:true
    autoform:
      afFieldInput:
        firstOption:'请选择'
    label:'检查医生'

  doc:
    type:String
    optional:true
    label:'检查医生'
    autoValue: ->
      if this.field('docid').value
        return Meteor.users.findOne(this.field('docid').value).profile.name

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
    type:Number
    label:'费用'
    optional:true

  state:
    type: String
    label: '状态'
    optional:true
    allowedValues:['预约','确认','完成','取消','检查申请']
    autoValue: ->
      if this.field('state').value?
        this.field('state').value
      else if @isInsert
        '预约'
    autoform:
      omit:true
  note:
    type: String
    label: "备注"
    optional: true
    autoform:
      omit: true

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

  hospid:
    type: String
    label: "医院编号"
    optional: true
    autoform:
      omit: true
  hosp:
    type: String
    label: "医院名称"
    optional: true
    autoform:
      omit: true
  desc:
    type: String
    label: "症状描述"
    optional: true
    autoform:
      afFieldInput:
        type:'textarea'
  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['pat','mod','apldoc','doc','exmpt','exmitm'])


@Laniakea.Collection.Worklists.attachSchema Laniakea.Schema.Worklist
Laniakea.Collection.Worklists.allow
  insert:->
    true
  update:->
    true

##PUBLISH
if Meteor.isServer
  Meteor.publish "worklists",(selector )->
    unless selector
      selector = {}
    if selector?.si
      selector['si'] = new RegExp(selector.si,'i')
    Laniakea.Collection.Worklists.find selector,
      sort:{ apmt: -1 }
      limit:50
      fields:
        patid: 1
        pat: 1
        age: 1
        sex: 1
        apmt: 1
        apmtime: 1
        mod: 1
        serv: 1
        apldepid: 1
        exmdepid: 1
        exmdep: 1
        apldep: 1
        apldocid: 1
        apldoc: 1
        docid: 1
        doc : 1
        state: 1
        note: 1
        exmpt: 1
        exmitm: 1
        fee: 1
        hosp: 1
        desc: 1
        si: 1

  Meteor.publish 'singleWorklist', (id) ->
    Laniakea.Collection.Worklists.find id

  Meteor.publish 'subWorklists', (selector,options)->
    unless @userId? and Roles.userIsInRole(@userId,['nurse', 'doctor'])
      throw new Meteor.Error '403','权限不足'
      @ready()
    else
      return Laniakea.Collection.Worklists.find selector, options

  Meteor.publish 'aplWorklists', (dep_id)->
    unless @userId? and Roles.userIsInRole(@userId,['nurse', 'doctor'])
      throw new Meteor.Error '403','权限不足'
      @ready()
    else
      Laniakea.Collection.Worklists.find {$or:[{state: '预约'}], apmt:{$gte: new Date()}, 'apldepid': dep_id},
        fields:
          patid: 1
          pat: 1
          age: 1
          sex: 1
          apmt: 1
          mod: 1
          serv: 1
          apldepid: 1
          apldep: 1
          exmdepid: 1
          exmdep: 1
          apldocid: 1
          apldoc: 1
          docid: 1
          doc : 1
          exmpt: 1
          exmitm: 1
          fee: 1
          state: 1
          note: 1
          si:1

##PERIMISSION
Laniakea.Collection.Worklists.allow
  insert: ->
    true
  remove: ->
    true
  update: ->
    true

##SEED
@Laniakea.Seed.WorklistsSeeding = (deps, docs,pats) ->
  if Laniakea.Collection.Worklists.find().count() is 0
    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '预约'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '预约'

    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '完成'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '完成'
    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '确认'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '确认'
    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '完成'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '完成'
    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '取消'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '取消'
    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '取消'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '取消'
    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '完成'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '完成'
    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '完成'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '完成'
    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '预约'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '预约'
    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '确认'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '确认'
    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '预约'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '预约'
    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '确认'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '确认'
    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '完成'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '完成'
    Laniakea.Collection.Worklists.insert
      patid: pats[0]._id
      pat: pats[0].profile.name
      sex: pats[0].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]?._id
      apldep: deps[0]?.name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '完成'

    Laniakea.Collection.Worklists.insert
      patid: pats[1]._id
      pat: pats[1].profile.name
      sex: pats[1].profile.sex
      age: 34
      mod: 'US'
      apmt: new Date
      apldepid: deps[0]._id
      apldep: deps[0]._name
      apldocid: docs[0]._id
      apldoc: docs[0].profile.name
      docid: docs[0]._id
      doc: docs[0].profile.name
      exmpt:'穿刺定位'
      exmitm: '胸水穿刺定位'
      fee: 120
      state: '完成'


