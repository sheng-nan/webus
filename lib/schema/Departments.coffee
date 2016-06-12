#console.log 'Loading Departments.coffee'

##COLLECTION
@Laniakea.Collection.Departments  = new Mongo.Collection "departments"

##INDEX
if Meteor.isServer
  @Laniakea.Collection.Departments._ensureIndex {hosid: 1}

##SCHEMA
@Laniakea.Schema.ModalityDevice = new SimpleSchema
  _id:    ## 建议去掉
    type:String

  name:
    type:String
    label:"设备名称"

  mod:
    type:String
    label:'模态'
    autoform:
      afFieldInput:
        firstOption:'请选择'
      allowedValues:['CT','US','MR','XR']
      options:->
        CT:'CT',
        US:'US',
        MR:'MR',
        XR:'XR'

@Laniakea.Schema.ExaminedItem = new SimpleSchema
# 项目名称(item_name)
  itmn:
    type:String
    label:'项目名称'
  fee:
    type:String
    label:'项目费用'
# 检查时间长度(time_length)
  tl:
    type:Number
    label:'检查时间长度'

@Laniakea.Schema.ExaminedPosition = new SimpleSchema
  _id:
    type:String

# 检查部位(position_name)
  posn:
    type:String
    label:'检查部位'
# 检查项目(examined_items)
  exmitm:
    type: [@Laniakea.Schema.ExaminedItem]
    optional: true
    label:'检查项目'




@Laniakea.Schema.Department = new SimpleSchema

  hosid:
    type:String
    label:'医院id'
    optional:false

  hos:
    type:String
    label:'医院名称'
    optional:true

  name:
    type: String
    label: "科室名称"

  sn:
    type: String
    label: "科室简称"
    optional:true

  phone:
    type:String
    label:'联系电话'
    optional:true

  depType:
    type:String
    label:'科室类型'
    optional:true
    autoform:
      afFieldInput:
        firstOption:'请选择'
      allowedValues:['内科','外科','妇科','儿科','中医科','肿瘤专科','检验科','护理单元','药房','其他']
      options:->
        内科:'内科',
        外科:'外科',
        妇科: '妇科',
        儿科:'儿科',
        中医科:'中医科',
        肿瘤专科: '肿瘤专科',
        检验科:'检验科',
        护理单元:'护理单元',
        药房: '药房',
        其他: '其他'

  dev:
    type:[@Laniakea.Schema.ModalityDevice]
    optional:true
    label:'检查设备'


# 检查部位(examined_positions)
  exmpt:
    type:[@Laniakea.Schema.ExaminedPosition]
    optional:true
    label:'检查部位'

  desc:
    type: String
    label: "描述"
    autoform:
      rows: 5
    optional: true

  servs:
    type: [String]
    label: "服务项目"
    autoform:
      rows: 5
      afFieldInput:
        firstOption: '请选择'
      allowedValues: ['超声', 'CT', '核磁', 'PET', '胎儿彩超']
      options: ->
        CT: 'CT',
        US: 'US',
        MR: 'MR',
        XR: 'XR'
    optional: true

  servnum:
    type: [Number]
    label: '半天服务人数'
    optional: true
  verify:
    type: Number
    label:'审核状态'
    allowedValues:[0, 1, 2]
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
Laniakea.Collection.Departments.attachSchema @Laniakea.Schema.Department


##PUBLISH
if Meteor.isServer
  #publish for weixin project
  Meteor.publishComposite 'servdepartments', (selector, option)->
    find: ->
      unless  selector
        selector = {}
      unless  option
        option = {}

      Laniakea.Collection.Departments.find selector,
        fields:
          hosid: 1
          name: 1
          phone: 1
          exmpt: 1
          hos: 1
          servs: 1
          servnum: 1
    children: [
      {
        find: (department)->
          if department?
            hosid = department.hosid

            selector = {_id: hosid}
            Laniakea.Collection.Hospitals.find selector,
              fields:
                name: 1
                sn: 1
                phone: 1
                rank: 1
                img: 1
      }
    ]

  Meteor.publish 'departments',(hos_id)->
    Laniakea.Collection.Departments.find({hosid:hos_id},
#      limit:10
      fields:
        hosid:1
        name:1
        phone:1
        servs: 1
        dev: 1
        verify: 1
        verReason: 1
        verd: 1
        depType: 1
        exmpt: 1
    )

  Meteor.publishComposite  'singleDepartment',(id)->
