#console.log 'Loading Hospitals.coffee'

##COLLECTION
@Laniakea.Collection.Hospitals = new Mongo.Collection "hospitals"

@Laniakea.Collection.HospitalImages = new FS.Collection('hospitalImages',
  stores: [
    new FS.Store.FileSystem('hospitalImages', path: '/dfs/lan')
  ]
)

##INDEX
if Meteor.isServer
  @Laniakea.Collection.Hospitals._ensureIndex {si: 1}
  @Laniakea.Collection.Hospitals._ensureIndex {provid: 1}
  @Laniakea.Collection.Hospitals._ensureIndex {cityid: 1}
  @Laniakea.Collection.Hospitals._ensureIndex {countyid: 1}
  @Laniakea.Collection.Hospitals._ensureIndex {townid: 1}
  @Laniakea.Collection.Hospitals._ensureIndex {villageid: 1}
@Laniakea.Schema.itm = new SimpleSchema
  id:
    type:String
    label:'科室ID'
    optional:true

  name:
    type:String
    label:'科室名称'
    optional:true
  docNum:
    type: Number
    label: '医生人数'
    optional: true
@Laniakea.Schema.dep = new SimpleSchema
  dtype:
    type:String
    label:'科室类型'
    optional:true

  depItms:
    type:[@Laniakea.Schema.itm]
    label:'科室信息'
    optional:true

##SCHEMA
@Laniakea.Schema.Hospital = new SimpleSchema

  name:
    type: String
    label: "医院名称"

  sn:
    type: String
    label: "医院简称"
    optional: true

  addr:
    type: String
    label: "医院地址"
    optional: true

  provid:
    type: String
    label: "省id"
    optional: true

  cityid:
    type: String
    label: "市id"
    optional: true

  countyid:
    type: String
    label: "县id"
    optional: true

  townid:
    type: String
    label: "乡镇id"
    optional: true

  villageid:
    type: String
    label: "村id"
    optional: true

  prov:
    type: String
    label: "省"
    optional: true

  city:
    type: String
    label: "市"
    optional: true

  county:
    type: String
    label: "县"
    optional: true

  town:
    type: String
    label: "乡镇"
    optional: true

  village:
    type: String
    label: "村"
    optional: true

  phone:
    type:  String
    label: "联系电话"
    optional: true

  rank:
    type: String
    label: "医院等级"
    optional: true
    autoform:
      afFieldInput:
        firstOption:'请选择'
      allowedValues:['三级甲等','三级乙等','三级丙等','二级甲等','二级乙等','二级丙等','一级甲等','一级乙等','一级丙等','门诊部/卫生院','诊所']
      options:->
        三级甲等:'三级甲等',
        三级乙等:'三级乙等',
        三级丙等: '三级丙等',
        二级甲等:'二级甲等',
        二级乙等:'二级乙等',
        二级丙等: '二级丙等',
        一级甲等:'一级甲等',
        一级乙等:'一级乙等',
        一级丙等: '一级丙等',
        '门诊部/卫生院': '门诊部/卫生院',
        诊所: '诊所'
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

  desc:
    type: String
    label: "描述"
    autoform:
      rows: 5
    optional: true
  img:
    type: String
    label: "图片"
    optional: true
    autoform:
      afFieldInput:
        type: 'fileUpload'
        collection: Laniakea.Collection.HospitalImages
        label: '选择图片...' # optional

  score:
    type: Number
    label: "得分"
    optional: true
# 经纬度
  gps:
    type:Object
    optional: true
    label:'经纬度'
  'gps.la':# 经度( latitude)
    type:String
    label:'经度'
    optional: true
  'gps.lo': # 纬度( longitude)
    type:String
    label:'纬度'
    optional: true

# 自动生成的字段
  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['name','sn','addr'])

  qr:
    type:String
    optional:true
    label:"微信二维码"

  deps:
    label: '拥有科室'
    type: [@Laniakea.Schema.dep]
    optional: true


@Laniakea.Collection.Hospitals.attachSchema Laniakea.Schema.Hospital



