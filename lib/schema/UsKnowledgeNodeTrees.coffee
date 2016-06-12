#console.log 'Loading usKnowledgeNodeTrees.coffee'

## 本数据库涉及到的几个Colleciotn首先列出
##  COLLECTION
@Laniakea.Collection.usKnowledgeNodeTrees = new Mongo.Collection ("usKnowledgeNodeTrees")

##  INDEX
if Meteor.isServer
  @Laniakea.Collection.usKnowledgeNodeTrees._ensureIndex {si: 1}

##  SCHEMA

@Laniakea.Schema.usKnowledgeNodeTree = new SimpleSchema
  name:
    type: String
    label: '名称'
    optional: false

  find:
    type: String
    label: "超声所见"
    optional: true

  hint:
    type: String,
    label: '超声所得'
    optional: true

  owner:
    type: String
    label: '拥有者'
    optional: true

  attr:
    type: String
    label: '属性'
    optional: true
    allowedValues: ["public", "private"]
    autoform:
      afFieldInput:
        type:'select-radio-inline'

  children:
    type: [String]
    label: '子集'
    optional: true

  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['name'])

Laniakea.Collection.usKnowledgeNodeTrees.attachSchema Laniakea.Schema.usKnowledgeNodeTree


##PUBLISH
if Meteor.isServer
  Meteor.publish 'usKnowledgeNodeTrees', (selector, options)->
    if selector?.si
      selector.si = new RegExp(selector.si, 'i')
    options['fields'] =
      name: 1
      si: 1
    Laniakea.Collection.usKnowledgeNodeTrees.find selector, options

  Meteor.publish 'singleusKnowledgeNodeTree', (id)->
    Laniakea.Collection.usKnowledgeNodeTrees.find id

#PERIMISSION
Laniakea.Collection.usKnowledgeNodeTrees.allow
  insert: ->
    true
  remove: ->
    true
  update: ->
    true