#    unless @userId
#      @ready()
#    else
      find:->
        Laniakea.Collection.Departments.find id
      children:[
        {
          find: (department)->
            if department?
              Meteor.users.find({'roles': {$in: ['doctor']}, 'profile.doctor.depid': department._id},
                fields:
                  profile: 1
                  roles: 1
              )
        },
        {
          find: (department)->
            if department?
              Meteor.users.find({'roles': {$in: ['nurse']}, 'profile.nurse.depid': department._id},
                fields:
                  profile: 1
                  roles: 1
              )
        }
      ]

##PERIMISSION
Laniakea.Collection.Departments.allow
  insert:->
    if Meteor.userId()
      true
  update:->
    if Meteor.userId()
      true
  remove:->
    if Meteor.userId()
      true


##SEED

fubu = {
  _id: new Meteor.Collection.ObjectID()._str
  posn: "腹部"
  exmitm: [{
    itmn: "肝胆胰脾"
    fee: 120
    tl: 150
  }, {
    itmn: "双肾"
    fee: 120
    tl: 120
  }, {
    itmn: "肝胆胰脾+双肾"
    fee: 165
    tl: 120
  }, {
    itmn: "腹膜后及腹腔淋巴结"
    fee: 165
    tl: 120
  }, {
    itmn: "腹部包块"
    fee: 165
    tl: 120
  }, {
    itmn: "肝胆胰脾双肾+腹膜后及腹腔淋巴结"
    fee: 120
    tl: 120
  }, {
    itmn: "肝胆胰脾双肾+腹部包块"
    fee: 120
    tl: 120
  }, {
    itmn: "泌尿系（双肾+输尿管+膀胱）"
    fee: 120
    tl: 120
  }, {
    itmn: "前列腺"
    fee: 120
    tl: 120
  }, {
    itmn: "输尿管"
    fee: 120
    tl: 120
  }, {
    itmn: "膀胱"
    fee: 120
    tl: 120
  }, {
    itmn: "精囊"
    fee: 120
    tl: 120
  }]
}

chuanci = {
  _id: new Meteor.Collection.ObjectID()._str
  posn: "穿刺定位"
  exmitm: [
    {
      itmn: "胸水穿刺定位"
      fee: 120
      tl: 150
    }, {
      itmn: "腹水穿刺定位"
      fee: 120
      tl: 150
    }
  ]
}

xiaoqiguan = {
  _id: new Meteor.Collection.ObjectID()._str
  posn: "小器官系列"
  exmitm: [
    {
      itmn: "浅表软组织肿块"
      fee: 120
      tl: 150
    }, {
      itmn: "乳腺"
      fee: 120
      tl: 150
    }, {
      itmn: "腋下淋巴结"
      fee: 120
      tl: 150
    }, {
      itmn: "甲状腺"
      fee: 120
      tl: 150
    }, {
      itmn: "颈部淋巴结"
      fee: 120
      tl: 150
    }, {
      itmn: "颌下腺"
      fee: 120
      tl: 150
    }, {
      itmn: "腮腺"
      fee: 120
      tl: 150
    }, {
      itmn: "睾丸"
      fee: 120
      tl: 150
    }, {
      itmn: "附睾"
      fee: 120
      tl: 150
    }, {
      itmn: "腹股沟淋巴结"
      fee: 120
      tl: 150
    }
  ]}

fuke = {
  _id: new Meteor.Collection.ObjectID()._str
  posn: "妇产科系列"
  exmitm: [
    {
      itmn: "妇科经腹检查"
      fee: 120
      tl: 150
    }, {
      itmn: "早孕检查"
      fee: 120
      tl: 150
    }, {
      itmn: "中孕检查"
      fee: 120
      tl: 150
    }, {
      itmn: "产前筛畸"
      fee: 120
      tl: 150
    }
  ]}

qiangnei = {
  _id: new Meteor.Collection.ObjectID()._str
  posn: "腔内系列"
  exmitm: [
    {
      itmn: "经阴道超声"
      fee: 180
      tl: 150
    }, {
      itmn: "经直肠超声"
      fee: 180
      tl: 150
    }, {
      itmn: "经直肠前列腺"
      fee: 180
      tl: 150
    }, {
      itmn: "经直肠精囊"
      fee: 180
      tl: 150
    }
  ]}