##PUBLISH
if Meteor.isServer
  Meteor.publish 'hospitals',(selector,options)->
    unless selector
      selector = {}
    else
      if selector?.name
        selector.name = new RegExp(selector.name,'i')
    unless options
      options = {}
      options.limit = 100
    Laniakea.Collection.Hospitals.find(selector,options)

  Meteor.publish 'singleHospital', (id) ->
    Laniakea.Collection.Hospitals.find id

  Meteor.publish 'singleHospitalImage',(id)->
    Laniakea.Collection.HospitalImages.find(id)
  Meteor.publish 'hospitalImages' ,->
    Laniakea.Collection.HospitalImages.find()

##PERIMISSION
Laniakea.Collection.Hospitals.allow
  insert:->
    if Meteor.userId()
      true
  update:->
    if Meteor.userId()
      true
  remove:->
    if Meteor.userId()
      true

Laniakea.Collection.HospitalImages.allow
  'insert':(userId,doc)->
    userId and Roles.userIsInRole(userId,['admin'])
  'update':(userId,doc,fieldNames,modifier)->
    userId and Roles.userIsInRole(userId,['admin'])
  download: (userId, fileObj)->
    userId and Roles.userIsInRole(userId,['admin'])

##SEED
@Laniakea.Seed.HospitalsSeeding = () ->
  if Laniakea.Collection.Hospitals.find({}).count() < 1

    h0 =
      name : "清华大学玉泉医院"
      sn: "304医院"
      prov: "北京"
      city: "石景山"
      addr: "北京石景山区石景山路5号"
      img: ''
      rank:"二级甲等"
      desc:"清华大学玉泉医院（即清华大学第二附属医院），1983年12月正式开院，是一所向社会开放的综合性医院。先后被评为“爱婴医院”、“大病统筹定点医院”、“医疗保险定点医院”。 2003年4月10日正式划归清华大学。"
    h0._id =Laniakea.Collection.Hospitals.insert(h0)

#    console.log console.log 'Seeding Hospital ' + h0.name

    h1 =
      name : "解放军总医院"
      sn: "301医院"
      prov: "北京"
      city: "海淀"
      addr: "北京市海淀区复兴路28号"
      img: ''
      phone: "010-68182255/66887329"
      rank:"三级甲等"
      desc:"解放军总医院是全军规模最大的综合性医院，集医疗、保健、教学、科研于一体，是国家重要保健基地之一，负责中央、军委和总部的医疗保健工作，承担全军各军区、军兵种疑难病的诊治，医院同时也收治来自全国的地方病人。"
    h1._id =Laniakea.Collection.Hospitals.insert(h1)
#    console.log console.log 'Seeding Hospital ' + h1.name

    h2 =
      name : "北京大学第三医院"
      sn: "北医三院"
      prov: "北京"
      city: "海淀"
      addr: "北京市海淀区花园北路49号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjdxdsyy.jpg'
      phone: "010-82266699/010-82266688"
      rank:"三级甲等"
      desc:"北医三院是一家综合性三级甲等医院，建院已有50多年了，2013年，年门急诊量达382万余人次，年出院患者7.9万余人次，年手术量达4.8万余例次，平均住院日为6.37天，是解决疑难重症的全国知名医院之一，其骨科、运动创伤科、妇产科、生殖中心、消化科、神经内科以及眼科等都很突出，有明确的特色及专业特长。"
    h2._id =Laniakea.Collection.Hospitals.insert(h2)
#    console.log console.log 'Seeding Hospital ' + h2.name

    h3 =
      name : "武警总医院"
      sn: "武警总医院"
      prov: "北京"
      city: "海淀"
      addr: "北京市海淀区永定路69号"
      img: ''
      phone: "010-57976114/57976688"
      rank:"三级甲等"
      desc:"武警总医院拥有一批国内一流的现代化医疗设备，总价值达7.2亿多元。是国家级“博士后科研工作站”、“中国国际救援医疗基地”、国内著名大学医学和教学基地、“武警部队医师进修学院”所在单位。"
    h3._id =Laniakea.Collection.Hospitals.insert(h3)