# 演示数据及生成脚本
##SEED
@Laniakea.Seed.UsKnowledgeTreesSeeding = (docs) ->
  if Laniakea.Collection.usKnowledgeNodeTrees.find({}).count() is 0

    tr1 =
      name: '正常膀胱'
      find: '膀胱：充盈良好(过度,欠佳,未充盈)，壁厚度正常，光滑，内未见明显异常回声。 '
      hint: '膀胱声像图未见明显异常'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr1._id = Laniakea.Collection.usKnowledgeNodeTrees.insert(tr1)

    tr2 =
      name: '膀胱结石'
      find: '膀胱：充盈良好(过度,欠佳,未充盈)，壁厚度(正常,增厚)，稍毛糙，腔内可见(单,多)个强回声团，后伴声影，最大直径cm，随体位改变可移动。 '
      hint: '膀胱结石'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr2._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr2

    tr3 =
      name: '膀胱癌'
      find: '膀胱：充盈良好(过度,欠佳,未充盈)，壁厚度(正常,增厚)，(光滑,毛糙)，腔内透声好，于(左,右,前,后)壁上可见一(强,稍强,低)回声突起，大小cm，基底较宽，形态不规则，CDFI示其内(可见,未见)血流信号。 '
      hint: '膀胱癌'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr3._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr3

    tr4 =
      name: '膀胱憩室'
      find: ' 膀胱：充盈良好(过度,欠佳,未充盈)，壁厚度(正常,增厚)，(光滑,毛糙)，腔内透声好，于(左,右,前,后)壁可见一囊性结构突向膀胱腔外，大小约cm，与膀胱相延，相通处范围约×cm。 '
      hint: '膀胱憩室'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr4._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr4

    tr5 =
      name: '脐尿管囊肿'
      find: ' 下腹部自脐至膀胱中线部位，膀胱前上方可见无回声囊性肿物，范围约为×cm，与脐部及膀胱均不相连，位于腹横筋膜深部及腹膜前脂肪层之间，形态规整，边界清晰，囊内可见细小点状回声。 '
      hint: '脐尿管囊肿'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr5._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr5

    tr6 =
      name: '输尿管囊肿'
      find: ' 膀胱充盈好，于(1,左侧,右侧,)输尿管开口处见一囊肿，大小(100, , )cm，输尿管扩张，内径(101, , )cm，。'
      hint: '(1,左侧,右侧,)输尿管囊肿'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr6._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr6

    tr7 =
      name: '脐尿管瘘'
      find: ' 脐下正中腹壁深部，位于膀胱定与脐部之间可见一管状无回声相连通，范围约为×cm，管道走行于腹白线与腹膜之间，探头加压管状无回声中部，可见液体从脐部渗出，管状无回声的粗细随膀胱的充盈与排空发生改变。 '
      hint: '脐尿管瘘'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr7._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr7

    tr0 =
      name: '泌尿系'
      owner: docs[0]._id
      attr: 'public'
      children:[tr1._id, tr2._id, tr3._id, tr4._id, tr5._id, tr6._id, tr7._id]
    Laniakea.Collection.usKnowledgeNodeTrees.insert tr0

    tr8 =
      name: '肝脏、胆囊、脾脏'
      find: '　　肝脏：体积正常，形态规整，包膜光滑，实质回声均匀，肝内管道结构清晰。肝内胆管无扩张。门静脉内径正常。 　　胆囊：体积正常，形态规整，壁光滑，腔内透声好，内未见明显异常回声。胆总管无扩张。 　　脾脏：厚：cm。体积正常，形态规整，包膜光滑，实质回声均匀。 '
      hint: '肝脏、胆囊、脾脏声像图未见明显异常'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr8._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr8

    tr18 =
      name: '肝脏、胆囊、胰腺、脾脏、双肾'
      find: '　　肝脏：体积正常，形态规整，包膜光滑，实质回声均匀，肝内管道结构清晰。肝内胆管无扩张。门静脉内径正常。 　　胆囊：体积正常，形态规整，壁光滑，腔内透声好，内未见明显异常回声。胆总管无扩张。 　　胰腺：体积正常，形态规整，实质回声均匀，主胰管不扩张。 　　脾脏：体积正常，形态规整，包膜光滑，实质回声均匀。 肾脏：双肾体积正常，形态规整，实质厚度正常，回声正常，皮髓质界限清晰，集合系统未探及分离。 '
      hint: '肝脏、胆囊、胰腺、脾脏、双肾声像图未见明显异常'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr18._id = Laniakea.Collection.UsKnowledgeNodes.insert tr18

    tr19 =
      name: '肝脏、胆囊、胰腺、脾脏、双肾、腹腔'
      find: '　　肝脏：体积正常，形态规整，包膜光滑，实质回声均匀，肝内管道结构清晰。肝内胆管无扩张。门静脉内径正常。 　　胆囊：体积正常，形态规整，壁光滑，腔内透声好，内未见明显异常回声。胆总管无扩张。 　　胰腺：体积正常，形态规整，实质回声均匀，主胰管不扩张。 　　脾脏：体积正常，形态规整，包膜光滑，实质回声均匀。 肾脏：双肾体积正常，形态规整，实质厚度正常，回声正常，皮髓质界限清晰，集合系统未探及分离。 平卧位：腹腔扫查未探及明显游离液体。 '
      hint: '肝脏、胆囊、胰腺、脾脏、双肾声像图未见明显异常'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr19._id = Laniakea.Collection.UsKnowledgeNodes.insert tr19

    tr20 =
      name: '脂肪肝（轻度）'
      find: ' 肝脏：体积正常，形态规整，包膜光滑，实质回声细密增强，肝内管道结构欠清晰。肝内胆管无扩张。门静脉内径正常。'
      hint: '脂肪肝（轻度）'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr20._id = Laniakea.Collection.UsKnowledgeNodes.insert tr20

    tr21 =
      name: '脂肪肝（非均质性）'
      find: ' 肝脏：体积正常，形态规整，包膜光滑，实质回声细密增强，分布不均匀，于肝(左,右)叶内见一偏低回声区，形态欠规则，边界尚清晰，范围×cm，肝内管道结构不清晰。肝内胆管无扩张。门静脉内径正常。'
      hint: '脂肪肝（非均质性）'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr21._id = Laniakea.Collection.UsKnowledgeNodes.insert tr21

    tr22 =
      name: '脂肪肝（重度）'
      find: ' 肝脏：体积正常，形态规整，包膜光滑，实质回声细密增强，后场声衰减，肝肾反差大，肝内管道结构不清晰。肝内胆管无扩张。门静脉内径正常。'
      hint: '脂肪肝（重度）'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr22._id = Laniakea.Collection.UsKnowledgeNodes.insert tr22

    tr01 =
      name: '腹部正常'
      owner: docs[0]._id
      attr: 'public'
      children:[tr8._id, tr18._id, tr19._id]
    Laniakea.Collection.usKnowledgeNodeTrees.insert tr01

    tr02 =
      name: '肝脏病变'
      owner: docs[0]._id
      attr: 'public'
      children:[tr20._id, tr21._id, tr22._id]
    Laniakea.Collection.usKnowledgeNodeTrees.insert tr02

    tr03 =
      name: '腹部'
      owner: docs[0]._id
      attr: 'public'
      children:[tr01._id, tr02._id]
    Laniakea.Collection.usKnowledgeNodeTrees.insert tr03

    tr9 =
      name: '正常甲状旁腺'
      find: '甲状旁腺体积正常，大小约0.5cm×0.3cm×0.1cm，形态规整，呈类圆形，边界清晰，包膜光滑，内部为低回声，分布均匀。CDFI示：甲状旁腺未见明显血流信号。'
      hint: '甲状旁腺区声像图未见明显异常'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr9._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr9

    tr10 =
      name: '甲状旁腺增生'
      find: '甲状旁腺体积增大，大小约cm×cm×cm，呈双侧，形态饱满，内部呈(均匀性低回声,稍强回声)。CDFI示：甲状旁腺内可见较丰富血流信号。'
      hint: '甲状旁腺多发低回声 考虑甲状旁腺增生可能'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr10._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr10

    tr11 =
      name: '甲状旁腺腺瘤'
      find: '(左侧,右侧)甲状旁腺增大，大小约cm×cm×cm，内可见局灶性病变，病灶形态规整，(呈椭圆形,呈泪珠形)，包膜完整，内部为低回声，分布(均匀,不均匀)，较大病灶内可见(无回声区,点状强回声)。CDFI示：病灶周边及其内可见较丰富血流信号，呈环绕或深入内部。PW示：病灶内部呈高速动脉血流频谱，PSV100cm/s。'
      hint: '甲状旁腺区占位性病变 甲状腺旁腺腺瘤可能'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr11._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr11

    tr12 =
      name: '甲状旁腺癌'
      find: '甲状腺单个增大，内部可见病灶病变，大小约cm×cm×cm，形态不规则，呈分叶状；包膜不完整，边界不清晰，向周围组织侵润；内部回声减低，分布不均匀，可见(强回声区,无回声区)。CDFI示：病灶周边及内部可见较丰富血流信号，呈环绕或深入内部。PW：病灶内部呈高速动脉血流频谱。 颈部可见增大淋巴结，其短径（s）/（L）大于0.5。'
      hint: '甲状旁腺区占位性病变 考虑甲状旁腺癌可能伴颈部淋巴结肿大 建议超声引导下穿刺活检'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr12._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr12

    tr13 =
      name: '正常腮腺'
      find: '双侧腮腺对称，形态规整，边界清晰，内部呈细密中等回声，分布均匀，内未见导管扩张。左侧腮腺厚约1.0cm，右侧腮腺厚约0.9cm。CDFI：双侧腮腺内可见星点状血流信号。'
      hint: '双侧腮腺声像图未见明显异常'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr13._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr13

    tr14 =
      name: '正常颌下腺'
      find: '双侧颌下腺对称，形态规整，边界清晰，内部呈中等回声，分布均匀，较周围软组织回声稍强，内未见导管扩张。左侧腮腺厚约1.2cm，右侧腮腺厚约1.2cm。CDFI：双侧颌下腺浅部内面部静脉血流信号。'
      hint: '双侧颌下腺声像图未见明显异常'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr14._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr14

    tr15 =
      name: '多形性腺瘤'
      find: '(左侧,右侧)腮腺较健侧体积增大，形态失常，(左侧,右侧)腮腺内可见实性低回声团块，大小为cm×cm，形态规整，边界清晰，可见包膜回声，内部呈均匀低回声。(左侧,右侧)颈部探及肿大淋巴结回声，长径/横径>2，髓质均匀性扩大。CDFI：肿块周围探及包绕其动脉血流信号。'
      hint: '(左侧,右侧)腮腺实性占位性病变（考虑多形性腺瘤）淋巴结肿大'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr15._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr15

    tr16 =
      name: '急性涎腺炎'
      find: '(左侧,右侧)腮腺腺体增大，形态饱满，前后径约cm，包膜光滑，分布不均匀，内可见小片状散在低回声。腮腺后方回声无衰减。CDFI示：彩色血流信号明显增多，丰富。(左侧,右侧)腮腺大小正常，前后径约cm，腮腺内导管未见扩张，内回声未见明显异常。'
      hint: '(左侧,右侧)腮腺增大 回声不均 考虑急性腮腺炎可能'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr16._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr16

    tr17 =
      name: '慢性涎腺炎'
      find: ' (左侧,右侧)涎腺炎腺体增大，前后径约cm，边界不清晰，形态不规则，内部回声减低，增粗不均匀，探头加压有压痛。其内可见散在(条索状强回声,呈囊状扩张的腺管,涎腺内可见导管扩张,内可见强回声团块)，CDFI：(左侧,右侧)涎腺腺体内血流信号弥漫性增多。'
      hint: '(左侧,右侧)涎腺体积增大（伴导管结石形成） 考虑慢性涎腺炎可能'
      owner: docs[0]._id
      attr: 'public'
      children:[]
    tr17._id = Laniakea.Collection.usKnowledgeNodeTrees.insert tr17

    tr04 =
      name: '甲状旁腺'
      owner: docs[0]._id
      attr: 'public'
      children:[tr9._id, tr10._id, tr11._id, tr12._id]
    Laniakea.Collection.usKnowledgeNodeTrees.insert tr04

    tr05 =
      name: '腮腺、颌下腺、涎腺'
      owner: docs[0]._id
      attr: 'public'
      children:[tr13._id, tr14._id, tr15._id, tr16._id, tr17._id]
    Laniakea.Collection.usKnowledgeNodeTrees.insert tr05

    tr06 =
      name: '浅表及小器官'
      owner: docs[0]._id
      attr: 'public'
      children:[tr04._id, tr05._id]
    Laniakea.Collection.usKnowledgeNodeTrees.insert tr06