xueguan = {
  _id: new Meteor.Collection.ObjectID()._str
  posn: "血管检查"
  exmitm: [
    {
      itmn: "腹部大血管"
      fee: 170
      tl: 150
    }, {
      itmn: "肝脏血管"
      fee: 170
      tl: 150
    }, {
      itmn: "肾脏血管"
      fee: 170
      tl: 150
    }, {
      itmn: "阴茎血管"
      fee: 170
      tl: 150
    }, {
      itmn: "上肢动脉"
      fee: 170
      tl: 150
    }, {
      itmn: "上肢静脉"
      fee: 170
      tl: 150
    }, {
      itmn: "上肢动脉+上肢静脉"
      fee: 170
      tl: 150
    }, {
      itmn: "下肢动脉"
      fee: 170
      tl: 150
    }, {
      itmn: "下肢静脉"
      fee: 170
      tl: 150
    }, {
      itmn: "下肢动脉+下肢静脉"
      fee: 170
      tl: 150
    }, {
      itmn: "颈动脉"
      fee: 180
      tl: 150
    }, {
      itmn: "颈静脉"
      fee: 170
      tl: 150
    }, {
      itmn: "颈动脉+颈静脉"
      fee: 170
      tl: 150
    }, {
      itmn: "椎动脉"
      fee: 170
      tl: 150
    }, {
      itmn: "精索静脉"
      fee: 170
      tl: 150
    }, {
      itmn: "血管多系统（颈动脉+椎动脉+锁骨下动脉）"
      fee: 310
      tl: 150
    }
  ]}

shuzhong = {
  _id: new Meteor.Collection.ObjectID()._str
  posn: "术中超声"
  exmitm: [
    {
      itmn: "60分钟以上"
      fee: 330
      tl: 150
    }, {
      itmn: "60分钟以内"
      fee: 330
      tl: 150
    }
  ]}

caichao = {
  _id: new Meteor.Collection.ObjectID()._str
  posn: "彩超引导"
  exmitm: [
    {
      itmn: "60分钟以上"
      fee: 330
      tl: 150
    }, {
      itmn: "60分钟以内"
      fee: 330
      tl: 150
    }
  ]}

jieru = {
  _id: new Meteor.Collection.ObjectID()._str
  posn: "介入超声"
  exmitm: [
    {
      itmn: "超声引导下穿刺活检（活检枪）"
      fee: 330
      tl: 150
    }, {
      itmn: "超声引导下囊肿治疗"
      fee: 330
      tl: 150
    }
  ]}

texu = {
  _id: new Meteor.Collection.ObjectID()._str
  posn: "特需门诊"
  exmitm: [
    {
      itmn: "妇科经腹检查"
      fee: 240
      tl: 150
    }, {
      itmn: "早孕检查"
      fee: 240
      tl: 150
    }, {
      itmn: "中孕检查"
      fee: 240
      tl: 150
    }, {
      itmn: "晚孕产科检查超声"
      fee: 240
      tl: 150
    }, {
      itmn: "经阴道检查"
      fee: 240
      tl: 150
    }, {
      itmn: "产前筛畸"
      fee: 240
      tl: 150
    }
  ]}

weizhi = [fubu,chuanci,xiaoqiguan,fuke,xueguan,shuzhong,caichao,jieru,texu]

@Laniakea.Seed.DepartmentsSeeding = (hos) ->
#  unless hos?
#    console.log 'No hospitals for seeding department ...'
#    return
#  console.log " hoslength ", hos.length

  #第1个科室
  hos0 = hos?[0]._id
  if Laniakea.Collection.Departments.find({hosid:hos0}).count() < 1
    d0 =
      hosid: hos0
      hos: hos[0]?.name
      name: "肿瘤肿瘤消融中心"
      sn: "肿瘤中心"
      phone:"010-62342348"
      desc: "念慈菴肿瘤消融中心"
      dev: [
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"Terason T3000"
          mod:"US"
        },
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"Terason T3200t"
          mod:"US"
        }
      ]
      exmpt:
        weizhi
      servs: [
        '超声', 'CT',  '胎儿彩超'
      ]
      servnum: [20,20,20]
    d0._id = Laniakea.Collection.Departments.insert(d0)

#    console.log 'Seeding Departments ' + d0.name
  #第2个科室
  hos1 = hos[1]?._id
  if Laniakea.Collection.Departments.find({hosid:hos1}).count() < 1
    d1 =
      hosid: hos1
      hos: hos[1]?.name
      name:"超声介入科"
      sn:"超声介入"
      phone:"010-62345678"
      desc: "介入超声科是我国首个集超声诊断与介入治疗于一体的临床科室"
      dev: [
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"飞利浦彩超"
          mod:"US"
        },
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"西门子彩超"
          mod:"US"
        }
      ]
      exmpt:
        weizhi
      servs: [
        '核磁', 'PET'
      ]
      servnum: [20,20]
    d1._id = Laniakea.Collection.Departments.insert(d1)