#    console.log console.log 'Seeding Hospital ' + h3.name

    h4 =
      name : "北京妇产医院"
      sn: "北京妇产医院"
      prov: "北京"
      city: "朝阳"
      addr: "北京市朝阳区姚家园路251号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjfcyy.jpg'
      phone: "010-114/010-116114"
      rank:"三级甲等"
      desc:"首都医科大学附属北京妇产医院 北京妇幼保健院是集医疗、教学、科研、预防、保健为一体，以诊治妇产科常见病、多发病和疑难病症为重点的国内知名的三级甲等妇产专科医院。"
    h4._id =Laniakea.Collection.Hospitals.insert(h4)
#    console.log console.log 'Seeding Hospital ' + h4.name

    h5 =
      name : "空军总医院"
      sn: "空军总医院"
      prov: "北京"
      city: "海淀"
      addr: "北京市海淀区阜成路30号"
      img: ''
      phone: "010-68410099"
      rank:"三级甲等"
      desc:"空军总医院创建于1956年10月，近50多年来，经过几代人的不懈努力，已发展成为集医、教、研和预防保健为一体的现代化程度比较高的大型综合性医院。"
    h5._id =Laniakea.Collection.Hospitals.insert(h5)
#    console.log console.log 'Seeding Hospital ' + h5.name

    h6 =
      name : "北京大学第六医院"
      sn: "北医六院"
      prov: "北京"
      city: "海淀"
      addr: "北京市海淀区海淀花园北路51号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjdxdlyy.jpg'
      phone: "010-82806151"
      rank:"三级甲等"
      desc:"北京大学精神卫生研究所（北京大学第六医院、北京大学精神卫生学院）是北京大学精神病学与精神卫生学的临床医疗、人才培训与科学研究基地，是世界卫生组织(WHO)北京精神卫生研究和培训协作中心，也是中国疾病预防控制中心的精神卫生中心。"
    h6._id =Laniakea.Collection.Hospitals.insert(h6)
#    console.log console.log 'Seeding Hospital ' + h6.name

    h7 =
      name : "北京市海淀医院"
      sn: "海淀医院"
      prov: "北京"
      city: "海淀"
      addr: "北京市海淀区中关村大街29号"
      img: ''
      phone: "010-82619999"
      rank:"三级甲等"
      desc:"海淀医院是一所融医疗、科研、教学、防保于一体的现代化综合性医院，位于海淀区中关村科技园区核心区内，兴建中的北京地铁4号和10号线海淀医院站进出口处。北京海淀医院还是2008年奥运定点医院、医保定点医院、北京市无烟医院，同时，担负着北京大学、首都医科大学、北京中医药大学和海淀卫校的临床教学及实习任务。"
    h7._id =Laniakea.Collection.Hospitals.insert(h7)
#    console.log console.log 'Seeding Hospital ' + h7.name

    h8 =
      name : "航天中心医院"
      sn: "航天中心医院"
      prov: "北京"
      city: "海淀"
      addr: "北京市海淀区玉泉路15号"
      img: ''
      phone: "010-59971199"
      rank:"三级甲等"
      desc:"航天中心医院成立于1958年，是集医教研防于一体的大型综合三级医院、北京大学临床医学院、北京急救中心西区分中心。"
    h8._id =Laniakea.Collection.Hospitals.insert(h8)
#    console.log console.log 'Seeding Hospital ' + h8.name

    h9 =
      name : "北京安贞医院"
      sn: "安贞医院"
      prov: "北京"
      city: "朝阳"
      addr: "北京市朝阳区安贞路2号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjazyy.jpg'
      phone: "010-64412431"
      rank:"三级甲等"
      desc:"安贞医院成立于1984年，北京市心肺血管疾病研究所成立于1981年，二者为一个医疗科研联合体，集医疗、教学、科研、预防、国际交流五位一体，是以治疗心肺血管疾病为重点的大型三级甲等综合性医院。"
    h9._id =Laniakea.Collection.Hospitals.insert(h9)
#    console.log console.log 'Seeding Hospital ' + h9.name

    h10 =
      name : "北京朝阳医院"
      sn: "北京朝阳医院"
      prov: "北京"
      city: "朝阳"
      addr: "北京市朝阳区工人体育场南路8号"
      img: ''
      phone: "010-85231000"
      rank:"三级甲等"
      desc:"北京朝阳医院是一所集临床、教学、科研、预防于一体的三级甲等综合医院，建于1958年，是首都医科大学第三临床医学院，'北京市呼吸病研究所'、'北京市临床检验中心'、'世界卫生组织烟草或健康合作中心'、'中华医学会高压氧学会'、'首都医科大学心血管疾病研究所'和'首都医科大学泌尿外科研究所'均设于北京朝阳医院。"
    h10._id =Laniakea.Collection.Hospitals.insert(h10)
#    console.log console.log 'Seeding Hospital ' + h10.name

    h11 =
      name : "北京大学口腔医院第五门诊部"
      sn: "北大口腔五门诊"
      prov: "北京"
      city: "朝阳"
      addr: "北京市朝阳区朝阳门外吉庆里14号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjkqdxdwmzb.jpg'
      phone: "010-65538893/0988"
      rank:"三级甲等"
      desc:"北京大学口腔医院第五门诊部是北京大学口腔医院的分支机构。 "
    h11._id =Laniakea.Collection.Hospitals.insert(h11)
#    console.log console.log 'Seeding Hospital ' + h11.name

    h12 =
      name : "北京市中关村医院"
      sn: "中关村医院"
      prov: "北京"
      city: "海淀"
      addr: "北京市海淀区海淀中关村南路12号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjszgcyy.jpg'
      phone: "010-82548888"
      rank:"二级甲等"
      desc:"中关村医院注重医疗设备的引进和投资，拥有万元以上设备100余件，核磁共振、全身螺旋CT、数字化X线摄影机、C型臂X光机、彩色多普勒超声诊断仪、骨密度检测仪、全自动大型生化分析仪、多项肿瘤检测、高压氧舱等设备，有效地提高了临床诊断及辅助科室检查和治疗水平。"
    h12._id =Laniakea.Collection.Hospitals.insert(h12)
#    console.log console.log 'Seeding Hospital ' + h12.name

    h13 =
      name : "北京老年医院"
      sn: "北京老年医院"
      prov: "北京"
      city: "海淀"
      addr: "北京海淀区温泉路118号"
      img: ''
      phone: "010-62402818"
      rank:"三级甲等"
      desc:"北京老年医院是由北京胸科医院转建而来，北京胸科医院是由成立于1949年中共中央华北局干部疗养院沿革而来。"
    h13._id =Laniakea.Collection.Hospitals.insert(h13)
#    console.log console.log 'Seeding Hospital ' + h13.name

    h14 =
      name : "北京大学第一医院"
      sn: "北大医院"
      prov: "北京"
      city: "西城"
      addr: "北京市西城区西什库大街8号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjdxdyyy.jpg'
      phone: "010-83572211"
      rank:"三级甲等"
      desc:"北大医院是北京大学第一医院的简称，是一所融医疗、教学、科研、预防为一体的大型三甲综合性医院。院区分为：北大医院(西城区西什库大街8号)北大妇产儿童医院(西安门大街1号)。"
    h14._id =Laniakea.Collection.Hospitals.insert(h14)
#    console.log console.log 'Seeding Hospital ' + h14.name

    h15 =
      name : "北京大学人民医院"
      sn: "北大人民医院"
      prov: "北京"
      city: "西城"
      addr: "北京市西城区西直门南大街11号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjdxrmyy.jpg'
      phone: "010-88326666(新院)/010-66583666(老院)"
      rank:"三级甲等"
      desc:"北京大学人民医院创建于1918年，是中国人自行筹资建设和管理的第一家综合性西医医院，最初命名为“北京中央医院”，中国现代医学先驱伍连德博士任首任院长。"
    h15._id =Laniakea.Collection.Hospitals.insert(h15)
#    console.log console.log 'Seeding Hospital ' + h15.name

    h16 =
      name : "北京积水潭医院"
      sn: "积水潭医院"
      prov: "北京"
      city: "西城"
      addr: "北京市西城区新街口东街31号"
      img: ''
      phone: ",010-58516688"
      rank:"三级甲等"
      desc:"积水潭医院以显著的医疗特色和医、教、研、防实力成为北京大学第四临床医学院。其脊柱外科、创伤骨科、矫形骨科、手外科、小儿骨科、骨肿瘤科、运动医学科和烧伤科的医疗技术达到世界及国内领先水平，医院设有北京市创伤骨科研究所、北京市烧伤研究所，北京市手外科研究所、北京创伤烧伤抢救中心、北京市骨科疾病研究治疗中心，全国计算机辅助外科学会和计算机辅助外科研究和应用中心也设在该院。"
    h16._id =Laniakea.Collection.Hospitals.insert(h16)