#    console.log 'Seeding Departments ' + d1.name
  #第3个科室 北医三院
  hos2 = hos[2]?._id
  if Laniakea.Collection.Departments.find({hosid:hos2}).count() < 1
    d2 =
      hosid: hos2
      hos: hos[2]?.name
      name:"超声诊断科"
      sn:"超声诊断"
      phone:"010-82266699"
      desc: "　北京大学第三医院超声诊断科创建于1960年， 是国内最早开始从事超声诊断的医疗机构之一。"
      dev: [
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"飞利浦彩超"
          mod:"US"
        },
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"西门子彩超"
          mod:"US"
        }
      ]
      exmpt:
        weizhi
      servs: [
        '超声'
      ]
      servnum: [20]
    d2._id = Laniakea.Collection.Departments.insert(d2)
  hos5 = hos[5]?._id#北京清华长庚医院
  if Laniakea.Collection.Departments.find({hosid:hos5}).count() < 1
    d3 =
      hosid: hos5
      hos: hos[5]?.name
      name:"心脏内科"
      sn:"心脏内科"
      depType: '内科'
      phone:"010-82266699"
      desc: "　北京清华长庚医院心血管内科创建于2014年，首任学科带头人为张萍教授，心血管内科的医疗团队是由海内外著名专家领衔、拥有高学历、丰富临床经验的医师组建而成。"
      dev: [
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"飞利浦彩超"
          mod:"US"
        },
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"西门子彩超"
          mod:"US"
        }
      ]
      exmpt:
        weizhi
      servs: [
        '超声'
      ]
      servnum: [20]
    d3._id = Laniakea.Collection.Departments.insert(d3)