#    console.log console.log 'Seeding Hospital ' + h16.name

    h17 =
      name : "北京阜外医院"
      sn: "阜外医院"
      prov: "北京"
      city: "西城"
      addr: "北京市西城区北礼士路167号"
      img: ''
      phone: "010-88398866,68314466"
      rank:"三级甲等"
      desc:"北京阜外医院（全名：中国医学科学院阜外心血管病医院）的前身是解放军胸科医院，始建于1956年，心血管病研究所始建于1962年，由我国胸心外科的奠基人之一吴英恺院士一手创办。北京阜外医院、心血管病研究所是隶属于卫生部、中国医学科学院、中国协和医科大学的三级甲等心血管病专科医院。"
    h17._id =Laniakea.Collection.Hospitals.insert(h17)
#    console.log console.log 'Seeding Hospital ' + h17.name

    h18 =
      name : "中国人民解放军第二炮兵总医院"
      sn: "二炮总医院"
      prov: "北京"
      city: "西城"
      addr: "北京市西城区新街口外大街16号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/zgrmjfjdepbzyy.jpg'
      phone: "010-66343114"
      rank:"三级甲等"
      desc:"二炮总医院、262医院全称中国人民解放军第二炮兵总医院，于1956年3月16日正式收治病人，是一所集医疗、教学、科研、预防、保健、康复为一体的现代化综合性三级甲等医院。"
    h18._id =Laniakea.Collection.Hospitals.insert(h18)
#    console.log console.log 'Seeding Hospital ' + h18.name

    h19 =
      name : "北京市第二医院"
      sn: "北京市第二医院"
      prov: "北京"
      city: "西城"
      addr: "北京西城区宣内大街油坊胡同36号"
      img: ''
      phone: "010-66061122"
      rank:"二级甲等"
      desc:"北京市第二医院始建于1945年位于西城区宣内大街油坊胡同36号的北京市第二医院，已发展成为集医、教、研、防多功能和政府定点体检功能为一体的二甲综合医院，下设西长安街社区卫生服务中心与三个社区站。2001年增冠西城区老年医院之名，突现老年医疗服务特色。"
    h19._id =Laniakea.Collection.Hospitals.insert(h19)
#    console.log console.log 'Seeding Hospital ' + h19.name

    h20 =
      name : "北京友谊医院"
      sn: "北京友谊医院"
      prov: "北京"
      city: "西城"
      addr: "北京市西城区永安路95号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjyyyy.jpg'
      phone: "010-63014411"
      rank:"三级甲等"
      desc:"首都医科大学附属北京友谊医院原名为北京苏联红十字医院，始建于1952年。是新中国成立后，在苏联政府和苏联红十字会援助下，由中国政府建立的第一所大医院。1954年，医院从甘水桥旧址迁入现址。毛泽东主席、刘少奇副主席、周恩来总理、朱德委员长特为医院亲笔题词。1957年3月，苏联政府将医院正式移交中国，周总理亲自来院参加了移交仪式。1970年，周总理亲自为医院定名为“北京友谊医院”。"
    h20._id =Laniakea.Collection.Hospitals.insert(h20)
#    console.log console.log 'Seeding Hospital ' + h20.name

    h21 =
      name : "北京儿童医院"
      sn: "北京儿童医院"
      prov: "北京"
      city: "西城"
      addr: "北京市西城区南礼士路56号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjetyy.jpg'
      phone: "010-59616161"
      rank:"三级甲等"
      desc:"北京儿童医院是我国目前规模最大的综合性儿科医院。成立于1942年，由我国现代儿科医学奠基人诸福棠教授创建了北平私立儿童医院--北京儿童医院前身。 "
    h21._id =Laniakea.Collection.Hospitals.insert(h21)
#    console.log console.log 'Seeding Hospital ' + h21.name

    h22 =
      name : "北京协和医院"
      sn: "北京协和医院"
      prov: "北京"
      city: "东城"
      addr: "东城区东单帅府园1号(东院);西城区大木仓胡同41号(西院)"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjxhyy.jpg'
      phone: "010-69156114"
      rank:"三级甲等"
      desc:"北京协和医院是综合实力非常出众的三级甲等医院，在百姓心目中可谓是中国医院第一家。北京协和医院与原北京邮电医院合并后分为东西二院：北京协和医院东院、北京协和医院西院。"
    h22._id =Laniakea.Collection.Hospitals.insert(h22)
#    console.log console.log 'Seeding Hospital ' + h22.name

    h23 =
      name : "北京天坛医院"
      sn: "北京天坛医院"
      prov: "北京"
      city: "东城"
      addr: "北京市东城区天坛西里6号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjttyy.jpg'
      phone: "010-67096611"
      rank:"三级甲等"
      desc:"首都医科大学附属北京天坛医院始建于1956年8月23日，是一所以神经外科为先导，神经科学为特色，集医、教、研、防为一体的三级甲等综合性医院。是世界三大神经外科研究中心之一、亚洲的神经外科临床、科研、教学基地。医院总占地面积83900.56平方米，建筑面积 92898.56平方米，编制床位950张，临床、医技科室45个，全院职工总数2033人。"
    h23._id =Laniakea.Collection.Hospitals.insert(h23)
#    console.log console.log 'Seeding Hospital ' + h23.name

    h24 =
      name : "北京同仁医院"
      sn: "北京同仁医院"
      prov: "北京"
      city: "东城"
      addr: "北京市东城区东交民巷1号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjtryy.jpg'
      phone: "010-58269911"
      rank:"三级甲等"
      desc:"北京同仁医院是一所以眼科、耳鼻咽喉科和心血管疾病诊疗为重点的百年老院,是一家大型综合性三甲医院。"
    h24._id =Laniakea.Collection.Hospitals.insert(h24)
#    console.log console.log 'Seeding Hospital ' + h24.name

    h25 =
      name : "北京医院"
      sn: "北京医院"
      prov: "北京"
      city: "东城"
      addr: "北京市东单大华路1号"
      img: ''
      phone: "010-85133232"
      rank:"三级甲等"
      desc:"　北京医院的前身是始建1905年的德国医院，1945年北平市卫生局接管了前德国医院并更名为“市立北平医院”。1949年，中央军委卫生部带领延安中央医院和白求恩国际和平医院的医务人员接管了市立北平医院，并随着北京地名的变更改名为“北京医院”。"
    h25._id =Laniakea.Collection.Hospitals.insert(h25)
#    console.log console.log 'Seeding Hospital ' + h25.name

    h26 =
      name : "北京中医医院"
      sn: "北京中医医院"
      prov: "北京"
      city: "东城"
      addr: "北京市东城区美术馆后街23号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjzyyy.jpg'
      phone: "010-52176677"
      rank:"三级甲等"
      desc:"北京中医医院始建于1956年，是北京市唯一的一所市属综合性、现代化三级甲等中医医院。承担着北京市中医医疗、教学、科研、预防等任务。医院下设北京市中医研究所、北京市中药研究所、北京市国际针灸培训中心、北京市赵炳南皮肤病研究中心。"
    h26._id =Laniakea.Collection.Hospitals.insert(h26)
#    console.log console.log 'Seeding Hospital ' + h26.name

    h27 =
      name : "北京口腔医院"
      sn: "北京口腔医院"
      addr: "北京市东城区天坛西里4号"
      img: ''
      phone: "010-57099114"
      rank:"三级甲等"
      desc:"北京口腔医院坐落在北京市古老的天坛公园南侧，环境优美，设施齐全，承担着北京市群众口腔医疗保健和口腔卫生人才培养的任务。医院创建于1945年，经过半个多世纪的建设，特别是在改革开放以后，医院在各个方面都得到了极大的发展。"
    h27._id =Laniakea.Collection.Hospitals.insert(h27)