#    console.log 'Seeding Departments ' + d3.name
    d4 =
      hosid: hos5
      hos: hos[5]?.name
      name:"消化内科"
      sn:"消化内科"
      depType: '内科'
      phone:"010-82266699"
      desc: "　北京清华长庚医院消化内科是集医疗、教学、科研为一体的临床科室，作为医院重点建设科室，科室人才密集、仪器设备引领世界前沿，疾病诊治达到国际胃肠诊疗领域先进水平。"
      dev: [
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"飞利浦彩超"
          mod:"US"
        },
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"西门子彩超"
          mod:"US"
        }
      ]
      exmpt:
        weizhi
      servs: [
        '超声'
      ]
      servnum: [20]
    d4._id = Laniakea.Collection.Departments.insert(d4)

    d5 =
      hosid: hos5
      hos: hos[5]?.name
      name:"内分泌代谢科"
      sn:"内分泌代谢科"
      depType: '内科'
      phone:"010-82266699"
      desc: "北京清华长庚医院内分泌科是集临床、科研、教学为一体的综合性医学研究和实践中心，包括临床、实验室和护理单元。现有主治医师1人、住院医师3人。科室拥有一批具有博士学位的高学历人才队伍，并多具有海外留学和进修背景。 　　随着以糖尿病为代表的内分泌疾病患病率的急剧上升，如今的内分泌学科已经成为仅次于心血管学科的大学科。"
      dev: [
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"飞利浦彩超"
          mod:"US"
        },
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"西门子彩超"
          mod:"US"
        }
      ]
      exmpt:
        weizhi
      servs: [
        '超声'
      ]
      servnum: [20]
    d5._id = Laniakea.Collection.Departments.insert(d5)
    d6 =
      hosid: hos5
      hos: hos[5]?.name
      name:"急诊科"
      sn:"急诊科"
      depType: '内科'
      phone:"010-82266699"
      desc: "北京清华长庚医院急诊科建立了完整的现代急救医学体系，全天24小时开放，是北京清华长庚医院抢救危重急症患者及应对突发公共卫生事件的前沿阵地，同时肩负教学、培训和科研任务的综合性临床科室。急诊科面对立水桥路天通苑段，临近地铁5号线天通苑站，交通便利。 　　急诊科的工作人员有医师、护士、呼吸治疗师。"
      dev: [
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"飞利浦彩超"
          mod:"US"
        },
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"西门子彩超"
          mod:"US"
        }
      ]
      exmpt:
        weizhi
      servs: [
        '超声'
      ]
      servnum: [20]
    d6._id = Laniakea.Collection.Departments.insert(d6)
    d7 =
      hosid: hos5
      hos: hos[5]?.name
      name:"神经外科"
      sn:"神经外科"
      depType: '外科'
      phone:"010-82266699"
      desc: "清华大学附属医院——北京清华长庚医院，是一所融医疗、教学、科研、预防、康复于一体的综合性三级公立医院。医院依托清华大学人才培养、学科交叉的优势，建设医学和理工、人文紧密结合的高水平医学研究平台，打造一流的临床教学医院，培养国际化的医学人才医院。"
      dev: [
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"飞利浦彩超"
          mod:"US"
        },
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"西门子彩超"
          mod:"US"
        }
      ]
      exmpt:
        weizhi
      servs: [
        '超声'
      ]
      servnum: [20]
    d7._id = Laniakea.Collection.Departments.insert(d7)
    d8 =
      hosid: hos5
      hos: hos[5]?.name
      name:"血管外科"
      sn:"血管外科"
      depType: '外科'
      phone:"010-82266699"
      desc: "北京清华长庚医院血管外科正式组建于2014年，血管疾病是近二十年我国居民健康的首要威胁，北京清华长庚医院依托现代整体医疗观念，重点打造清华长庚医院血管外科，使之成为现代化的循环系统诊疗中心。 　"
      dev: [
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"飞利浦彩超"
          mod:"US"
        },
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"西门子彩超"
          mod:"US"
        }
      ]
      exmpt:
        weizhi
      servs: [
        '超声'
      ]
      servnum: [20]
    d8._id = Laniakea.Collection.Departments.insert(d8)
    d9 =
      hosid: hos5
      hos: hos[5]?.name
      name:"血管外科"
      sn:"血管外科"
      depType: '外科'
      phone:"010-82266699"
      desc: "北京清华长庚医院血管外科正式组建于2014年，血管疾病是近二十年我国居民健康的首要威胁，北京清华长庚医院依托现代整体医疗观念，重点打造清华长庚医院血管外科，使之成为现代化的循环系统诊疗中心。 　"
      dev: [
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"飞利浦彩超"
          mod:"US"
        },
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"西门子彩超"
          mod:"US"
        }
      ]
      exmpt:
        weizhi
      servs: [
        '超声'
      ]
      servnum: [20]
    d9._id = Laniakea.Collection.Departments.insert(d9)
    d10 =
      hosid: hos5
      hos: hos[5]?.name
      name:"妇产科"
      sn:"妇产科"
      depType: '妇儿'
      phone:"010-82266699"
      desc: "北京清华长庚医院妇产科是一支组建不久的年轻的医疗团队，但这里的医生、护士、助产士们有着丰富医疗、护理经验。妇产科主任廖秦平教授是原北京大学第一医院妇产科主任，妇产科医师团队全部由北京大学第一医院、北京大学人民医院、北京协和医院妇产科副主任医师或主治医师组成。"
      dev: [
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"飞利浦彩超"
          mod:"US"
        },
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"西门子彩超"
          mod:"US"
        }
      ]
      exmpt:
        weizhi
      servs: [
        '超声'
      ]
      servnum: [20]
    d10._id = Laniakea.Collection.Departments.insert(d10)
    d11 =
      hosid: hos5
      hos: hos[5]?.name
      name:"儿科"
      sn:"儿科"
      depType: '妇儿'
      phone:"010-82266699"
      desc: "北京清华长庚医院儿科是一个集医疗、预防、教学、科研为一体，以诊治儿内科疾病、研究基础医学为重点的临床科室。儿科的医护团队既具备非常丰富的临床经验，又充满青春活力，同时拥有高水平的医疗技术和优质的护理服务。 　　目前儿科由门急诊、新生儿病房和新生儿重症监护病房（NICU）三部分组成。"
      dev: [
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"飞利浦彩超"
          mod:"US"
        },
        {
          _id:new Meteor.Collection.ObjectID()._str
          name:"西门子彩超"
          mod:"US"
        }
      ]
      exmpt:
        weizhi
      servs: [
        '超声'
      ]
      servnum: [20]
    d11._id = Laniakea.Collection.Departments.insert(d11)
    Laniakea.Collection.Hospitals.update({_id: hos5}, {$set: {deps: [{dtype: '内科', depItms: [{id:d3._id,name:d3.name ,docNum: 0},{id:d4._id,name:d4.name ,docNum: 0},{id:d5._id,name:d5.name ,docNum: 0},{id:d6._id,name:d6.name ,docNum: 0}]},
      {dtype: '外科', depItms:[{id: d7._id, name: d7.name, docNum: 0}, {id: d8._id, name: d8.name, docNum: 0},{id: d9._id, name: d9.name, docNum: 0}]},
      {dtype: '妇儿', depItms:[{id: d10._id, name: d10.name, docNum: 0},{id: d11._id, name: d11.name, docNum: 0}]}]}})
  return [d0,d1,d2]