#    console.log console.log 'Seeding Hospital ' + h27.name

    h28 =
      name : "首都医科大学附属北京佑安医院"
      sn: "北京佑安医院"
      prov: "北京"
      city: "丰台"
      addr: "北京市丰台区右安门外西头条8号"
      img: ''
      phone: "010-83997201/83997202"
      rank:"三级甲等"
      desc:"北京佑安医院是首都医科大学附属医院暨第九临床医学院。是一所以感染和传染性疾病患者群体为服务对象的，集预防、医疗、保健、康复为一体的大型综合性专科医院。"
    h28._id =Laniakea.Collection.Hospitals.insert(h28)
#    console.log console.log 'Seeding Hospital ' + h28.name

    h29 =
      name : "北京市仁和医院"
      sn: "北京市仁和医院"
      prov: "北京"
      city: "大兴"
      addr: "北京市大兴区兴丰大街1号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjsrhyy.jpg'
      phone: "010-69242469"
      rank:"二级甲等"
      desc:"北京市仁和医院位于北京市大兴区兴丰大街1号，占地面积2.3万平方米，建筑面积3.4万平米，目前实有床位713张，是大兴地区集医疗、教学、急救、保健于一体的二级甲等综合性医院。"
    h29._id =Laniakea.Collection.Hospitals.insert(h29)
#    console.log console.log 'Seeding Hospital ' + h29.name

    h30 =
      name : "北京大学首钢医院"
      sn: "首钢医院"
      prov: "北京"
      city: "石景山"
      addr: "北京市石景山区晋元庄路9号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjdxsgyy.jpg'
      phone: "010-57830000"
      rank:"三级甲等"
      desc:"北京大学首钢医院是一所集医疗、教学、科研、预防保健为一体的三级综合医院，始建于1949年10月。医院占地面积6.56万平方米，编制床位1006张，设有36个临床科室，10个医技科室，同时还有4个社区卫生服务中心和1个慢性病防治所。"
    h30._id =Laniakea.Collection.Hospitals.insert(h30)
#    console.log console.log 'Seeding Hospital ' + h30.name

    h31 =
      name : "北京大学国际医院"
      sn: "北京大学国际医院"
      prov: "北京"
      city: "昌平"
      addr: "北京市昌平区中关村生命科学园生命园路1号"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjdxgjyy.jpg'
      phone: "010-69006666"
      rank:"三级甲等"
      desc:"北京大学国际医院座落在北京市昌平区中关村生命科学园的北京大学医疗城内，是北大医疗城的旗舰项目。医院以'建设国际一流医院，领跑医疗体制改革'为使命，由北京大学和方正集团共同投资兴建，性质为非营利性综合医院。"
    h31._id =Laniakea.Collection.Hospitals.insert(h31)
#    console.log console.log 'Seeding Hospital ' + h31.name

    h32 =
      name : "北京怀柔医院"
      sn: "北京怀柔医院"
      prov: "北京"
      city: "怀柔"
      addr: "北京市怀柔区永泰北街9号院"
      img: ''
      phone: "010-60686699"
      rank:"二级甲等"
      desc:"北京怀柔医院成立于1956年，是怀柔地区最大的集医疗、教学、科研、预防为一体的二级甲等综合医院。占地面积26680平方米，建筑面积34632平方米,固定资产1.79亿元。主要承担怀柔及周边地区的医疗保健、急诊急救及科研教学任务。 "
    h32._id =Laniakea.Collection.Hospitals.insert(h32)
#    console.log console.log 'Seeding Hospital ' + h32.name

    h33 =
      name : "北京清华长庚医院"
      sn: "北京清华长庚医院"
      prov: "北京"
      city: "昌平区"
      addr: "北京市昌平区地铁站南边。"
      img: 'http://mimas-img.oss-cn-beijing.aliyuncs.com/bjdxgjyy.jpg'
      phone: "010-56118899(总机)"
      rank:"三级甲等"
      desc:"北京清华长庚医院是由台塑关系企业和台湾长庚纪念医院捐建、支援，清华大学与北京市共同管理的大型综合性公立医院。医院座落于北京市昌平区天通苑地区，占地面积94800平方米，总建筑面积22.5万平方米，总规划床位1500床。"
      deps:[]
    h33._id =Laniakea.Collection.Hospitals.insert(h33)
#    console.log console.log 'Seeding Hospital ' + h33.name

    return [h0, h1,h2,h3,h4,h33]

