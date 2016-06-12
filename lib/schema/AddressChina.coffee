@Laniakea.Collection.AddressChina = new Mongo.Collection "addressChina"

##SCHEMA
@Laniakea.Schema.ChildAdress = new SimpleSchema(
  _id:
    type: String
    label: "名称"
  name:
    type: String
    label: "名称"
)
@Laniakea.Schema.AddressChina=new SimpleSchema(
  name:
    type: String
    label: "名称"

  sn:
    type: String
    label: "简称"
    optional: true

  code:
    type: String
    label: "代码"
    optional: true

  level:
    type:Number
    label:'级'

  si:
    type: String
    optional: true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      str = si(this,['name,sn'])
      #代码
      if this.field('code').value?
        str = str + this.filed('code').value

      if str? and str.length>0
        return str
      else
        return

  parent:
    type:String
    label: "父节点"
    optional: true

  children:
    type:[Laniakea.Schema.ChildAdress]
    optional: true
    label:'子节点'

)

Laniakea.Collection.AddressChina.attachSchema  Laniakea.Schema.AddressChina

##PUBLISH
if Meteor.isServer
  Meteor.publish 'addressChina',(selector,options)->
    unless selector
      selector = {}
#    else
#      text = selector?.text
#      selector['$or'] =[
#        'si': new RegExp(text,'i')
#      ]
#      delete selector.text
    unless options
      options = {}
    Laniakea.Collection.AddressChina.find(selector,options)

  Meteor.publish 'singleAddressChina', (id) ->
    Laniakea.Collection.AddressChina.find id

##PERIMISSION
Laniakea.Collection.AddressChina.allow
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
@Laniakea.Seed.AddressChinaSeeding = () ->
  console.log 'seed address'
  if Laniakea.Collection.AddressChina.find({}).count() < 1
#    0省
    p0 =
      name:'北京市'
      sn:'京'
      code:''
#      parent:''
      children:[]
    p0._id =Laniakea.Collection.AddressChina.insert(p0)

#    p0c0
    p0c0 =
      name:'市辖区'
      sn:''
      code:''
      parent:p0._id
      children:[]
    p0c0._id =Laniakea.Collection.AddressChina.insert(p0c0)

#    #0省0市 县:start
    p0c0c0 =
      name:'东城区'
      sn:''
      code:''
      parent:p0c0._id
      children:[]
    p0c0c0._id =Laniakea.Collection.AddressChina.insert(p0c0c0)

    p0c0c1 =
      name:'西城区'
      sn:''
      code:''
      parent:p0c0._id
      children:[]
    p0c0c1._id =Laniakea.Collection.AddressChina.insert(p0c0c1)

    p0c0c2 =
      name:'崇文区'
      sn:''
      code:''
      parent:p0c0._id
      children:[]
    p0c0c2._id =Laniakea.Collection.AddressChina.insert(p0c0c2)

    p0c0c3 =
      name:'宣武区'
      sn:''
      code:''
      parent:p0c0._id
      children:[]
    p0c0c3._id =Laniakea.Collection.AddressChina.insert(p0c0c3)

    p0c0c4 =
      name:'朝阳区'
      sn:'朝阳区'
      code:''
      parent:p0c0._id
      children:[]
    p0c0c4._id =Laniakea.Collection.AddressChina.insert(p0c0c4)

    p0c0c5 =
      name:'丰台区'
      sn:'丰台区'
      code:''
      parent:p0c0._id
      children:[]
    p0c0c5._id =Laniakea.Collection.AddressChina.insert(p0c0c5)

    p0c0c6 =
      name:'石景山区'
      sn:'石景山区'
      code:''
      parent:p0c0._id
      children:[]
    p0c0c6._id =Laniakea.Collection.AddressChina.insert(p0c0c6)

    p0c0c7 =
      name:'海淀区'
      sn:'海淀区'
      code:''
      parent:p0c0._id
      children:[]
    p0c0c7._id =Laniakea.Collection.AddressChina.insert(p0c0c7)

    p0c0c8 =
      name:'门头沟区'
      sn:'门头沟区'
      code:''
      parent:p0c0._id
      children:[]
    p0c0c8._id =Laniakea.Collection.AddressChina.insert(p0c0c8)

    p0c0c9 =
      name:'房山区'
      sn:'房山区'
      code:''
      parent:p0c0._id
      children:[]
    p0c0c9._id =Laniakea.Collection.AddressChina.insert(p0c0c9)

    p0c0c10 =
      name:'通州区'
      sn:'通州区'
      code:''
      parent:p0c0._id
      children:[]
    p0c0c10._id =Laniakea.Collection.AddressChina.insert(p0c0c10)

    p0c0c11 =
      name:'顺义区'
      sn:'顺义区'
      code:''
      parent:p0c0._id
      children:[]
    p0c0c11._id =Laniakea.Collection.AddressChina.insert(p0c0c11)

    p0c0c12 =
      name:'昌平区'
      sn:'昌平区'
      code:''
      parent:p0c0._id
      children:[]
    p0c0c12._id =Laniakea.Collection.AddressChina.insert(p0c0c12)

    p0c0c13 =
      name:'大兴区'
      sn:'大兴区'
      code:''
      parent:p0c0._id
      children:[]
    p0c0c13._id =Laniakea.Collection.AddressChina.insert(p0c0c13)

    p0c0c14 =
      name:'平谷区'
      sn:'平谷区'
      code:''
      parent:p0c0._id
      children:[]
    p0c0c14._id =Laniakea.Collection.AddressChina.insert(p0c0c14)

    p0c0c15 =
      name:'怀柔区'
      sn:'怀柔区'
      code:''
      parent:p0c0._id
      children:[]
    p0c0c15._id =Laniakea.Collection.AddressChina.insert(p0c0c15)

    children1=[p0c0c0._id,p0c0c1._id,p0c0c2._id,p0c0c3._id,p0c0c4._id,p0c0c5._id,
               p0c0c6._id,p0c0c7._id,p0c0c8._id,p0c0c9._id,p0c0c10._id,p0c0c11._id,
               p0c0c12._id,p0c0c13._id,p0c0c14._id,p0c0c15._id]
    Laniakea.Collection.AddressChina.update({_id:p0c0._id},{$set:{'children':children1}})


    #   p0c1------------------------------------------------------------------------
    p0c1 =
      name:'市辖县'
      sn:'市辖县'
      code:''
      parent:p0._id
      children:[]
    p0c1._id =Laniakea.Collection.AddressChina.insert(p0c1)


    p0c0c16 =
      name:'密云县'
      sn:'密云县'
      code:''
      parent:p0c1._id
      children:[]
    p0c0c16._id =Laniakea.Collection.AddressChina.insert(p0c0c16)

    p0c0c17 =
      name:'延庆县'
      sn:'延庆县'
      code:''
      parent:p0c1._id
      children:[]
    p0c0c17._id =Laniakea.Collection.AddressChina.insert(p0c0c17)

    children2=[p0c0c16._id,p0c0c17._id]
    Laniakea.Collection.AddressChina.update({_id:p0c1._id},{$set:{'children':children2}})
    Laniakea.Collection.AddressChina.update({_id:p0._id},{$set:{'children':[p0c0._id,p0c1._id]}})

#    2 ##############################################################################################################################
    p1 =
      name:'天津市'
      sn:'津'
      code:''
#      parent:''
      children:[]
    p1._id =Laniakea.Collection.AddressChina.insert(p1)

    p1c0 =
      name:'市辖区'
      sn:'市辖区'
      code:''
      parent:p1._id
      children:[]
    p1c0._id =Laniakea.Collection.AddressChina.insert(p1c0)

    #    #1省0市 县:start
    p1c0c0 =
      name:'和平区'
      sn:'和平区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c0._id =Laniakea.Collection.AddressChina.insert(p1c0c0)

    p1c0c1 =
      name:'河东区'
      sn:'河东区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c1._id =Laniakea.Collection.AddressChina.insert(p1c0c1)

    p1c0c2 =
      name:'河西区'
      sn:'河西区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c2._id =Laniakea.Collection.AddressChina.insert(p1c0c2)

    p1c0c3 =
      name:'南开区'
      sn:'南开区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c3._id =Laniakea.Collection.AddressChina.insert(p1c0c3)

    p1c0c4 =
      name:'河北区'
      sn:'河北区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c4._id =Laniakea.Collection.AddressChina.insert(p1c0c4)

    p1c0c5 =
      name:'红桥区'
      sn:'红桥区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c5._id =Laniakea.Collection.AddressChina.insert(p1c0c5)

    p1c0c6 =
      name:'塘沽区'
      sn:'塘沽区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c6._id =Laniakea.Collection.AddressChina.insert(p1c0c6)

    p1c0c7 =
      name:'汉沽区'
      sn:'汉沽区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c7._id =Laniakea.Collection.AddressChina.insert(p1c0c7)

    p1c0c8 =
      name:'大港区'
      sn:'大港区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c8._id =Laniakea.Collection.AddressChina.insert(p1c0c8)

    p1c0c9 =
      name:'东丽区'
      sn:'东丽区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c9._id =Laniakea.Collection.AddressChina.insert(p1c0c9)

    p1c0c10 =
      name:'西青区'
      sn:'西青区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c10._id =Laniakea.Collection.AddressChina.insert(p1c0c10)

    p1c0c11 =
      name:'津南区'
      sn:'津南区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c11._id =Laniakea.Collection.AddressChina.insert(p1c0c11)

    p1c0c12 =
      name:'北辰区'
      sn:'北辰区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c12._id =Laniakea.Collection.AddressChina.insert(p1c0c12)

    p1c0c13 =
      name:'武清区'
      sn:'武清区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c13._id =Laniakea.Collection.AddressChina.insert(p1c0c13)

    p1c0c14 =
      name:'宝坻区'
      sn:'宝坻区'
      code:''
      parent:p1c0._id
      children:[]
    p1c0c14._id =Laniakea.Collection.AddressChina.insert(p1c0c14)

    children1=[p1c0c0._id,p1c0c1._id,p1c0c2._id,p1c0c3._id,p1c0c4._id,p1c0c5._id,
              p1c0c6._id,p1c0c7._id,p1c0c8._id,p1c0c9._id,p1c0c10._id,p1c0c11._id,
              p1c0c12._id,p1c0c13._id,p1c0c14._id]
    Laniakea.Collection.AddressChina.update({_id:p1c0._id},{$set:{'children':children1}})


#    p1c1------------------------------------------------------------------
    p1c1 =
      name:'市辖县'
      sn:'市辖县'
      code:''
      parent:p1._id
      children:[]
    p1c1._id =Laniakea.Collection.AddressChina.insert(p1c1)


    p1c0c15 =
      name:'宁河县'
      sn:'宁河县'
      code:''
      parent:p1c1._id
      children:[]
    p1c0c15._id =Laniakea.Collection.AddressChina.insert(p1c0c15)

    p1c0c16 =
      name:'静海县'
      sn:'静海县'
      code:''
      parent:p1c1._id
      children:[]
    p1c0c16._id =Laniakea.Collection.AddressChina.insert(p1c0c16)

    p1c0c17 =
      name:'蓟县'
      sn:'蓟县'
      code:''
      parent:p1c1._id
      children:[]
    p1c0c17._id =Laniakea.Collection.AddressChina.insert(p1c0c17)

    children2=[p1c0c15._id,p1c0c16._id,p1c0c17._id]
    Laniakea.Collection.AddressChina.update({_id:p1c1._id},{$set:{'children':children2}})

    Laniakea.Collection.AddressChina.update({_id:p1._id},{$set:{'children':[p1c0._id,p1c1._id]}})

    #    3 ########################################################################################################3
    p2 =
      name:'上海市'
      sn:'沪'
      code:''
#      parent:''
      children:[]
    p2._id =Laniakea.Collection.AddressChina.insert(p2)

    p2c0 =
      name:'市辖区'
      sn:'市辖区'
      code:''
      parent:p2._id
      children:[]
    p2c0._id =Laniakea.Collection.AddressChina.insert(p2c0)

    #    #2省0市 县:start
    p2c0c0 =
      name:'浦东新区'
      sn:'浦东新区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c0._id =Laniakea.Collection.AddressChina.insert(p2c0c0)

    p2c0c1 =
      name:'徐汇区'
      sn:'徐汇区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c1._id =Laniakea.Collection.AddressChina.insert(p2c0c1)

    p2c0c2 =
      name:'黄浦区'
      sn:'黄浦区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c2._id =Laniakea.Collection.AddressChina.insert(p2c0c2)

    p2c0c3 =
      name:'杨浦区'
      sn:'杨浦区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c3._id =Laniakea.Collection.AddressChina.insert(p2c0c3)

    p2c0c4 =
      name:'虹口区'
      sn:'虹口区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c4._id =Laniakea.Collection.AddressChina.insert(p2c0c4)

    p2c0c5 =
      name:'闵行区'
      sn:'闵行区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c5._id =Laniakea.Collection.AddressChina.insert(p2c0c5)

    p2c0c6 =
      name:'长宁区'
      sn:'长宁区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c6._id =Laniakea.Collection.AddressChina.insert(p2c0c6)

    p2c0c7 =
      name:'普陀区'
      sn:'普陀区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c7._id =Laniakea.Collection.AddressChina.insert(p2c0c7)

    p2c0c8 =
      name:'宝山区'
      sn:'宝山区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c8._id =Laniakea.Collection.AddressChina.insert(p2c0c8)

    p2c0c9 =
      name:'静安区'
      sn:'静安区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c9._id =Laniakea.Collection.AddressChina.insert(p2c0c9)

    p2c0c10 =
      name:'闸北区'
      sn:'闸北区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c10._id =Laniakea.Collection.AddressChina.insert(p2c0c10)

    p2c0c11 =
      name:'卢湾区'
      sn:'卢湾区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c11._id =Laniakea.Collection.AddressChina.insert(p2c0c11)

    p2c0c12 =
      name:'松江区'
      sn:'松江区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c12._id =Laniakea.Collection.AddressChina.insert(p2c0c12)

    p2c0c13 =
      name:'嘉定区'
      sn:'嘉定区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c13._id =Laniakea.Collection.AddressChina.insert(p2c0c13)

    p2c0c14 =
      name:'南汇区'
      sn:'南汇区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c14._id =Laniakea.Collection.AddressChina.insert(p2c0c14)

    p2c0c15 =
      name:'金山区'
      sn:'金山区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c15._id =Laniakea.Collection.AddressChina.insert(p2c0c15)

    p2c0c16 =
      name:'青浦区'
      sn:'青浦区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c16._id =Laniakea.Collection.AddressChina.insert(p2c0c16)

    p2c0c17 =
      name:'奉贤区'
      sn:'奉贤区'
      code:''
      parent:p2c0._id
#      children:[]
    p2c0c17._id =Laniakea.Collection.AddressChina.insert(p2c0c17)

    children1=[p2c0c0._id,p2c0c1._id,p2c0c2._id,p2c0c3._id,p2c0c4._id,p2c0c5._id,
              p2c0c6._id,p2c0c7._id,p2c0c8._id,p2c0c9._id,p2c0c10._id,p2c0c11._id,
              p2c0c12._id,p2c0c13._id,p2c0c14._id,p2c0c15._id,p2c0c16._id,p2c0c17._id]
    Laniakea.Collection.AddressChina.update({_id:p2c0._id},{$set:{'children':children1}})



#   p2c1----------------------------------------------------------------------------
    p2c1 =
      name:'市辖县'
      sn:'市辖县'
      code:''
      parent:p2._id
      children:[]
    p2c1._id =Laniakea.Collection.AddressChina.insert(p2c1)


    p2c0c18 =
      name:'崇明县'
      sn:'崇明县'
      code:''
      parent:p2c1._id
    #      children:[]
    p2c0c18._id =Laniakea.Collection.AddressChina.insert(p2c0c18)

    children2=[p2c0c18._id]
    Laniakea.Collection.AddressChina.update({_id:p2c1._id},{$set:{'children':children2}})
    Laniakea.Collection.AddressChina.update({_id:p2._id},{$set:{'children':[p2c0._id,p2c1._id]}})

    #   ######################################## 4重庆市########################################3
    p3 =
      name:'重庆市'
      sn:'渝'
      code:''
#      parent:''
      children:[]
    p3._id =Laniakea.Collection.AddressChina.insert(p3)

    p3c0 =
      name:'市辖区'
      sn:'市辖区'
      code:''
      parent:p3._id
      children:[]
    p3c0._id =Laniakea.Collection.AddressChina.insert(p3c0)

    #    #3省0市 县:start
    p3c0c0 =
      name:'万州区'
      sn:'万州区'
      code:''
      parent:p3c0._id
    #      children:[]
    p3c0c0._id =Laniakea.Collection.AddressChina.insert(p3c0c0)

    p3c0c1 =
      name:'涪陵区'
      sn:'涪陵区'
      code:''
      parent:p3c0._id
    #      children:[]
    p3c0c1._id =Laniakea.Collection.AddressChina.insert(p3c0c1)

    p3c0c2 =
      name:'渝中区'
      sn:'渝中区'
      code:''
      parent:p3c0._id
    #      children:[]
    p3c0c2._id =Laniakea.Collection.AddressChina.insert(p3c0c2)

    p3c0c3 =
      name:'大渡口区'
      sn:'大渡口区'
      code:''
      parent:p3c0._id
    #      children:[]
    p3c0c3._id =Laniakea.Collection.AddressChina.insert(p3c0c3)

    p3c0c4 =
      name:'江北区'
      sn:'江北区'
      code:''
      parent:p3c0._id
    #      children:[]
    p3c0c4._id =Laniakea.Collection.AddressChina.insert(p3c0c4)

    p3c0c5 =
      name:'沙坪坝区'
      sn:'沙坪坝区'
      code:''
      parent:p3c0._id
    #      children:[]
    p3c0c5._id =Laniakea.Collection.AddressChina.insert(p3c0c5)

    p3c0c6 =
      name:'九龙坡区'
      sn:'九龙坡区'
      code:''
      parent:p3c0._id
    #      children:[]
    p3c0c6._id =Laniakea.Collection.AddressChina.insert(p3c0c6)

    p3c0c7 =
      name:'南岸区'
      sn:'南岸区'
      code:''
      parent:p3c0._id
    #      children:[]
    p3c0c7._id =Laniakea.Collection.AddressChina.insert(p3c0c7)

    p3c0c8 =
      name:'北碚区'
      sn:'北碚区'
      code:''
      parent:p3c0._id
    #      children:[]
    p3c0c8._id =Laniakea.Collection.AddressChina.insert(p3c0c8)

    p3c0c9 =
      name:'万盛区'
      sn:'万盛区'
      code:''
      parent:p3c0._id
    #      children:[]
    p3c0c9._id =Laniakea.Collection.AddressChina.insert(p3c0c9)

    p3c0c10 =
      name:'双桥区'
      sn:'双桥区'
      code:''
      parent:p3c0._id
    #      children:[]
    p3c0c10._id =Laniakea.Collection.AddressChina.insert(p3c0c10)

    p3c0c11 =
      name:'渝北区'
      sn:'渝北区'
      code:''
      parent:p3c0._id
    #      children:[]
    p3c0c11._id =Laniakea.Collection.AddressChina.insert(p3c0c11)

    p3c0c12 =
      name:'巴南区'
      sn:'巴南区'
      code:''
      parent:p3c0._id
    #      children:[]
    p3c0c12._id =Laniakea.Collection.AddressChina.insert(p3c0c12)

    children1=[p3c0c0._id,p3c0c1._id,p3c0c2._id,p3c0c3._id,p3c0c4._id,p3c0c5._id,
               p3c0c6._id,p3c0c7._id,p3c0c8._id,p3c0c9._id,p3c0c10._id,p3c0c11._id,
               p3c0c12._id]
    Laniakea.Collection.AddressChina.update({_id:p3c0._id},{$set:{'children':children1}})

#     p3c1 ---------------------------------------------------------------
    p3c1 =
      name:'市辖县'
      sn:'市辖县'
      code:''
      parent:p3._id
      children:[]
    p3c1._id =Laniakea.Collection.AddressChina.insert(p3c1)

    p3c0c13 =
      name:'长寿县'
      sn:'长寿县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c13._id =Laniakea.Collection.AddressChina.insert(p3c0c13)

    p3c0c14 =
      name:'綦江县'
      sn:'綦江县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c14._id =Laniakea.Collection.AddressChina.insert(p3c0c14)

    p3c0c15 =
      name:'潼南县'
      sn:'潼南县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c15._id =Laniakea.Collection.AddressChina.insert(p3c0c15)

    p3c0c16 =
      name:'铜梁县'
      sn:'铜梁县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c16._id =Laniakea.Collection.AddressChina.insert(p3c0c16)

    p3c0c17 =
      name:'大足县'
      sn:'大足县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c17._id =Laniakea.Collection.AddressChina.insert(p3c0c17)

    p3c0c18 =
      name:'荣昌县'
      sn:'荣昌县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c18._id =Laniakea.Collection.AddressChina.insert(p3c0c18)

    p3c0c19 =
      name:'璧山县'
      sn:'璧山县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c19._id =Laniakea.Collection.AddressChina.insert(p3c0c19)

    p3c0c20 =
      name:'梁平县'
      sn:'梁平县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c20._id =Laniakea.Collection.AddressChina.insert(p3c0c20)

    p3c0c21 =
      name:'城口县'
      sn:'城口县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c21._id =Laniakea.Collection.AddressChina.insert(p3c0c21)

    p3c0c22 =
      name:'丰都县'
      sn:'丰都县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c22._id =Laniakea.Collection.AddressChina.insert(p3c0c22)

    p3c0c23 =
      name:'垫江县'
      sn:'垫江县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c23._id =Laniakea.Collection.AddressChina.insert(p3c0c23)

    p3c0c24 =
      name:'武隆县'
      sn:'武隆县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c24._id =Laniakea.Collection.AddressChina.insert(p3c0c24)

    p3c0c25 =
      name:'忠县'
      sn:'忠县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c25._id =Laniakea.Collection.AddressChina.insert(p3c0c25)

    p3c0c26 =
      name:'开县'
      sn:'开县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c26._id =Laniakea.Collection.AddressChina.insert(p3c0c26)

    p3c0c27 =
      name:'云阳县'
      sn:'云阳县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c27._id =Laniakea.Collection.AddressChina.insert(p3c0c27)

    p3c0c28 =
      name:'奉节县'
      sn:'奉节县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c28._id =Laniakea.Collection.AddressChina.insert(p3c0c28)

    p3c0c29 =
      name:'巫山县'
      sn:'巫山县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c29._id =Laniakea.Collection.AddressChina.insert(p3c0c29)

    p3c0c30 =
      name:'巫溪县'
      sn:'巫溪县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c30._id =Laniakea.Collection.AddressChina.insert(p3c0c30)

    p3c0c31 =
      name:'黔江土家族苗族自治县'
      sn:'黔江土家族苗族自治县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c31._id =Laniakea.Collection.AddressChina.insert(p3c0c31)

    p3c0c32 =
      name:'石柱土家族自治县'
      sn:'石柱土家族自治县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c32._id =Laniakea.Collection.AddressChina.insert(p3c0c32)

    p3c0c33 =
      name:'秀山土家族苗族自治县'
      sn:'秀山土家族苗族自治县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c33._id =Laniakea.Collection.AddressChina.insert(p3c0c33)

    p3c0c34 =
      name:'酉阳土家族苗族自治县'
      sn:'酉阳土家族苗族自治县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c34._id =Laniakea.Collection.AddressChina.insert(p3c0c34)

    p3c0c35 =
      name:'彭水苗族土家族自治县'
      sn:'彭水苗族土家族自治县'
      code:''
      parent:p3c1._id
    #      children:[]
    p3c0c35._id =Laniakea.Collection.AddressChina.insert(p3c0c35)

    children2=[p3c0c13._id,p3c0c14._id,p3c0c15._id,p3c0c16._id,p3c0c17._id,
               p3c0c18._id,p3c0c19._id,p3c0c20._id,p3c0c21._id,p3c0c22._id,
               p3c0c23._id,p3c0c24._id,p3c0c25._id,p3c0c26._id,p3c0c27._id]
    Laniakea.Collection.AddressChina.update({_id:p3c0._id},{$set:{'children':children2}})

#      p3c2 -------------------------------------------------------
    p3c2 =
      name:'市辖市'
      sn:'市辖市'
      code:''
      parent:p3._id
      children:[]
    p3c2._id =Laniakea.Collection.AddressChina.insert(p3c2)

    p3c0c36 =
      name:'江津市'
      sn:'江津市'
      code:''
      parent:p3c2._id
    #      children:[]
    p3c0c36._id =Laniakea.Collection.AddressChina.insert(p3c0c36)

    p3c0c37 =
      name:'合川市'
      sn:'合川市'
      code:''
      parent:p3c2._id
    #      children:[]
    p3c0c37._id =Laniakea.Collection.AddressChina.insert(p3c0c37)

    p3c0c38 =
      name:'永川市'
      sn:'永川市'
      code:''
      parent:p3c2._id
    #      children:[]
    p3c0c38._id =Laniakea.Collection.AddressChina.insert(p3c0c38)

    p3c0c39 =
      name:'南川市'
      sn:'南川市'
      code:''
      parent:p3c2._id
    #      children:[]
    p3c0c39._id =Laniakea.Collection.AddressChina.insert(p3c0c39)

    children3=[p3c0c36._id,p3c0c37._id,p3c0c38._id,p3c0c39._id]
    Laniakea.Collection.AddressChina.update({_id:p3c0._id},{$set:{'children':children3}})

    Laniakea.Collection.AddressChina.update({_id:p3._id},{$set:{'children':[p3c0._id,p3c1._id,p3c2._id]}})


@Laniakea.Seed.AddressChinaSeeding1 = () ->
  console.log 'seed address'
  if Laniakea.Collection.AddressChina.find({}).count() < 1
#    0省
    p0 =
      name:'北京'
      sn:'京'
      code:''
      level:0
#      parent:''
      children:[]
    p0._id =Laniakea.Collection.AddressChina.insert(p0)


    p0c0 =
      name:'东城'
      sn:''
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c0._id =Laniakea.Collection.AddressChina.insert(p0c0)

    p0c1 =
      name:'西城'
      sn:''
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c1._id =Laniakea.Collection.AddressChina.insert(p0c1)

    p0c2 =
      name:'崇文'
      sn:''
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c2._id =Laniakea.Collection.AddressChina.insert(p0c2)

    p0c3 =
      name:'宣武'
      sn:''
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c3._id =Laniakea.Collection.AddressChina.insert(p0c3)

    p0c4 =
      name:'朝阳'
      sn:'朝阳'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c4._id =Laniakea.Collection.AddressChina.insert(p0c4)

    p0c5 =
      name:'丰台'
      sn:'丰台'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c5._id =Laniakea.Collection.AddressChina.insert(p0c5)

    p0c6 =
      name:'石景山'
      sn:'石景山'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c6._id =Laniakea.Collection.AddressChina.insert(p0c6)

    p0c7 =
      name:'海淀'
      sn:'海淀'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c7._id =Laniakea.Collection.AddressChina.insert(p0c7)

    p0c8 =
      name:'门头沟'
      sn:'门头沟'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c8._id =Laniakea.Collection.AddressChina.insert(p0c8)

    p0c9 =
      name:'房山'
      sn:'房山'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c9._id =Laniakea.Collection.AddressChina.insert(p0c9)

    p0c10 =
      name:'通州'
      sn:'通州'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c10._id =Laniakea.Collection.AddressChina.insert(p0c10)

    p0c11 =
      name:'顺义'
      sn:'顺义'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c11._id =Laniakea.Collection.AddressChina.insert(p0c11)

    p0c12 =
      name:'昌平'
      sn:'昌平'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c12._id =Laniakea.Collection.AddressChina.insert(p0c12)

    p0c13 =
      name:'大兴'
      sn:'大兴'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c13._id =Laniakea.Collection.AddressChina.insert(p0c13)

    p0c14 =
      name:'平谷'
      sn:'平谷'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c14._id =Laniakea.Collection.AddressChina.insert(p0c14)

    p0c15 =
      name:'怀柔'
      sn:'怀柔'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c15._id =Laniakea.Collection.AddressChina.insert(p0c15)


    p0c16 =
      name:'密云'
      sn:'密云'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c16._id =Laniakea.Collection.AddressChina.insert(p0c16)

    p0c17 =
      name:'延庆'
      sn:'延庆'
      code:''
      level:1
      parent:p0._id
      children:[]
    p0c17._id =Laniakea.Collection.AddressChina.insert(p0c17)

#    children1=[p0c0._id,p0c1._id,p0c2._id,p0c3._id,p0c4._id,p0c5._id,
#               p0c6._id,p0c7._id,p0c8._id,p0c9._id,p0c10._id,p0c11._id,
#               p0c12._id,p0c13._id,p0c14._id,p0c15._id,p0c16._id,p0c17._id]
    children1=[{'_id':p0c0._id,'name':p0c0.name},{'_id':p0c1._id,'name':p0c1.name},
                {'_id':p0c2._id,'name':p0c2.name},{'_id':p0c3._id,'name':p0c3.name},
                {'_id':p0c4._id,'name':p0c4.name},{'_id':p0c5._id,'name':p0c5.name},
                {'_id':p0c6._id,'name':p0c6.name},{'_id':p0c7._id,'name':p0c7.name},
                {'_id':p0c8._id,'name':p0c8.name},{'_id':p0c9._id,'name':p0c9.name},
                {'_id':p0c10._id,'name':p0c10.name},{'_id':p0c11._id,'name':p0c11.name},
                {'_id':p0c12._id,'name':p0c12.name},{'_id':p0c13._id,'name':p0c13.name},
                {'_id':p0c14._id,'name':p0c14.name},{'_id':p0c15._id,'name':p0c15.name},
                {'_id':p0c16._id,'name':p0c16.name},{'_id':p0c17._id,'name':p0c17.name}]
    Laniakea.Collection.AddressChina.update({_id:p0._id},{$set:{'children':children1}})

    #    2 ##############################################################################################################################
    p1 =
      name:'天津'
      sn:'津'
      code:''
      level:0
#      parent:''
      children:[]
    p1._id =Laniakea.Collection.AddressChina.insert(p1)

    #    #p1c 县:start
    p1c0 =
      name:'和平'
      sn:'和平'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c0._id =Laniakea.Collection.AddressChina.insert(p1c0)

    p1c1 =
      name:'河东'
      sn:'河东'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c1._id =Laniakea.Collection.AddressChina.insert(p1c1)

    p1c2 =
      name:'河西'
      sn:'河西'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c2._id =Laniakea.Collection.AddressChina.insert(p1c2)

    p1c3 =
      name:'南开'
      sn:'南开'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c3._id =Laniakea.Collection.AddressChina.insert(p1c3)

    p1c4 =
      name:'河北'
      sn:'河北'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c4._id =Laniakea.Collection.AddressChina.insert(p1c4)

    p1c5 =
      name:'红桥'
      sn:'红桥'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c5._id =Laniakea.Collection.AddressChina.insert(p1c5)

    p1c6 =
      name:'塘沽'
      sn:'塘沽'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c6._id =Laniakea.Collection.AddressChina.insert(p1c6)

    p1c7 =
      name:'汉沽'
      sn:'汉沽'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c7._id =Laniakea.Collection.AddressChina.insert(p1c7)

    p1c8 =
      name:'大港'
      sn:'大港'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c8._id =Laniakea.Collection.AddressChina.insert(p1c8)

    p1c9 =
      name:'东丽'
      sn:'东丽'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c9._id =Laniakea.Collection.AddressChina.insert(p1c9)

    p1c10 =
      name:'西青'
      sn:'西青'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c10._id =Laniakea.Collection.AddressChina.insert(p1c10)

    p1c11 =
      name:'津南'
      sn:'津南'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c11._id =Laniakea.Collection.AddressChina.insert(p1c11)

    p1c12 =
      name:'北辰'
      sn:'北辰'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c12._id =Laniakea.Collection.AddressChina.insert(p1c12)

    p1c13 =
      name:'武清'
      sn:'武清'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c13._id =Laniakea.Collection.AddressChina.insert(p1c13)

    p1c14 =
      name:'宝坻'
      sn:'宝坻'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c14._id =Laniakea.Collection.AddressChina.insert(p1c14)

    p1c15 =
      name:'宁河'
      sn:'宁河'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c15._id =Laniakea.Collection.AddressChina.insert(p1c15)

    p1c16 =
      name:'静海'
      sn:'静海'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c16._id =Laniakea.Collection.AddressChina.insert(p1c16)

    p1c17 =
      name:'蓟县'
      sn:'蓟县'
      code:''
      level:1
      parent:p1._id
      children:[]
    p1c17._id =Laniakea.Collection.AddressChina.insert(p1c17)
#    children2=[p1c0._id,p1c1._id,p1c2._id,p1c3._id,p1c4._id,p1c5._id,
#               p1c6._id,p1c7._id,p1c8._id,p1c9._id,p1c10._id,p1c11._id,
#               p1c12._id,p1c13._id,p1c14._id,p1c15._id,p1c16._id,p1c17._id]
    children2=[{'_id':p1c0._id,'name':p1c0.name},{'_id':p1c1._id,'name':p1c1.name},
              {'_id':p1c2._id,'name':p1c2.name},{'_id':p1c3._id,'name':p1c3.name},
              {'_id':p1c4._id,'name':p1c4.name},{'_id':p1c5._id,'name':p1c5.name},
              {'_id':p1c6._id,'name':p1c6.name},{'_id':p1c7._id,'name':p1c7.name},
              {'_id':p1c8._id,'name':p1c8.name},{'_id':p1c9._id,'name':p1c9.name},
              {'_id':p1c10._id,'name':p1c10.name},{'_id':p1c11._id,'name':p1c11.name},
              {'_id':p1c12._id,'name':p1c12.name},{'_id':p1c13._id,'name':p1c13.name},
              {'_id':p1c14._id,'name':p1c14.name},{'_id':p1c15._id,'name':p1c15.name},
              {'_id':p1c16._id,'name':p1c16.name},{'_id':p1c17._id,'name':p1c17.name}]
    Laniakea.Collection.AddressChina.update({_id:p1._id},{$set:{'children':children2}})



    #    3 ########################################################################################################3
    p2 =
      name:'上海'
      sn:'沪'
      code:''
      level:0
#      parent:''
      children:[]
    p2._id =Laniakea.Collection.AddressChina.insert(p2)

    #    #2省 县:start
    p2c0 =
      name:'浦东新'
      sn:'浦东新'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c0._id =Laniakea.Collection.AddressChina.insert(p2c0)

    p2c1 =
      name:'徐汇'
      sn:'徐汇'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c1._id =Laniakea.Collection.AddressChina.insert(p2c1)

    p2c2 =
      name:'黄浦'
      sn:'黄浦'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c2._id =Laniakea.Collection.AddressChina.insert(p2c2)

    p2c3 =
      name:'杨浦'
      sn:'杨浦'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c3._id =Laniakea.Collection.AddressChina.insert(p2c3)

    p2c4 =
      name:'虹口'
      sn:'虹口'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c4._id =Laniakea.Collection.AddressChina.insert(p2c4)

    p2c5 =
      name:'闵行'
      sn:'闵行'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c5._id =Laniakea.Collection.AddressChina.insert(p2c5)

    p2c6 =
      name:'长宁'
      sn:'长宁'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c6._id =Laniakea.Collection.AddressChina.insert(p2c6)

    p2c7 =
      name:'普陀'
      sn:'普陀'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c7._id =Laniakea.Collection.AddressChina.insert(p2c7)

    p2c8 =
      name:'宝山'
      sn:'宝山'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c8._id =Laniakea.Collection.AddressChina.insert(p2c8)

    p2c9 =
      name:'静安'
      sn:'静安'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c9._id =Laniakea.Collection.AddressChina.insert(p2c9)

    p2c10 =
      name:'闸北'
      sn:'闸北'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c10._id =Laniakea.Collection.AddressChina.insert(p2c10)

    p2c11 =
      name:'卢湾'
      sn:'卢湾'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c11._id =Laniakea.Collection.AddressChina.insert(p2c11)

    p2c12 =
      name:'松江'
      sn:'松江'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c12._id =Laniakea.Collection.AddressChina.insert(p2c12)

    p2c13 =
      name:'嘉定'
      sn:'嘉定'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c13._id =Laniakea.Collection.AddressChina.insert(p2c13)

    p2c14 =
      name:'南汇'
      sn:'南汇'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c14._id =Laniakea.Collection.AddressChina.insert(p2c14)

    p2c15 =
      name:'金山'
      sn:'金山'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c15._id =Laniakea.Collection.AddressChina.insert(p2c15)

    p2c16 =
      name:'青浦'
      sn:'青浦'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c16._id =Laniakea.Collection.AddressChina.insert(p2c16)

    p2c17 =
      name:'奉贤'
      sn:'奉贤'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c17._id =Laniakea.Collection.AddressChina.insert(p2c17)

    p2c18 =
      name:'崇明'
      sn:'崇明'
      code:''
      level:1
      parent:p2._id
    #      children:[]
    p2c18._id =Laniakea.Collection.AddressChina.insert(p2c18)

#    children3=[p2c0._id,p2c1._id,p2c2._id,p2c3._id,p2c4._id,p2c5._id,
#               p2c6._id,p2c7._id,p2c8._id,p2c9._id,p2c10._id,p2c11._id,
#               p2c12._id,p2c13._id,p2c14._id,p2c15._id,p2c16._id,p2c17._id,p2c18._id]
    children3=[{'_id':p2c0._id,'name':p2c0.name},{'_id':p2c1._id,'name':p2c1.name},
              {'_id':p2c2._id,'name':p2c2.name},{'_id':p2c3._id,'name':p2c3.name},
              {'_id':p2c4._id,'name':p2c4.name},{'_id':p2c5._id,'name':p2c5.name},
              {'_id':p2c6._id,'name':p2c6.name},{'_id':p2c7._id,'name':p2c7.name},
              {'_id':p2c8._id,'name':p2c8.name},{'_id':p2c9._id,'name':p2c9.name},
              {'_id':p2c10._id,'name':p2c10.name},{'_id':p2c11._id,'name':p2c11.name},
              {'_id':p2c12._id,'name':p2c12.name},{'_id':p2c13._id,'name':p2c13.name},
              {'_id':p2c14._id,'name':p2c14.name},{'_id':p2c15._id,'name':p2c15.name},
              {'_id':p2c16._id,'name':p2c16.name},{'_id':p2c17._id,'name':p2c17.name},
              {'_id':p2c18._id,'name':p2c18.name}]
    Laniakea.Collection.AddressChina.update({_id:p2._id},{$set:{'children':children3}})



    #   ######################################## 4重庆市########################################3
    p3 =
      name:'重庆'
      sn:'渝'
      code:''
      level:0
#      parent:''
      children:[]
    p3._id =Laniakea.Collection.AddressChina.insert(p3)

    #    #3省0市 县:start
    p3c0 =
      name:'万州'
      sn:'万州'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c0._id =Laniakea.Collection.AddressChina.insert(p3c0)

    p3c1 =
      name:'涪陵'
      sn:'涪陵'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c1._id =Laniakea.Collection.AddressChina.insert(p3c1)

    p3c2 =
      name:'渝中'
      sn:'渝中'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c2._id =Laniakea.Collection.AddressChina.insert(p3c2)

    p3c3 =
      name:'大渡口'
      sn:'大渡口'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c3._id =Laniakea.Collection.AddressChina.insert(p3c3)

    p3c4 =
      name:'江北'
      sn:'江北'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c4._id =Laniakea.Collection.AddressChina.insert(p3c4)

    p3c5 =
      name:'沙坪坝'
      sn:'沙坪坝'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c5._id =Laniakea.Collection.AddressChina.insert(p3c5)

    p3c6 =
      name:'九龙坡'
      sn:'九龙坡'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c6._id =Laniakea.Collection.AddressChina.insert(p3c6)

    p3c7 =
      name:'南岸'
      sn:'南岸'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c7._id =Laniakea.Collection.AddressChina.insert(p3c7)

    p3c8 =
      name:'北碚'
      sn:'北碚'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c8._id =Laniakea.Collection.AddressChina.insert(p3c8)

    p3c9 =
      name:'万盛'
      sn:'万盛'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c9._id =Laniakea.Collection.AddressChina.insert(p3c9)

    p3c10 =
      name:'双桥'
      sn:'双桥'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c10._id =Laniakea.Collection.AddressChina.insert(p3c10)

    p3c11 =
      name:'渝北'
      sn:'渝北'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c11._id =Laniakea.Collection.AddressChina.insert(p3c11)

    p3c12 =
      name:'巴南'
      sn:'巴南'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c12._id =Laniakea.Collection.AddressChina.insert(p3c12)

    p3c13 =
      name:'长寿'
      sn:'长寿'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c13._id =Laniakea.Collection.AddressChina.insert(p3c13)

    p3c14 =
      name:'綦江'
      sn:'綦江'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c14._id =Laniakea.Collection.AddressChina.insert(p3c14)

    p3c15 =
      name:'潼南'
      sn:'潼南'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c15._id =Laniakea.Collection.AddressChina.insert(p3c15)

    p3c16 =
      name:'铜梁'
      sn:'铜梁'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c16._id =Laniakea.Collection.AddressChina.insert(p3c16)

    p3c17 =
      name:'大足'
      sn:'大足'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c17._id =Laniakea.Collection.AddressChina.insert(p3c17)

    p3c18 =
      name:'荣昌'
      sn:'荣昌'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c18._id =Laniakea.Collection.AddressChina.insert(p3c18)

    p3c19 =
      name:'璧山'
      sn:'璧山'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c19._id =Laniakea.Collection.AddressChina.insert(p3c19)

    p3c20 =
      name:'梁平'
      sn:'梁平'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c20._id =Laniakea.Collection.AddressChina.insert(p3c20)

    p3c21 =
      name:'城口'
      sn:'城口'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c21._id =Laniakea.Collection.AddressChina.insert(p3c21)

    p3c22 =
      name:'丰都'
      sn:'丰都'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c22._id =Laniakea.Collection.AddressChina.insert(p3c22)

    p3c23 =
      name:'垫江'
      sn:'垫江'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c23._id =Laniakea.Collection.AddressChina.insert(p3c23)

    p3c24 =
      name:'武隆'
      sn:'武隆'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c24._id =Laniakea.Collection.AddressChina.insert(p3c24)

    p3c25 =
      name:'忠县'
      sn:'忠县'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c25._id =Laniakea.Collection.AddressChina.insert(p3c25)

    p3c26 =
      name:'开县'
      sn:'开县'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c26._id =Laniakea.Collection.AddressChina.insert(p3c26)

    p3c27 =
      name:'云阳'
      sn:'云阳'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c27._id =Laniakea.Collection.AddressChina.insert(p3c27)

    p3c28 =
      name:'奉节'
      sn:'奉节'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c28._id =Laniakea.Collection.AddressChina.insert(p3c28)

    p3c29 =
      name:'巫山'
      sn:'巫山'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c29._id =Laniakea.Collection.AddressChina.insert(p3c29)

    p3c30 =
      name:'巫溪'
      sn:'巫溪'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c30._id =Laniakea.Collection.AddressChina.insert(p3c30)

    p3c31 =
      name:'黔江土家族苗族自治'
      sn:'黔江土家族苗族自治'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c31._id =Laniakea.Collection.AddressChina.insert(p3c31)

    p3c32 =
      name:'石柱土家族自治'
      sn:'石柱土家族自治'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c32._id =Laniakea.Collection.AddressChina.insert(p3c32)

    p3c33 =
      name:'秀山土家族苗族自治'
      sn:'秀山土家族苗族自治'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c33._id =Laniakea.Collection.AddressChina.insert(p3c33)

    p3c34 =
      name:'酉阳土家族苗族自治'
      sn:'酉阳土家族苗族自治'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c34._id =Laniakea.Collection.AddressChina.insert(p3c34)

    p3c35 =
      name:'彭水苗族土家族自治'
      sn:'彭水苗族土家族自治'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c35._id =Laniakea.Collection.AddressChina.insert(p3c35)

    p3c36 =
      name:'江津'
      sn:'江津'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c36._id =Laniakea.Collection.AddressChina.insert(p3c36)

    p3c37 =
      name:'合川'
      sn:'合川'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c37._id =Laniakea.Collection.AddressChina.insert(p3c37)

    p3c38 =
      name:'永川'
      sn:'永川'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c38._id =Laniakea.Collection.AddressChina.insert(p3c38)

    p3c39 =
      name:'南川'
      sn:'南川'
      code:''
      level:1
      parent:p3._id
    #      children:[]
    p3c39._id =Laniakea.Collection.AddressChina.insert(p3c39)
#    children4=[p3c0._id,p3c1._id,p3c2._id,p3c3._id,p3c4._id,p3c5._id,
#               p3c6._id,p3c7._id,p3c8._id,p3c9._id,p3c10._id,p3c11._id,
#               p3c12._id,p3c13._id,p3c14._id,p3c15._id,p3c16._id,p3c17._id,
#               p3c18._id,p3c19._id,p3c20._id,p3c21._id,p3c22._id,p3c23._id,
#               p3c24._id,p3c25._id,p3c26._id,p3c27._id,p3c28._id,p3c29._id,
#               p3c30._id,p3c31._id,p3c32._id,p3c33._id, p3c34._id,p3c35._id,
#               p3c36._id,p3c37._id,p3c38._id,p3c39._id]
    children4=[{'_id':p3c0._id,'name':p3c0.name},{'_id':p3c1._id,'name':p3c1.name},
              {'_id':p3c2._id,'name':p3c2.name},{'_id':p3c3._id,'name':p3c3.name},
              {'_id':p3c4._id,'name':p3c4.name},{'_id':p3c5._id,'name':p3c5.name},
              {'_id':p3c6._id,'name':p3c6.name},{'_id':p3c7._id,'name':p3c7.name},
              {'_id':p3c8._id,'name':p3c8.name},{'_id':p3c9._id,'name':p3c9.name},
              {'_id':p3c10._id,'name':p3c10.name},{'_id':p3c11._id,'name':p3c11.name},
              {'_id':p3c12._id,'name':p3c12.name},{'_id':p3c13._id,'name':p3c13.name},
              {'_id':p3c14._id,'name':p3c14.name},{'_id':p3c15._id,'name':p3c15.name},
              {'_id':p3c16._id,'name':p3c16.name},{'_id':p3c17._id,'name':p3c17.name},
              {'_id':p3c18._id,'name':p3c18.name},{'_id':p3c19._id,'name':p3c19.name},
              {'_id':p3c20._id,'name':p3c20.name},{'_id':p3c21._id,'name':p3c21.name},
              {'_id':p3c22._id,'name':p3c22.name},{'_id':p3c23._id,'name':p3c23.name},
              {'_id':p3c24._id,'name':p3c24.name},{'_id':p3c25._id,'name':p3c25.name},
              {'_id':p3c26._id,'name':p3c26.name},{'_id':p3c27._id,'name':p3c27.name},
              {'_id':p3c28._id,'name':p3c28.name},{'_id':p3c29._id,'name':p3c29.name},
              {'_id':p3c30._id,'name':p3c30.name},{'_id':p3c31._id,'name':p3c31.name},
              {'_id':p3c32._id,'name':p3c32.name},{'_id':p3c33._id,'name':p3c33.name},
              {'_id':p3c34._id,'name':p3c34.name},{'_id':p3c35._id,'name':p3c35.name},
              {'_id':p3c36._id,'name':p3c36.name},{'_id':p3c37._id,'name':p3c37.name},
              {'_id':p3c38._id,'name':p3c38.name},{'_id':p3c39._id,'name':p3c39.name}]
    Laniakea.Collection.AddressChina.update({_id:p3._id},{$set:{'children':children4}})


@Laniakea.Seed.AddressChinaSeeding2 = () ->
  console.log 'seed address2'
#    4省  ##############################################################################################################################################################################
  p4 =
    name:'河北'
    sn:'冀'
    code:''
    level:0
#      parent:''
    children:[]
  p4._id =Laniakea.Collection.AddressChina.insert(p4)

  #    p4c0
  p4c0 =
    name:'石家庄'
    sn:'石家庄'
    code:''
    level:1
    parent:p4._id
    children:[]
  p4c0._id =Laniakea.Collection.AddressChina.insert(p4c0)

  #   p4c0 县:start
  p4c0c0 =
    name:'长安'
    sn:'长安'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c0._id =Laniakea.Collection.AddressChina.insert(p4c0c0)

  p4c0c1 =
    name:'桥东'
    sn:'桥东'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c1._id =Laniakea.Collection.AddressChina.insert(p4c0c1)

  p4c0c2 =
    name:'桥西'
    sn:'桥西'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c2._id =Laniakea.Collection.AddressChina.insert(p4c0c2)

  p4c0c3 =
    name:'新华'
    sn:'新华'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c3._id =Laniakea.Collection.AddressChina.insert(p4c0c3)

  p4c0c4 =
    name:'郊区'
    sn:'郊区'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c4._id =Laniakea.Collection.AddressChina.insert(p4c0c4)

  p4c0c5 =
    name:'井陉矿'
    sn:'井陉矿'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c5._id =Laniakea.Collection.AddressChina.insert(p4c0c5)

  p4c0c6 =
    name:'井陉'
    sn:'井陉'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c6._id =Laniakea.Collection.AddressChina.insert(p4c0c6)

  p4c0c7 =
    name:'正定'
    sn:'正定'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c7._id =Laniakea.Collection.AddressChina.insert(p4c0c7)

  p4c0c8 =
    name:'栾城'
    sn:'栾城'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c8._id =Laniakea.Collection.AddressChina.insert(p4c0c8)

  p4c0c9 =
    name:'行唐'
    sn:'行唐'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c9._id =Laniakea.Collection.AddressChina.insert(p4c0c9)

  p4c0c10 =
    name:'灵寿'
    sn:'灵寿'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c10._id =Laniakea.Collection.AddressChina.insert(p4c0c10)

  p4c0c11 =
    name:'高邑'
    sn:'高邑'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c11._id =Laniakea.Collection.AddressChina.insert(p4c0c11)

  p4c0c12 =
    name:'深泽'
    sn:'深泽'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c12._id =Laniakea.Collection.AddressChina.insert(p4c0c12)

  p4c0c13 =
    name:'赞皇'
    sn:'赞皇'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c13._id =Laniakea.Collection.AddressChina.insert(p4c0c13)

  p4c0c14 =
    name:'无极'
    sn:'无极'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c14._id =Laniakea.Collection.AddressChina.insert(p4c0c14)

  p4c0c15 =
    name:'平山'
    sn:'平山'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c15._id =Laniakea.Collection.AddressChina.insert(p4c0c15)

  p4c0c16 =
    name:'元氏'
    sn:'元氏'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c16._id =Laniakea.Collection.AddressChina.insert(p4c0c16)

  p4c0c17 =
    name:'赵县'
    sn:'赵县'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c17._id =Laniakea.Collection.AddressChina.insert(p4c0c17)

  p4c0c18 =
    name:'辛集'
    sn:'辛集'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c18._id =Laniakea.Collection.AddressChina.insert(p4c0c18)

  p4c0c19 =
    name:'藁城'
    sn:'藁城'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c19._id =Laniakea.Collection.AddressChina.insert(p4c0c19)

  p4c0c20 =
    name:'晋州'
    sn:'晋州'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c20._id =Laniakea.Collection.AddressChina.insert(p4c0c20)

  p4c0c21 =
    name:'新乐'
    sn:'新乐'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c21._id =Laniakea.Collection.AddressChina.insert(p4c0c21)

  p4c0c22 =
    name:'鹿泉'
    sn:'鹿泉'
    code:''
    level:2
    parent:p4c0._id
#    children:[]
  p4c0c22._id =Laniakea.Collection.AddressChina.insert(p4c0c22)

  children1=[{'_id':p4c0c0._id,'name':p4c0c0.name},{'_id':p4c0c1._id,'name':p4c0c1.name},
             {'_id':p4c0c2._id,'name':p4c0c2.name},{'_id':p4c0c3._id,'name':p4c0c3.name},
             {'_id':p4c0c4._id,'name':p4c0c4.name},{'_id':p4c0c5._id,'name':p4c0c5.name},
             {'_id':p4c0c6._id,'name':p4c0c6.name},{'_id':p4c0c7._id,'name':p4c0c7.name},
             {'_id':p4c0c8._id,'name':p4c0c8.name},{'_id':p4c0c9._id,'name':p4c0c9.name},
             {'_id':p4c0c10._id,'name':p4c0c10.name},{'_id':p4c0c11._id,'name':p4c0c11.name},
             {'_id':p4c0c12._id,'name':p4c0c12.name},{'_id':p4c0c13._id,'name':p4c0c13.name},
             {'_id':p4c0c14._id,'name':p4c0c14.name},{'_id':p4c0c15._id,'name':p4c0c15.name},
             {'_id':p4c0c16._id,'name':p4c0c16.name},{'_id':p4c0c17._id,'name':p4c0c17.name},
             {'_id':p4c0c18._id,'name':p4c0c18.name},{'_id':p4c0c19._id,'name':p4c0c19.name},
             {'_id':p4c0c20._id,'name':p4c0c20.name},{'_id':p4c0c21._id,'name':p4c0c21.name},
             {'_id':p4c0c22._id,'name':p4c0c22.name}]
  Laniakea.Collection.AddressChina.update({_id:p4c0._id},{$set:{'children':children1}})


  #   p4c1------------------------------------------------------------------------
  p4c1 =
    name:'唐山'
    sn:'唐山'
    code:''
    level:1
    parent:p4._id
    children:[]
  p4c1._id =Laniakea.Collection.AddressChina.insert(p4c1)


#  p4c1c0 =
#    name:'路南区'
#    sn:'路南区'
#    code:''
#    parent:p4c1._id
##    children:[]
#  p4c1c0._id =Laniakea.Collection.AddressChina.insert(p4c1c0)
#
#  p4c1c1 =
#    name:'路北区'
#    sn:'路北区'
#    code:''
#    parent:p4c1._id
##    children:[]
#  p4c1c1._id =Laniakea.Collection.AddressChina.insert(p4c1c1)
#
#  p4c1c2 =
#    name:'古冶区'
#    sn:'古冶区'
#    code:''
#    parent:p4c1._id
#  #    children:[]
#  p4c1c2._id =Laniakea.Collection.AddressChina.insert(p4c1c2)
#
#  p4c1c3 =
#    name:'开平区'
#    sn:'开平区'
#    code:''
#    parent:p4c1._id
#  #    children:[]
#  p4c1c3._id =Laniakea.Collection.AddressChina.insert(p4c1c3)
#
#  p4c1c4 =
#    name:'新区'
#    sn:'新区'
#    code:''
#    parent:p4c1._id
#  #    children:[]
#  p4c1c4._id =Laniakea.Collection.AddressChina.insert(p4c1c4)
#
#  p4c1c5 =
#    name:'丰润县'
#    sn:'丰润县'
#    code:''
#    parent:p4c1._id
#  #    children:[]
#  p4c1c5._id =Laniakea.Collection.AddressChina.insert(p4c1c5)
#
#  p4c1c6 =
#    name:'滦县'
#    sn:'滦县'
#    code:''
#    parent:p4c1._id
#  #    children:[]
#  p4c1c6._id =Laniakea.Collection.AddressChina.insert(p4c1c6)
#
#  p4c1c7 =
#    name:'滦南县'
#    sn:'滦南县'
#    code:''
#    parent:p4c1._id
#  #    children:[]
#  p4c1c7._id =Laniakea.Collection.AddressChina.insert(p4c1c7)
#
#  p4c1c8 =
#    name:'乐亭县'
#    sn:'乐亭县'
#    code:''
#    parent:p4c1._id
#  #    children:[]
#  p4c1c8._id =Laniakea.Collection.AddressChina.insert(p4c1c8)
#
#  p4c1c9 =
#    name:'迁西县'
#    sn:'迁西县'
#    code:''
#    parent:p4c1._id
#  #    children:[]
#  p4c1c9._id =Laniakea.Collection.AddressChina.insert(p4c1c9)
#
#  p4c1c10 =
#    name:'玉田县'
#    sn:'玉田县'
#    code:''
#    parent:p4c1._id
#  #    children:[]
#  p4c1c10._id =Laniakea.Collection.AddressChina.insert(p4c1c10)
#
#  p4c1c11 =
#    name:'唐海县'
#    sn:'唐海县'
#    code:''
#    parent:p4c1._id
#  #    children:[]
#  p4c1c11._id =Laniakea.Collection.AddressChina.insert(p4c1c11)
#
#  p4c1c12 =
#    name:'遵化市'
#    sn:'遵化市'
#    code:''
#    parent:p4c1._id
#  #    children:[]
#  p4c1c12._id =Laniakea.Collection.AddressChina.insert(p4c1c12)
#
#  p4c1c13 =
#    name:'丰南市'
#    sn:'丰南市'
#    code:''
#    parent:p4c1._id
#  #    children:[]
#  p4c1c13._id =Laniakea.Collection.AddressChina.insert(p4c1c13)
#
#  p4c1c14 =
#    name:'迁安市'
#    sn:'迁安市'
#    code:''
#    parent:p4c1._id
#  #    children:[]
#  p4c1c14._id =Laniakea.Collection.AddressChina.insert(p4c1c14)
#
#  children2=[p4c1c0._id,p4c1c1._id,p4c1c2._id,p4c1c3._id,p4c1c4._id,p4c1c5._id,
#             p4c1c6._id,p4c1c7._id,p4c1c8._id,p4c1c9._id,p4c1c10._id,p4c1c11._id,
#             p4c1c12._id,p4c1c13._id,p4c1c14._id]
#  Laniakea.Collection.AddressChina.update({_id:p4c1._id},{$set:{'children':children2}})
#
#  #   p4c2------------------------------------------------------------------------
#  p4c2 =
#    name:'秦皇岛市'
#    sn:'秦皇岛市'
#    code:''
#    level:1
#    parent:p4._id
#    children:[]
#  p4c2._id =Laniakea.Collection.AddressChina.insert(p4c2)
#
#
#  p4c2c0 =
#    name:'海港区'
#    sn:'海港区'
#    code:''
#    parent:p4c2._id
#  #    children:[]
#  p4c2c0._id =Laniakea.Collection.AddressChina.insert(p4c2c0)
#
#  p4c2c1 =
#    name:'山海关区'
#    sn:'山海关区'
#    code:''
#    parent:p4c2._id
#  #    children:[]
#  p4c2c1._id =Laniakea.Collection.AddressChina.insert(p4c2c1)
#
#  p4c2c2 =
#    name:'北戴河区'
#    sn:'北戴河区'
#    code:''
#    parent:p4c2._id
#  #    children:[]
#  p4c2c2._id =Laniakea.Collection.AddressChina.insert(p4c2c2)
#
#  p4c2c3 =
#    name:'青龙满族自治县'
#    sn:'青龙满族自治县'
#    code:''
#    parent:p4c2._id
#  #    children:[]
#  p4c2c3._id =Laniakea.Collection.AddressChina.insert(p4c2c3)
#
#  p4c2c4 =
#    name:'昌黎县'
#    sn:'昌黎县'
#    code:''
#    parent:p4c2._id
#  #    children:[]
#  p4c2c4._id =Laniakea.Collection.AddressChina.insert(p4c2c4)
#
#  p4c2c5 =
#    name:'抚宁县'
#    sn:'抚宁县'
#    code:''
#    parent:p4c2._id
#  #    children:[]
#  p4c2c5._id =Laniakea.Collection.AddressChina.insert(p4c2c5)
#
#  p4c2c6 =
#    name:'卢龙县'
#    sn:'卢龙县'
#    code:''
#    parent:p4c2._id
#  #    children:[]
#  p4c2c6._id =Laniakea.Collection.AddressChina.insert(p4c2c6)
#
#  children3=[p4c2c0._id,p4c2c1._id,p4c2c2._id,p4c2c3._id,p4c2c4._id,p4c2c5._id,p4c2c6._id]
#  Laniakea.Collection.AddressChina.update({_id:p4c2._id},{$set:{'children':children3}})
#
#
#  #    p4c3  ---------------------------------------------------------------------------------------------
#  p4c3 =
#    name:'邯郸市'
#    sn:'邯郸市'
#    code:''
#    level:1
#    parent:p4._id
#    children:[]
#  p4c3._id =Laniakea.Collection.AddressChina.insert(p4c3)
#
#  #   p4c3 县:start
#  p4c3c0 =
#    name:'邯山区'
#    sn:'邯山区'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c0._id =Laniakea.Collection.AddressChina.insert(p4c3c0)
#
#  p4c3c1 =
#    name:'丛台区'
#    sn:'丛台区'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c1._id =Laniakea.Collection.AddressChina.insert(p4c3c1)
#
#  p4c3c2 =
#    name:'复兴区'
#    sn:'复兴区'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c2._id =Laniakea.Collection.AddressChina.insert(p4c3c2)
#
#  p4c3c3 =
#    name:'峰峰矿区'
#    sn:'峰峰矿区'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c3._id =Laniakea.Collection.AddressChina.insert(p4c3c3)
#
#  p4c3c4 =
#    name:'邯郸县'
#    sn:'邯郸县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c4._id =Laniakea.Collection.AddressChina.insert(p4c3c4)
#
#  p4c3c5 =
#    name:'临漳县'
#    sn:'临漳县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c5._id =Laniakea.Collection.AddressChina.insert(p4c3c5)
#
#  p4c3c6 =
#    name:'成安县'
#    sn:'成安县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c6._id =Laniakea.Collection.AddressChina.insert(p4c3c6)
#
#  p4c3c7 =
#    name:'大名县'
#    sn:'大名县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c7._id =Laniakea.Collection.AddressChina.insert(p4c3c7)
#
#  p4c3c8 =
#    name:'涉县'
#    sn:'涉县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c8._id =Laniakea.Collection.AddressChina.insert(p4c3c8)
#
#  p4c3c9 =
#    name:'磁县'
#    sn:'磁县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c9._id =Laniakea.Collection.AddressChina.insert(p4c3c9)
#
#  p4c3c10 =
#    name:'肥乡县'
#    sn:'肥乡县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c10._id =Laniakea.Collection.AddressChina.insert(p4c3c10)
#
#  p4c3c11 =
#    name:'永年县'
#    sn:'永年县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c11._id =Laniakea.Collection.AddressChina.insert(p4c3c11)
#
#  p4c3c12 =
#    name:'邱县'
#    sn:'邱县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c12._id =Laniakea.Collection.AddressChina.insert(p4c3c12)
#
#  p4c3c13 =
#    name:'鸡泽县'
#    sn:'鸡泽县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c13._id =Laniakea.Collection.AddressChina.insert(p4c3c13)
#
#  p4c3c14 =
#    name:'广平县'
#    sn:'广平县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c14._id =Laniakea.Collection.AddressChina.insert(p4c3c14)
#
#  p4c3c15 =
#    name:'馆陶县'
#    sn:'馆陶县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c15._id =Laniakea.Collection.AddressChina.insert(p4c3c15)
#
#  p4c3c16 =
#    name:'魏县'
#    sn:'魏县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c16._id =Laniakea.Collection.AddressChina.insert(p4c3c16)
#
#  p4c3c17 =
#    name:'曲周县'
#    sn:'曲周县'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c17._id =Laniakea.Collection.AddressChina.insert(p4c3c17)
#
#  p4c3c18 =
#    name:'武安市'
#    sn:'武安市'
#    code:''
#    parent:p4c3._id
#  #    children:[]
#  p4c3c18._id =Laniakea.Collection.AddressChina.insert(p4c3c18)
#
#  children4=[p4c3c0._id,p4c3c1._id,p4c3c2._id,p4c3c3._id,p4c3c4._id,p4c3c5._id,
#             p4c3c6._id,p4c3c7._id,p4c3c8._id,p4c3c9._id,p4c3c10._id,p4c3c11._id,
#             p4c3c12._id,p4c3c13._id,p4c3c14._id,p4c3c15._id,p4c3c16._id,p4c3c17._id,p4c3c18._id]
#  Laniakea.Collection.AddressChina.update({_id:p4c3._id},{$set:{'children':children4}})
#
#
#
#  #    p4c4  ---------------------------------------------------------------------------------------------
#  p4c4 =
#    name:'邢台市'
#    sn:'邢台市'
#    code:''
#    level:1
#    parent:p4._id
#    children:[]
#  p4c4._id =Laniakea.Collection.AddressChina.insert(p4c4)
#
#  #   p4c4 县:start
#  p4c4c0 =
#    name:'桥东区'
#    sn:'桥东区'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c0._id =Laniakea.Collection.AddressChina.insert(p4c4c0)
#
#  p4c4c1 =
#    name:'桥西区'
#    sn:'桥西区'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c1._id =Laniakea.Collection.AddressChina.insert(p4c4c1)
#
#  p4c4c2 =
#    name:'邢台县'
#    sn:'邢台县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c2._id =Laniakea.Collection.AddressChina.insert(p4c4c2)
#
#  p4c4c3 =
#    name:'临城县'
#    sn:'临城县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c3._id =Laniakea.Collection.AddressChina.insert(p4c4c3)
#
#  p4c4c4 =
#    name:'内丘县'
#    sn:'内丘县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c4._id =Laniakea.Collection.AddressChina.insert(p4c4c4)
#
#  p4c4c5 =
#    name:'柏乡县'
#    sn:'柏乡县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c5._id =Laniakea.Collection.AddressChina.insert(p4c4c5)
#
#  p4c4c6 =
#    name:'隆尧县'
#    sn:'隆尧县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c6._id =Laniakea.Collection.AddressChina.insert(p4c4c6)
#
#  p4c4c7 =
#    name:'任县'
#    sn:'任县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c7._id =Laniakea.Collection.AddressChina.insert(p4c4c7)
#
#  p4c4c8 =
#    name:'南和县'
#    sn:'南和县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c8._id =Laniakea.Collection.AddressChina.insert(p4c4c8)
#
#  p4c4c9 =
#    name:'宁晋县'
#    sn:'宁晋县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c9._id =Laniakea.Collection.AddressChina.insert(p4c4c9)
#
#  p4c4c10 =
#    name:'巨鹿县'
#    sn:'巨鹿县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c10._id =Laniakea.Collection.AddressChina.insert(p4c4c10)
#
#  p4c4c11 =
#    name:'新河县'
#    sn:'新河县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c11._id =Laniakea.Collection.AddressChina.insert(p4c4c11)
#
#  p4c4c12 =
#    name:'广宗县'
#    sn:'广宗县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c12._id =Laniakea.Collection.AddressChina.insert(p4c4c12)
#
#  p4c4c13 =
#    name:'平乡县'
#    sn:'平乡县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c13._id =Laniakea.Collection.AddressChina.insert(p4c4c13)
#
#  p4c4c14 =
#    name:'威县'
#    sn:'威县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c14._id =Laniakea.Collection.AddressChina.insert(p4c4c14)
#
#  p4c4c15 =
#    name:'清河县'
#    sn:'清河县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c15._id =Laniakea.Collection.AddressChina.insert(p4c4c15)
#
#  p4c4c16 =
#    name:'临西县'
#    sn:'临西县'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c16._id =Laniakea.Collection.AddressChina.insert(p4c4c16)
#
#  p4c4c17 =
#    name:'南宫市'
#    sn:'南宫市'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c17._id =Laniakea.Collection.AddressChina.insert(p4c4c17)
#
#  p4c4c18 =
#    name:'沙河市'
#    sn:'沙河市'
#    code:''
#    parent:p4c4._id
#  #    children:[]
#  p4c4c18._id =Laniakea.Collection.AddressChina.insert(p4c4c18)
#
#  children5=[p4c4c0._id,p4c4c1._id,p4c4c2._id,p4c4c3._id,p4c4c4._id,p4c4c5._id,
#             p4c4c6._id,p4c4c7._id,p4c4c8._id,p4c4c9._id,p4c4c10._id,p4c4c11._id,
#             p4c4c12._id,p4c4c13._id,p4c4c14._id,p4c4c15._id,p4c4c16._id,p4c4c17._id,p4c4c18._id]
#  Laniakea.Collection.AddressChina.update({_id:p4c4._id},{$set:{'children':children5}})
#
#
#  #    p4c5 -----------------------------------------------------------------------------------------
#  p4c5 =
#    name:'保定市'
#    sn:'保定市'
#    code:''
#    level:1
#    parent:p4._id
#    children:[]
#  p4c5._id =Laniakea.Collection.AddressChina.insert(p4c5)
#
#  #   p4c5 县:start
#  p4c5c0 =
#    name:'新市区'
#    sn:'新市区'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c0._id =Laniakea.Collection.AddressChina.insert(p4c5c0)
#
#  p4c5c1 =
#    name:'北市区'
#    sn:'北市区'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c1._id =Laniakea.Collection.AddressChina.insert(p4c5c1)
#
#  p4c5c2 =
#    name:'南市区'
#    sn:'南市区'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c2._id =Laniakea.Collection.AddressChina.insert(p4c5c2)
#
#  p4c5c3 =
#    name:'满城县'
#    sn:'满城县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c3._id =Laniakea.Collection.AddressChina.insert(p4c5c3)
#
#  p4c5c4 =
#    name:'清苑县'
#    sn:'清苑县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c4._id =Laniakea.Collection.AddressChina.insert(p4c5c4)
#
#  p4c5c5 =
#    name:'涞水县'
#    sn:'涞水县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c5._id =Laniakea.Collection.AddressChina.insert(p4c5c5)
#
#  p4c5c6 =
#    name:'阜平县'
#    sn:'阜平县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c6._id =Laniakea.Collection.AddressChina.insert(p4c5c6)
#
#  p4c5c7 =
#    name:'徐水县'
#    sn:'徐水县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c7._id =Laniakea.Collection.AddressChina.insert(p4c5c7)
#
#  p4c5c8 =
#    name:'定兴县'
#    sn:'定兴县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c8._id =Laniakea.Collection.AddressChina.insert(p4c5c8)
#
#  p4c5c9 =
#    name:'唐县'
#    sn:'唐县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c9._id =Laniakea.Collection.AddressChina.insert(p4c5c9)
#
#  p4c5c10 =
#    name:'高阳县'
#    sn:'高阳县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c10._id =Laniakea.Collection.AddressChina.insert(p4c5c10)
#
#  p4c5c11 =
#    name:'容城县'
#    sn:'容城县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c11._id =Laniakea.Collection.AddressChina.insert(p4c5c11)
#
#  p4c5c12 =
#    name:'涞源县'
#    sn:'涞源县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c12._id =Laniakea.Collection.AddressChina.insert(p4c5c12)
#
#  p4c5c13 =
#    name:'望都县'
#    sn:'望都县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c13._id =Laniakea.Collection.AddressChina.insert(p4c5c13)
#
#  p4c5c14 =
#    name:'安新县'
#    sn:'安新县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c14._id =Laniakea.Collection.AddressChina.insert(p4c5c14)
#
#  p4c5c15 =
#    name:'易县'
#    sn:'易县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c15._id =Laniakea.Collection.AddressChina.insert(p4c5c15)
#
#  p4c5c16 =
#    name:'曲阳县'
#    sn:'曲阳县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c16._id =Laniakea.Collection.AddressChina.insert(p4c5c16)
#
#  p4c5c17 =
#    name:'蠡县'
#    sn:'蠡县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c17._id =Laniakea.Collection.AddressChina.insert(p4c5c17)
#
#  p4c5c18 =
#    name:'顺平县'
#    sn:'顺平县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c18._id =Laniakea.Collection.AddressChina.insert(p4c5c18)
#
#  p4c5c19 =
#    name:'博野县'
#    sn:'博野县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c19._id =Laniakea.Collection.AddressChina.insert(p4c5c19)
#
#  p4c5c20 =
#    name:'雄县'
#    sn:'雄县'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c20._id =Laniakea.Collection.AddressChina.insert(p4c5c20)
#
#  p4c5c21 =
#    name:'涿州市'
#    sn:'涿州市'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c21._id =Laniakea.Collection.AddressChina.insert(p4c5c21)
#
#  p4c5c22 =
#    name:'定州市'
#    sn:'定州市'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c22._id =Laniakea.Collection.AddressChina.insert(p4c5c22)
#
#  p4c5c23 =
#    name:'安国市'
#    sn:'安国市'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c23._id =Laniakea.Collection.AddressChina.insert(p4c5c23)
#
#  p4c5c24 =
#    name:'高碑店市'
#    sn:'高碑店市'
#    code:''
#    parent:p4c5._id
#  #    children:[]
#  p4c5c24._id =Laniakea.Collection.AddressChina.insert(p4c5c24)
#
#  children6=[p4c5c0._id,p4c5c1._id,p4c5c2._id,p4c5c3._id,p4c5c4._id,p4c5c5._id,
#             p4c5c6._id,p4c5c7._id,p4c5c8._id,p4c5c9._id,p4c5c10._id,p4c5c11._id,
#             p4c5c12._id,p4c5c13._id,p4c5c14._id,p4c5c15._id,p4c5c16._id,p4c5c17._id,
#             p4c5c18._id,p4c5c19._id,p4c5c20._id,p4c5c21._id,p4c5c22._id,p4c5c23._id,p4c5c24._id]
#  Laniakea.Collection.AddressChina.update({_id:p4c5._id},{$set:{'children':children6}})
#
#
#
#  #    p4c6 -----------------------------------------------------------------------------------------
#  p4c6 =
#    name:'张家口市'
#    sn:'张家口市'
#    code:''
#    level:1
#    parent:p4._id
#    children:[]
#  p4c6._id =Laniakea.Collection.AddressChina.insert(p4c6)
#
#  #   p4c6 县:start
#  p4c6c0 =
#    name:'桥东区'
#    sn:'桥东区'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c0._id =Laniakea.Collection.AddressChina.insert(p4c6c0)
#
#  p4c6c1 =
#    name:'桥西区'
#    sn:'桥西区'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c1._id =Laniakea.Collection.AddressChina.insert(p4c6c1)
#
#  p4c6c2 =
#    name:'宣化区'
#    sn:'宣化区'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c2._id =Laniakea.Collection.AddressChina.insert(p4c6c2)
#
#  p4c6c3 =
#    name:'下花园区'
#    sn:'下花园区'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c3._id =Laniakea.Collection.AddressChina.insert(p4c6c3)
#
#  p4c6c4 =
#    name:'宣化县'
#    sn:'宣化县'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c4._id =Laniakea.Collection.AddressChina.insert(p4c6c4)
#
#  p4c6c5 =
#    name:'张北县'
#    sn:'张北县'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c5._id =Laniakea.Collection.AddressChina.insert(p4c6c5)
#
#  p4c6c6 =
#    name:'康保县'
#    sn:'康保县'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c6._id =Laniakea.Collection.AddressChina.insert(p4c6c6)
#
#  p4c6c7 =
#    name:'沽源县'
#    sn:'沽源县'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c7._id =Laniakea.Collection.AddressChina.insert(p4c6c7)
#
#  p4c6c8 =
#    name:'尚义县'
#    sn:'尚义县'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c8._id =Laniakea.Collection.AddressChina.insert(p4c6c8)
#
#  p4c6c9 =
#    name:'蔚县'
#    sn:'蔚县'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c9._id =Laniakea.Collection.AddressChina.insert(p4c6c9)
#
#  p4c6c10 =
#    name:'阳原县'
#    sn:'阳原县'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c10._id =Laniakea.Collection.AddressChina.insert(p4c6c10)
#
#  p4c6c11 =
#    name:'怀安县'
#    sn:'怀安县'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c11._id =Laniakea.Collection.AddressChina.insert(p4c6c11)
#
#  p4c6c12 =
#    name:'万全县'
#    sn:'万全县'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c12._id =Laniakea.Collection.AddressChina.insert(p4c6c12)
#
#  p4c6c13 =
#    name:'怀来县'
#    sn:'怀来县'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c13._id =Laniakea.Collection.AddressChina.insert(p4c6c13)
#
#  p4c6c14 =
#    name:'涿鹿县'
#    sn:'涿鹿县'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c14._id =Laniakea.Collection.AddressChina.insert(p4c6c14)
#
#  p4c6c15 =
#    name:'赤城县'
#    sn:'赤城县'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c15._id =Laniakea.Collection.AddressChina.insert(p4c6c15)
#
#  p4c6c16 =
#    name:'崇礼县'
#    sn:'崇礼县'
#    code:''
#    parent:p4c6._id
#  #    children:[]
#  p4c6c16._id =Laniakea.Collection.AddressChina.insert(p4c6c16)
#
#  children7=[p4c6c0._id,p4c6c1._id,p4c6c2._id,p4c6c3._id,p4c6c4._id,p4c6c5._id,
#             p4c6c6._id,p4c6c7._id,p4c6c8._id,p4c6c9._id,p4c6c10._id,p4c6c11._id,
#             p4c6c12._id,p4c6c13._id,p4c6c14._id,p4c6c15._id,p4c6c16._id]
#  Laniakea.Collection.AddressChina.update({_id:p4c6._id},{$set:{'children':children7}})
#
#
#
#  #    p4c7 -----------------------------------------------------------------------------------------
#  p4c7 =
#    name:'承德市'
#    sn:'承德市'
#    code:''
#    level:1
#    parent:p4._id
#    children:[]
#  p4c7._id =Laniakea.Collection.AddressChina.insert(p4c7)
#
#  #   p4c7 县:start
#  p4c7c0 =
#    name:'双桥区'
#    sn:'双桥区'
#    code:''
#    parent:p4c7._id
#  #    children:[]
#  p4c7c0._id =Laniakea.Collection.AddressChina.insert(p4c7c0)
#
#  p4c7c1 =
#    name:'双滦区'
#    sn:'双滦区'
#    code:''
#    parent:p4c7._id
#  #    children:[]
#  p4c7c1._id =Laniakea.Collection.AddressChina.insert(p4c7c1)
#
#  p4c7c2 =
#    name:'鹰手营子矿区'
#    sn:'鹰手营子矿区'
#    code:''
#    parent:p4c7._id
#  #    children:[]
#  p4c7c2._id =Laniakea.Collection.AddressChina.insert(p4c7c2)
#
#  p4c7c3 =
#    name:'承德县'
#    sn:'承德县'
#    code:''
#    parent:p4c7._id
#  #    children:[]
#  p4c7c3._id =Laniakea.Collection.AddressChina.insert(p4c7c3)
#
#  p4c7c4 =
#    name:'兴隆县'
#    sn:'兴隆县'
#    code:''
#    parent:p4c7._id
#  #    children:[]
#  p4c7c4._id =Laniakea.Collection.AddressChina.insert(p4c7c4)
#
#  p4c7c5 =
#    name:'平泉县'
#    sn:'平泉县'
#    code:''
#    parent:p4c7._id
#  #    children:[]
#  p4c7c5._id =Laniakea.Collection.AddressChina.insert(p4c7c5)
#
#  p4c7c6 =
#    name:'滦平县'
#    sn:'滦平县'
#    code:''
#    parent:p4c7._id
#  #    children:[]
#  p4c7c6._id =Laniakea.Collection.AddressChina.insert(p4c7c6)
#
#  p4c7c7 =
#    name:'隆化县'
#    sn:'隆化县'
#    code:''
#    parent:p4c7._id
#  #    children:[]
#  p4c7c7._id =Laniakea.Collection.AddressChina.insert(p4c7c7)
#
#  p4c7c8 =
#    name:'丰宁满族自治县'
#    sn:'丰宁满族自治县'
#    code:''
#    parent:p4c7._id
#  #    children:[]
#  p4c7c8._id =Laniakea.Collection.AddressChina.insert(p4c7c8)
#
#  p4c7c9 =
#    name:'宽城满族自治县'
#    sn:'宽城满族自治县'
#    code:''
#    parent:p4c7._id
#  #    children:[]
#  p4c7c9._id =Laniakea.Collection.AddressChina.insert(p4c7c9)
#
#  p4c7c10 =
#    name:'围场满族蒙古族自治县'
#    sn:'围场满族蒙古族自治县'
#    code:''
#    parent:p4c7._id
#  #    children:[]
#  p4c7c10._id =Laniakea.Collection.AddressChina.insert(p4c7c10)
#
#
#  children8=[p4c7c0._id,p4c7c1._id,p4c7c2._id,p4c7c3._id,p4c7c4._id,p4c7c5._id,
#             p4c7c6._id,p4c7c7._id,p4c7c8._id,p4c7c9._id,p4c7c10._id]
#  Laniakea.Collection.AddressChina.update({_id:p4c7._id},{$set:{'children':children8}})
#
#
#
#  #    p4c8 -----------------------------------------------------------------------------------------
#  p4c8 =
#    name:'沧州市'
#    sn:'沧州市'
#    code:''
#    level:1
#    parent:p4._id
#    children:[]
#  p4c8._id =Laniakea.Collection.AddressChina.insert(p4c8)
#
#  #   p4c8 县:start
#  p4c8c0 =
#    name:'新华区'
#    sn:'新华区'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c0._id =Laniakea.Collection.AddressChina.insert(p4c8c0)
#
#  p4c8c1 =
#    name:'运河区'
#    sn:'运河区'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c1._id =Laniakea.Collection.AddressChina.insert(p4c8c1)
#
#  p4c8c2 =
#    name:'沧县'
#    sn:'沧县'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c2._id =Laniakea.Collection.AddressChina.insert(p4c8c2)
#
#  p4c8c3 =
#    name:'青县'
#    sn:'青县'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c3._id =Laniakea.Collection.AddressChina.insert(p4c8c3)
#
#  p4c8c4 =
#    name:'东光县'
#    sn:'东光县'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c4._id =Laniakea.Collection.AddressChina.insert(p4c8c4)
#
#  p4c8c5 =
#    name:'海兴县'
#    sn:'海兴县'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c5._id =Laniakea.Collection.AddressChina.insert(p4c8c5)
#
#  p4c8c6 =
#    name:'盐山县'
#    sn:'盐山县'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c6._id =Laniakea.Collection.AddressChina.insert(p4c8c6)
#
#  p4c8c7 =
#    name:'肃宁县'
#    sn:'肃宁县'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c7._id =Laniakea.Collection.AddressChina.insert(p4c8c7)
#
#  p4c8c8 =
#    name:'南皮县'
#    sn:'南皮县'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c8._id =Laniakea.Collection.AddressChina.insert(p4c8c8)
#
#  p4c8c9 =
#    name:'吴桥县'
#    sn:'吴桥县'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c9._id =Laniakea.Collection.AddressChina.insert(p4c8c9)
#
#  p4c8c10 =
#    name:'献县'
#    sn:'献县'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c10._id =Laniakea.Collection.AddressChina.insert(p4c8c10)
#
#  p4c8c11 =
#    name:'孟村回族自治县'
#    sn:'孟村回族自治县'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c11._id =Laniakea.Collection.AddressChina.insert(p4c8c11)
#
#  p4c8c12 =
#    name:'泊头市'
#    sn:'泊头市'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c12._id =Laniakea.Collection.AddressChina.insert(p4c8c12)
#
#  p4c8c13 =
#    name:'任丘市'
#    sn:'任丘市'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c13._id =Laniakea.Collection.AddressChina.insert(p4c8c13)
#
#  p4c8c14 =
#    name:'黄骅市'
#    sn:'黄骅市'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c14._id =Laniakea.Collection.AddressChina.insert(p4c8c14)
#
#  p4c8c15 =
#    name:'河间市'
#    sn:'河间市'
#    code:''
#    parent:p4c8._id
#  #    children:[]
#  p4c8c15._id =Laniakea.Collection.AddressChina.insert(p4c8c15)
#
#  children9=[p4c8c0._id,p4c8c1._id,p4c8c2._id,p4c8c3._id,p4c8c4._id,p4c8c5._id,
#             p4c8c6._id,p4c8c7._id,p4c8c8._id,p4c8c9._id,p4c8c10._id,p4c8c11._id,
#             p4c8c12._id,p4c8c13._id,p4c8c14._id,p4c8c15._id]
#  Laniakea.Collection.AddressChina.update({_id:p4c8._id},{$set:{'children':children9}})
#
#
#  #    p4c9 -----------------------------------------------------------------------------------------
#  p4c9 =
#    name:'廊坊市'
#    sn:'廊坊市'
#    code:''
#    level:1
#    parent:p4._id
#    children:[]
#  p4c9._id =Laniakea.Collection.AddressChina.insert(p4c9)
#
#  #   p4c9 县:start
#  p4c9c0 =
#    name:'安次区'
#    sn:'安次区'
#    code:''
#    parent:p4c9._id
#  #    children:[]
#  p4c9c0._id =Laniakea.Collection.AddressChina.insert(p4c9c0)
#
#  p4c9c1 =
#    name:'固安县'
#    sn:'固安县'
#    code:''
#    parent:p4c9._id
#  #    children:[]
#  p4c9c1._id =Laniakea.Collection.AddressChina.insert(p4c9c1)
#
#  p4c9c2 =
#    name:'永清县'
#    sn:'永清县'
#    code:''
#    parent:p4c9._id
#  #    children:[]
#  p4c9c2._id =Laniakea.Collection.AddressChina.insert(p4c9c2)
#
#  p4c9c3 =
#    name:'香河县'
#    sn:'香河县'
#    code:''
#    parent:p4c9._id
#  #    children:[]
#  p4c9c3._id =Laniakea.Collection.AddressChina.insert(p4c9c3)
#
#  p4c9c4 =
#    name:'大城县'
#    sn:'大城县'
#    code:''
#    parent:p4c9._id
#  #    children:[]
#  p4c9c4._id =Laniakea.Collection.AddressChina.insert(p4c9c4)
#
#  p4c9c5 =
#    name:'文安县'
#    sn:'文安县'
#    code:''
#    parent:p4c9._id
#  #    children:[]
#  p4c9c5._id =Laniakea.Collection.AddressChina.insert(p4c9c5)
#
#  p4c9c6 =
#    name:'大厂回族自治县'
#    sn:'大厂回族自治县'
#    code:''
#    parent:p4c9._id
#  #    children:[]
#  p4c9c6._id =Laniakea.Collection.AddressChina.insert(p4c9c6)
#
#  p4c9c7 =
#    name:'霸州市'
#    sn:'霸州市'
#    code:''
#    parent:p4c9._id
#  #    children:[]
#  p4c9c7._id =Laniakea.Collection.AddressChina.insert(p4c9c7)
#
#  p4c9c8 =
#    name:'三河市'
#    sn:'三河市'
#    code:''
#    parent:p4c9._id
#  #    children:[]
#  p4c9c8._id =Laniakea.Collection.AddressChina.insert(p4c9c8)
#
#
#  children10=[p4c9c0._id,p4c9c1._id,p4c9c2._id,p4c9c3._id,p4c9c4._id,p4c9c5._id,
#             p4c9c6._id,p4c9c7._id,p4c9c8._id]
#  Laniakea.Collection.AddressChina.update({_id:p4c9._id},{$set:{'children':children10}})
#
#
#
#
#  #    p4c10 -----------------------------------------------------------------------------------------
#  p4c10 =
#    name:'衡水市'
#    sn:'衡水市'
#    code:''
#    level:1
#    parent:p4._id
#    children:[]
#  p4c10._id =Laniakea.Collection.AddressChina.insert(p4c10)
#
#  #   p4c10 县:start
#  p4c10c0 =
#    name:'桃城区'
#    sn:'桃城区'
#    code:''
#    parent:p4c10._id
#  #    children:[]
#  p4c10c0._id =Laniakea.Collection.AddressChina.insert(p4c10c0)
#
#  p4c10c1 =
#    name:'枣强县'
#    sn:'枣强县'
#    code:''
#    parent:p4c10._id
#  #    children:[]
#  p4c10c1._id =Laniakea.Collection.AddressChina.insert(p4c10c1)
#
#  p4c10c2 =
#    name:'武邑县'
#    sn:'武邑县'
#    code:''
#    parent:p4c10._id
#  #    children:[]
#  p4c10c2._id =Laniakea.Collection.AddressChina.insert(p4c10c2)
#
#  p4c10c3 =
#    name:'武强县'
#    sn:'武强县'
#    code:''
#    parent:p4c10._id
#  #    children:[]
#  p4c10c3._id =Laniakea.Collection.AddressChina.insert(p4c10c3)
#
#  p4c10c4 =
#    name:'饶阳县'
#    sn:'饶阳县'
#    code:''
#    parent:p4c10._id
#  #    children:[]
#  p4c10c4._id =Laniakea.Collection.AddressChina.insert(p4c10c4)
#
#  p4c10c5 =
#    name:'安平县'
#    sn:'安平县'
#    code:''
#    parent:p4c10._id
#  #    children:[]
#  p4c10c5._id =Laniakea.Collection.AddressChina.insert(p4c10c5)
#
#  p4c10c6 =
#    name:'故城县'
#    sn:'故城县'
#    code:''
#    parent:p4c10._id
#  #    children:[]
#  p4c10c6._id =Laniakea.Collection.AddressChina.insert(p4c10c6)
#
#  p4c10c7 =
#    name:'景县'
#    sn:'景县'
#    code:''
#    parent:p4c10._id
#  #    children:[]
#  p4c10c7._id =Laniakea.Collection.AddressChina.insert(p4c10c7)
#
#  p4c10c8 =
#    name:'阜城县'
#    sn:'阜城县'
#    code:''
#    parent:p4c10._id
#  #    children:[]
#  p4c10c8._id =Laniakea.Collection.AddressChina.insert(p4c10c8)
#
#  p4c10c9 =
#    name:'冀州市'
#    sn:'冀州市'
#    code:''
#    parent:p4c10._id
#  #    children:[]
#  p4c10c9._id =Laniakea.Collection.AddressChina.insert(p4c10c9)
#
#  p4c10c10 =
#    name:'深州市'
#    sn:'深州市'
#    code:''
#    parent:p4c10._id
#  #    children:[]
#  p4c10c10._id =Laniakea.Collection.AddressChina.insert(p4c10c10)
#
#
#  children11=[p4c10c0._id,p4c10c1._id,p4c10c2._id,p4c10c3._id,p4c10c4._id,p4c10c5._id,
#             p4c10c6._id,p4c10c7._id,p4c10c8._id,p4c10c9._id,p4c10c10._id]
#  Laniakea.Collection.AddressChina.update({_id:p4c10._id},{$set:{'children':children11}})
#
#
#
#  Laniakea.Collection.AddressChina.update({_id:p4._id},{$set:{'children':[p4c0._id,p4c1._id,p4c2._id,p4c3._id,p4c4._id,p4c5._id,p4c6._id,p4c7._id,p4c8._id,p4c9._id,p4c10._id]}})
  Laniakea.Collection.AddressChina.update({_id:p4._id},{$set:{'children':[{'_id':p4c0._id,'name':p4c0.name},{'_id':p4c1._id,'name':p4c1.name}]}})

@Laniakea.Seed.AddressChinaSeeding3 = () ->
  console.log 'seed '
  p5 =
    name:'山西'
    sn:'晋'
    code:''
    level:0
#      parent:''
    children:[]
  p5._id =Laniakea.Collection.AddressChina.insert(p5)

  #    p5c0 -----------------------------------------------------------------------------------------------------------------
  p5c0 =
    name:'太原'
    sn:'太原'
    code:''
    level:1
    parent:p5._id
    children:[]
  p5c0._id =Laniakea.Collection.AddressChina.insert(p5c0)


  #    p5c1 -----------------------------------------------------------------------------------------------------------------
  p5c1 =
    name:'大同'
    sn:'大同'
    code:''
    level:1
    parent:p5._id
    children:[]
  p5c1._id =Laniakea.Collection.AddressChina.insert(p5c1)



  #    p5c2 -----------------------------------------------------------------------------------------------------------------
  p5c2 =
    name:'阳泉'
    sn:'阳泉'
    code:''
    level:1
    parent:p5._id
    children:[]
  p5c2._id =Laniakea.Collection.AddressChina.insert(p5c2)



  #    p5c3 -----------------------------------------------------------------------------------------------------------------
  p5c3 =
    name:'长治'
    sn:'长治'
    code:''
    level:1
    parent:p5._id
    children:[]
  p5c3._id =Laniakea.Collection.AddressChina.insert(p5c3)


  p5c3c0 =
    name:'城区'
#    sn:''
    code:''
    level:2
    parent:p5c3._id
    children:[]
  p5c3c0._id =Laniakea.Collection.AddressChina.insert(p5c3c0)

  p5c3c1 =
    name:'郊区'
  #    sn:''
    code:''
    level:2
    parent:p5c3._id
    children:[]
  p5c3c1._id =Laniakea.Collection.AddressChina.insert(p5c3c1)

  p5c3c2 =
    name:'长治'
  #    sn:''
    code:''
    level:2
    parent:p5c3._id
    children:[]
  p5c3c2._id =Laniakea.Collection.AddressChina.insert(p5c3c2)

  p5c3c3 =
    name:'襄垣'
  #    sn:''
    code:''
    level:2
    parent:p5c3._id
    children:[]
  p5c3c3._id =Laniakea.Collection.AddressChina.insert(p5c3c3)

  p5c3c4 =
    name:'屯留'
  #    sn:''
    code:''
    level:2
    parent:p5c3._id
    children:[]
  p5c3c4._id =Laniakea.Collection.AddressChina.insert(p5c3c4)

  p5c3c5 =
    name:'平顺'
  #    sn:''
    code:''
    level:2
    parent:p5c3._id
    children:[]
  p5c3c5._id =Laniakea.Collection.AddressChina.insert(p5c3c5)

  p5c3c6 =
    name:'黎城'
  #    sn:''
    code:''
    level:2
    parent:p5c3._id
    children:[]
  p5c3c6._id =Laniakea.Collection.AddressChina.insert(p5c3c6)

  p5c3c7 =
    name:'壶关'
  #    sn:''
    code:''
    level:2
    parent:p5c3._id
    children:[]
  p5c3c7._id =Laniakea.Collection.AddressChina.insert(p5c3c7)

  p5c3c8 =
    name:'长子'
  #    sn:''
    code:''
    level:2
    parent:p5c3._id
    children:[]
  p5c3c8._id =Laniakea.Collection.AddressChina.insert(p5c3c8)

  p5c3c9 =
    name:'武乡'
  #    sn:''
    code:''
    level:2
    parent:p5c3._id
    children:[]
  p5c3c9._id =Laniakea.Collection.AddressChina.insert(p5c3c9)

  p5c3c10 =
    name:'沁县'
  #    sn:''
    code:''
    level:2
    parent:p5c3._id
    children:[]
  p5c3c10._id =Laniakea.Collection.AddressChina.insert(p5c3c10)

  p5c3c11 =
    name:'沁源'
  #    sn:''
    code:''
    level:2
    parent:p5c3._id
    children:[]
  p5c3c11._id =Laniakea.Collection.AddressChina.insert(p5c3c11)

#  =========================================================================================================
  p5c3c12 =
    name:'潞城'
  #    sn:''
    code:''
    level:2
    parent:p5c3._id
    children:[]
  p5c3c12._id =Laniakea.Collection.AddressChina.insert(p5c3c12)

  p5c3c12t0 =
    name:'潞华'
  #    sn:''
    code:''
    level:3
    parent:p5c3c12._id
    children:[]
  p5c3c12t0._id =Laniakea.Collection.AddressChina.insert(p5c3c12t0)

  p5c3c12t1 =
    name:'成家川'
  #    sn:''
    code:''
    level:3
    parent:p5c3c12._id
    children:[]
  p5c3c12t1._id =Laniakea.Collection.AddressChina.insert(p5c3c12t1)

  p5c3c12t2 =
    name:'店上'
  #    sn:''
    code:''
    level:3
    parent:p5c3c12._id
    children:[]
  p5c3c12t2._id =Laniakea.Collection.AddressChina.insert(p5c3c12t2)

  p5c3c12t3 =
    name:'微子'
  #    sn:''
    code:''
    level:3
    parent:p5c3c12._id
    children:[]
  p5c3c12t3._id =Laniakea.Collection.AddressChina.insert(p5c3c12t3)

  p5c3c12t4 =
    name:'辛安泉'
  #    sn:''
    code:''
    level:3
    parent:p5c3c12._id
    children:[]
  p5c3c12t4._id =Laniakea.Collection.AddressChina.insert(p5c3c12t4)

  p5c3c12t5 =
    name:'翟店'
  #    sn:''
    code:''
    level:3
    parent:p5c3c12._id
    children:[]
  p5c3c12t5._id =Laniakea.Collection.AddressChina.insert(p5c3c12t5)

  p5c3c12t6 =
    name:'合室'
  #    sn:''
    code:''
    level:3
    parent:p5c3c12._id
    children:[]
  p5c3c12t6._id =Laniakea.Collection.AddressChina.insert(p5c3c12t6)

  p5c3c12t7 =
    name:'黄牛蹄'
  #    sn:''
    code:''
    level:3
    parent:p5c3c12._id
    children:[]
  p5c3c12t7._id =Laniakea.Collection.AddressChina.insert(p5c3c12t7)

  p5c3c12t8 =
    name:'史迥'
  #    sn:''
    code:''
    level:3
    parent:p5c3c12._id
    children:[]
  p5c3c12t8._id =Laniakea.Collection.AddressChina.insert(p5c3c12t8)

  p5c3c12t9 =
    name:'史回'
  #    sn:''
    code:''
    level:3
    parent:p5c3c12._id
    children:[]
  p5c3c12t9._id =Laniakea.Collection.AddressChina.insert(p5c3c12t9)

#  children_lc=[p5c3c12t0._id,p5c3c12t1._id,p5c3c12t2._id,p5c3c12t3._id,p5c3c12t4._id,p5c3c12t5._id,
#               p5c3c12t6._id,p5c3c12t7._id,p5c3c12t8._id,p5c3c12t9._id]
  children_lc=[{'_id':p5c3c12t0._id,'name':p5c3c12t0.name},{'_id':p5c3c12t1._id,'name':p5c3c12t1.name},
    {'_id':p5c3c12t2._id,'name':p5c3c12t2.name},{'_id':p5c3c12t3._id,'name':p5c3c12t3.name},
    {'_id':p5c3c12t4._id,'name':p5c3c12t4.name},{'_id':p5c3c12t5._id,'name':p5c3c12t5.name},
    {'_id':p5c3c12t6._id,'name':p5c3c12t6.name},{'_id':p5c3c12t7._id,'name':p5c3c12t7.name},
    {'_id':p5c3c12t8._id,'name':p5c3c12t8.name},{'_id':p5c3c12t9._id,'name':p5c3c12t9.name}]

  Laniakea.Collection.AddressChina.update({_id:p5c3c12._id},{$set:{'children':children_lc}})
#  children_cz=[p5c3c0._id,p5c3c1._id,p5c3c2._id,p5c3c3._id,p5c3c4._id,p5c3c5._id,
#               p5c3c6._id,p5c3c7._id,p5c3c8._id,p5c3c9._id,p5c3c10._id,p5c3c11._id,
#               p5c3c12._id]
  children_cz=[{'_id':p5c3c0._id,'name':p5c3c0.name},{'_id':p5c3c1._id,'name':p5c3c1.name},
              {'_id':p5c3c2._id,'name':p5c3c2.name},{'_id':p5c3c3._id,'name':p5c3c3.name},
              {'_id':p5c3c4._id,'name':p5c3c4.name},{'_id':p5c3c5._id,'name':p5c3c5.name},
              {'_id':p5c3c6._id,'name':p5c3c6.name},{'_id':p5c3c7._id,'name':p5c3c7.name},
              {'_id':p5c3c8._id,'name':p5c3c8.name},{'_id':p5c3c9._id,'name':p5c3c9.name},
              {'_id':p5c3c10._id,'name':p5c3c10.name},{'_id':p5c3c11._id,'name':p5c3c11.name},
              {'_id':p5c3c12._id,'name':p5c3c12.name}]
  Laniakea.Collection.AddressChina.update({_id:p5c3._id},{$set:{'children':children_cz}})




  #    p5c4 -----------------------------------------------------------------------------------------------------------------
  p5c4 =
    name:'晋城'
    sn:'晋城'
    code:''
    level:1
    parent:p5._id
    children:[]
  p5c4._id =Laniakea.Collection.AddressChina.insert(p5c4)



  #    p5c5 -----------------------------------------------------------------------------------------------------------------
  p5c5 =
    name:'朔州'
    sn:'朔州'
    code:''
    level:1
    parent:p5._id
    children:[]
  p5c5._id =Laniakea.Collection.AddressChina.insert(p5c5)



  #    p5c6 -----------------------------------------------------------------------------------------------------------------
  p5c6 =
    name:'忻州'
    sn:'忻州'
    code:''
    level:1
    parent:p5._id
    children:[]
  p5c6._id =Laniakea.Collection.AddressChina.insert(p5c6)




  #    p5c7 -----------------------------------------------------------------------------------------------------------------
  p5c7 =
    name:'吕梁'
    sn:'吕梁'
    code:''
    level:1
    parent:p5._id
    children:[]
  p5c7._id =Laniakea.Collection.AddressChina.insert(p5c7)



  #    p5c8 -----------------------------------------------------------------------------------------------------------------
  p5c8 =
    name:'晋中'
    sn:'晋中'
    code:''
    level:1
    parent:p5._id
    children:[]
  p5c8._id =Laniakea.Collection.AddressChina.insert(p5c8)



  #    p5c9 -----------------------------------------------------------------------------------------------------------------
  p5c9 =
    name:'临汾'
    sn:'临汾'
    code:''
    level:1
    parent:p5._id
    children:[]
  p5c9._id =Laniakea.Collection.AddressChina.insert(p5c9)



  #    p5c10 -----------------------------------------------------------------------------------------------------------------
  p5c10 =
    name:'运城'
    sn:'运城'
    code:''
    level:1
    parent:p5._id
    children:[]
  p5c10._id =Laniakea.Collection.AddressChina.insert(p5c10)

  children=[{'_id':p5c0._id,'name':p5c0.name},{'_id':p5c1._id,'name':p5c1.name},
    {'_id':p5c2._id,'name':p5c2.name},{'_id':p5c3._id,'name':p5c3.name},
    {'_id':p5c4._id,'name':p5c4.name},{'_id':p5c5._id,'name':p5c5.name},
    {'_id':p5c6._id,'name':p5c6.name},{'_id':p5c7._id,'name':p5c7.name},
    {'_id':p5c8._id,'name':p5c8.name},{'_id':p5c9._id,'name':p5c9.name},
    {'_id':p5c10._id,'name':p5c10.name}]
  Laniakea.Collection.AddressChina.update({_id:p5._id},{$set:{'children':children}})


@Laniakea.Seed.AddressChinaSeeding4 = () ->
  console.log 'seed4 '
  p6 =
    name:'宁夏'
    sn:'宁'
    code:''
    level:0
#      parent:''
    children:[]
  p6._id =Laniakea.Collection.AddressChina.insert(p6)

##############################    p6c0   -----------------------------------------------------------------------------------------------------------------
  p6c0 =
    name:'银川'
    sn:'银川'
    code:''
    level:1
    parent:p6._id
    children:[]
  p6c0._id =Laniakea.Collection.AddressChina.insert(p6c0)

  #  ==========兴庆=============================================================================================================
  p6c0c0 =
    name:'兴庆'
#    sn:''
    code:''
    level:2
    parent:p6c0._id
    children:[]
  p6c0c0._id =Laniakea.Collection.AddressChina.insert(p6c0c0)

  p6c0c0t0 =
    name:'城区'
  #    sn:''
    code:''
    level:3
    parent:p6c0c0._id
    children:[]
  p6c0c0t0._id =Laniakea.Collection.AddressChina.insert(p6c0c0t0)

  p6c0c0t1 =
    name:'掌政'
  #    sn:''
    code:''
    level:3
    parent:p6c0c0._id
    children:[]
  p6c0c0t1._id =Laniakea.Collection.AddressChina.insert(p6c0c0t1)

  p6c0c0t2 =
    name:'大新'
  #    sn:''
    code:''
    level:3
    parent:p6c0c0._id
    children:[]
  p6c0c0t2._id =Laniakea.Collection.AddressChina.insert(p6c0c0t2)

  p6c0c0t3 =
    name:'月牙湖'
  #    sn:''
    code:''
    level:3
    parent:p6c0c0._id
    children:[]
  p6c0c0t3._id =Laniakea.Collection.AddressChina.insert(p6c0c0t3)

  p6c0c0t4 =
    name:'童贯'
  #    sn:''
    code:''
    level:3
    parent:p6c0c0._id
    children:[]
  p6c0c0t4._id =Laniakea.Collection.AddressChina.insert(p6c0c0t4)

  children_xq=[{'_id':p6c0c0t0._id,'name':p6c0c0t0.name},{'_id':p6c0c0t1._id,'name':p6c0c0t1.name},
    {'_id':p6c0c0t2._id,'name':p6c0c0t2.name},{'_id':p6c0c0t3._id,'name':p6c0c0t3.name},
    {'_id':p6c0c0t4._id,'name':p6c0c0t4.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c0c0._id},{$set:{'children':children_xq}})

  #  ==========西夏=============================================================================================================
  p6c0c1 =
    name:'西夏'
  #    sn:''
    code:''
    level:2
    parent:p6c0._id
    children:[]
  p6c0c1._id =Laniakea.Collection.AddressChina.insert(p6c0c1)

  p6c0c1t0 =
    name:'城区'
  #    sn:''
    code:''
    level:3
    parent:p6c0c1._id
    children:[]
  p6c0c1t0._id =Laniakea.Collection.AddressChina.insert(p6c0c1t0)

  p6c0c1t1 =
    name:'镇北堡'
  #    sn:''
    code:''
    level:3
    parent:p6c0c1._id
    children:[]
  p6c0c1t1._id =Laniakea.Collection.AddressChina.insert(p6c0c1t1)

  p6c0c1t2 =
    name:'兴泾'
  #    sn:''
    code:''
    level:3
    parent:p6c0c1._id
    children:[]
  p6c0c1t2._id =Laniakea.Collection.AddressChina.insert(p6c0c1t2)

  children_xx=[{'_id':p6c0c1t0._id,'name':p6c0c1t0.name},{'_id':p6c0c1t1._id,'name':p6c0c1t1.name},
    {'_id':p6c0c1t2._id,'name':p6c0c1t2.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c0c1._id},{$set:{'children':children_xx}})

  #  ==========金凤=============================================================================================================
  p6c0c2 =
    name:'金凤'
  #    sn:''
    code:''
    level:2
    parent:p6c0._id
    children:[]
  p6c0c2._id =Laniakea.Collection.AddressChina.insert(p6c0c2)

  p6c0c2t0 =
    name:'满城北街'
  #    sn:''
    code:''
    level:3
    parent:p6c0c2._id
    children:[]
  p6c0c2t0._id =Laniakea.Collection.AddressChina.insert(p6c0c2t0)

  p6c0c2t1 =
    name:'黄河东路'
  #    sn:''
    code:''
    level:3
    parent:p6c0c2._id
    children:[]
  p6c0c2t1._id =Laniakea.Collection.AddressChina.insert(p6c0c2t1)

  p6c0c2t2 =
    name:'长城中路'
  #    sn:''
    code:''
    level:3
    parent:p6c0c2._id
    children:[]
  p6c0c2t2._id =Laniakea.Collection.AddressChina.insert(p6c0c2t2)

  p6c0c2t3 =
    name:'北京中路'
  #    sn:''
    code:''
    level:3
    parent:p6c0c2._id
    children:[]
  p6c0c2t3._id =Laniakea.Collection.AddressChina.insert(p6c0c2t3)

  p6c0c2t4 =
    name:'上海西路'
  #    sn:''
    code:''
    level:3
    parent:p6c0c2._id
    children:[]
  p6c0c2t4._id =Laniakea.Collection.AddressChina.insert(p6c0c2t4)

  p6c0c2t5 =
    name:'良田'
  #    sn:''
    code:''
    level:3
    parent:p6c0c2._id
    children:[]
  p6c0c2t5._id =Laniakea.Collection.AddressChina.insert(p6c0c2t5)

  p6c0c2t6 =
    name:'丰登'
  #    sn:''
    code:''
    level:3
    parent:p6c0c2._id
    children:[]
  p6c0c2t6._id =Laniakea.Collection.AddressChina.insert(p6c0c2t6)

  p6c0c2t7 =
    name:'西湖'
  #    sn:''
    code:''
    level:3
    parent:p6c0c2._id
    children:[]
  p6c0c2t7._id =Laniakea.Collection.AddressChina.insert(p6c0c2t7)

  p6c0c2t8 =
    name:'银川'
  #    sn:''
    code:''
    level:3
    parent:p6c0c2._id
    children:[]
  p6c0c2t8._id =Laniakea.Collection.AddressChina.insert(p6c0c2t8)

  children_jf=[{'_id':p6c0c2t0._id,'name':p6c0c2t0.name},{'_id':p6c0c2t1._id,'name':p6c0c2t1.name},
    {'_id':p6c0c2t2._id,'name':p6c0c2t2.name},{'_id':p6c0c2t3._id,'name':p6c0c2t3.name},
    {'_id':p6c0c2t4._id,'name':p6c0c2t4.name},{'_id':p6c0c2t5._id,'name':p6c0c2t5.name},
    {'_id':p6c0c2t6._id,'name':p6c0c2t6.name},{'_id':p6c0c2t7._id,'name':p6c0c2t7.name},
    {'_id':p6c0c2t8._id,'name':p6c0c2t8.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c0c2._id},{$set:{'children':children_jf}})

  #  ==========贺兰=============================================================================================================
  p6c0c3 =
    name:'贺兰'
  #    sn:''
    code:''
    level:2
    parent:p6c0._id
    children:[]
  p6c0c3._id =Laniakea.Collection.AddressChina.insert(p6c0c3)

  p6c0c3t0 =
    name:'习岗'
  #    sn:''
    code:''
    level:3
    parent:p6c0c3._id
    children:[]
  p6c0c3t0._id =Laniakea.Collection.AddressChina.insert(p6c0c3t0)

  p6c0c3t1 =
    name:'金贵'
  #    sn:''
    code:''
    level:3
    parent:p6c0c3._id
    children:[]
  p6c0c3t1._id =Laniakea.Collection.AddressChina.insert(p6c0c3t1)

  p6c0c3t2 =
    name:'立岗'
  #    sn:''
    code:''
    level:3
    parent:p6c0c3._id
    children:[]
  p6c0c3t2._id =Laniakea.Collection.AddressChina.insert(p6c0c3t2)

  p6c0c3t3 =
    name:'洪广'
  #    sn:''
    code:''
    level:3
    parent:p6c0c3._id
    children:[]
  p6c0c3t3._id =Laniakea.Collection.AddressChina.insert(p6c0c3t3)

  p6c0c3t4 =
    name:'常信'
  #    sn:''
    code:''
    level:3
    parent:p6c0c3._id
    children:[]
  p6c0c3t4._id =Laniakea.Collection.AddressChina.insert(p6c0c3t4)

  p6c0c3t5 =
    name:'南梁台子'
  #    sn:''
    code:''
    level:3
    parent:p6c0c3._id
    children:[]
  p6c0c3t5._id =Laniakea.Collection.AddressChina.insert(p6c0c3t5)

  p6c0c3t6 =
    name:'宁夏原种场'
  #    sn:''
    code:''
    level:3
    parent:p6c0c3._id
    children:[]
  p6c0c3t6._id =Laniakea.Collection.AddressChina.insert(p6c0c3t6)

  p6c0c3t7 =
    name:'京星农牧场'
  #    sn:''
    code:''
    level:3
    parent:p6c0c3._id
    children:[]
  p6c0c3t7._id =Laniakea.Collection.AddressChina.insert(p6c0c3t7)

  p6c0c3t8 =
    name:'暖泉'
  #    sn:''
    code:''
    level:3
    parent:p6c0c3._id
    children:[]
  p6c0c3t8._id =Laniakea.Collection.AddressChina.insert(p6c0c3t8)

  p6c0c3t9 =
    name:'县城'
  #    sn:''
    code:''
    level:3
    parent:p6c0c3._id
    children:[]
  p6c0c3t9._id =Laniakea.Collection.AddressChina.insert(p6c0c3t9)

  children_hl=[{'_id':p6c0c3t0._id,'name':p6c0c3t0.name},{'_id':p6c0c3t1._id,'name':p6c0c3t1.name},
    {'_id':p6c0c3t2._id,'name':p6c0c3t2.name},{'_id':p6c0c3t3._id,'name':p6c0c3t3.name},
    {'_id':p6c0c3t4._id,'name':p6c0c3t4.name},{'_id':p6c0c3t5._id,'name':p6c0c3t5.name},
    {'_id':p6c0c3t6._id,'name':p6c0c3t6.name},{'_id':p6c0c3t7._id,'name':p6c0c3t7.name},
    {'_id':p6c0c3t8._id,'name':p6c0c3t8.name},{'_id':p6c0c3t9._id,'name':p6c0c3t9.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c0c3._id},{$set:{'children':children_hl}})

  #  ==========永宁=============================================================================================================
  p6c0c4 =
    name:'永宁'
  #    sn:''
    code:''
    level:2
    parent:p6c0._id
    children:[]
  p6c0c4._id =Laniakea.Collection.AddressChina.insert(p6c0c4)

  p6c0c4t0 =
    name:'李俊'
  #    sn:''
    code:''
    level:3
    parent:p6c0c4._id
    children:[]
  p6c0c4t0._id =Laniakea.Collection.AddressChina.insert(p6c0c4t0)

  p6c0c4t1 =
    name:'望远'
  #    sn:''
    code:''
    level:3
    parent:p6c0c4._id
    children:[]
  p6c0c4t1._id =Laniakea.Collection.AddressChina.insert(p6c0c4t1)

  p6c0c4t2 =
    name:'望洪'
  #    sn:''
    code:''
    level:3
    parent:p6c0c4._id
    children:[]
  p6c0c4t2._id =Laniakea.Collection.AddressChina.insert(p6c0c4t2)

  p6c0c4t3 =
    name:'闽宁'
  #    sn:''
    code:''
    level:3
    parent:p6c0c4._id
    children:[]
  p6c0c4t3._id =Laniakea.Collection.AddressChina.insert(p6c0c4t3)

  p6c0c4t4 =
    name:'胜利'
  #    sn:''
    code:''
    level:3
    parent:p6c0c4._id
    children:[]
  p6c0c4t4._id =Laniakea.Collection.AddressChina.insert(p6c0c4t4)

  p6c0c4t5 =
    name:'黄羊滩'
  #    sn:''
    code:''
    level:3
    parent:p6c0c4._id
    children:[]
  p6c0c4t5._id =Laniakea.Collection.AddressChina.insert(p6c0c4t5)

  p6c0c4t6 =
    name:'玉泉营'
  #    sn:''
    code:''
    level:3
    parent:p6c0c4._id
    children:[]
  p6c0c4t6._id =Laniakea.Collection.AddressChina.insert(p6c0c4t6)

  p6c0c4t7 =
    name:'城区'
  #    sn:''
    code:''
    level:3
    parent:p6c0c4._id
    children:[]
  p6c0c4t7._id =Laniakea.Collection.AddressChina.insert(p6c0c4t7)


  children_yn=[{'_id':p6c0c4t0._id,'name':p6c0c4t0.name},{'_id':p6c0c4t1._id,'name':p6c0c4t1.name},
    {'_id':p6c0c4t2._id,'name':p6c0c4t2.name},{'_id':p6c0c4t3._id,'name':p6c0c4t3.name},
    {'_id':p6c0c4t4._id,'name':p6c0c4t4.name},{'_id':p6c0c4t5._id,'name':p6c0c4t5.name},
    {'_id':p6c0c4t6._id,'name':p6c0c4t6.name},{'_id':p6c0c4t7._id,'name':p6c0c4t7.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c0c4._id},{$set:{'children':children_yn}})

  #  ==========灵武=============================================================================================================
  p6c0c5 =
    name:'灵武'
  #    sn:''
    code:''
    level:2
    parent:p6c0._id
    children:[]
  p6c0c5._id =Laniakea.Collection.AddressChina.insert(p6c0c5)

  p6c0c5t0 =
    name:'郝家桥'
  #    sn:''
    code:''
    level:3
    parent:p6c0c5._id
    children:[]
  p6c0c5t0._id =Laniakea.Collection.AddressChina.insert(p6c0c5t0)

  p6c0c5t1 =
    name:'马家滩'
  #    sn:''
    code:''
    level:3
    parent:p6c0c5._id
    children:[]
  p6c0c5t1._id =Laniakea.Collection.AddressChina.insert(p6c0c5t1)

  p6c0c5t2 =
    name:'东塔镇'
  #    sn:''
    code:''
    level:3
    parent:p6c0c5._id
    children:[]
  p6c0c5t2._id =Laniakea.Collection.AddressChina.insert(p6c0c5t2)

  p6c0c5t3 =
    name:'崇兴'
  #    sn:''
    code:''
    level:3
    parent:p6c0c5._id
    children:[]
  p6c0c5t3._id =Laniakea.Collection.AddressChina.insert(p6c0c5t3)

  p6c0c5t4 =
    name:'宁东'
  #    sn:''
    code:''
    level:3
    parent:p6c0c5._id
    children:[]
  p6c0c5t4._id =Laniakea.Collection.AddressChina.insert(p6c0c5t4)

  p6c0c5t5 =
    name:'临河'
  #    sn:''
    code:''
    level:3
    parent:p6c0c5._id
    children:[]
  p6c0c5t5._id =Laniakea.Collection.AddressChina.insert(p6c0c5t5)

  p6c0c5t6 =
    name:'梧桐树'
  #    sn:''
    code:''
    level:3
    parent:p6c0c5._id
    children:[]
  p6c0c5t6._id =Laniakea.Collection.AddressChina.insert(p6c0c5t6)

  p6c0c5t7 =
    name:'白土岗'
  #    sn:''
    code:''
    level:3
    parent:p6c0c5._id
    children:[]
  p6c0c5t7._id =Laniakea.Collection.AddressChina.insert(p6c0c5t7)

  p6c0c5t8 =
    name:'狼皮子梁'
  #    sn:''
    code:''
    level:3
    parent:p6c0c5._id
    children:[]
  p6c0c5t8._id =Laniakea.Collection.AddressChina.insert(p6c0c5t8)

  p6c0c5t9 =
    name:'灵武农场'
  #    sn:''
    code:''
    level:3
    parent:p6c0c5._id
    children:[]
  p6c0c5t9._id =Laniakea.Collection.AddressChina.insert(p6c0c5t9)

  p6c0c5t10 =
    name:'城区'
  #    sn:''
    code:''
    level:3
    parent:p6c0c5._id
    children:[]
  p6c0c5t10._id =Laniakea.Collection.AddressChina.insert(p6c0c5t10)


  children_lw=[{'_id':p6c0c5t0._id,'name':p6c0c5t0.name},{'_id':p6c0c5t1._id,'name':p6c0c5t1.name},
    {'_id':p6c0c5t2._id,'name':p6c0c5t2.name},{'_id':p6c0c5t3._id,'name':p6c0c5t3.name},
    {'_id':p6c0c5t4._id,'name':p6c0c5t4.name},{'_id':p6c0c5t5._id,'name':p6c0c5t5.name},
    {'_id':p6c0c5t6._id,'name':p6c0c5t6.name},{'_id':p6c0c5t7._id,'name':p6c0c5t7.name},
    {'_id':p6c0c5t8._id,'name':p6c0c5t8.name},{'_id':p6c0c5t9._id,'name':p6c0c5t9.name},
    {'_id':p6c0c5t10._id,'name':p6c0c5t10.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c0c5._id},{$set:{'children':children_lw}})


  children_yc=[{'_id':p6c0c0._id,'name':p6c0c0.name},{'_id':p6c0c1._id,'name':p6c0c1.name},
    {'_id':p6c0c2._id,'name':p6c0c2.name},{'_id':p6c0c3._id,'name':p6c0c3.name},
    {'_id':p6c0c4._id,'name':p6c0c4.name},{'_id':p6c0c5._id,'name':p6c0c5.name}]
  Laniakea.Collection.AddressChina.update({_id:p6c0._id},{$set:{'children':children_yc}})


##############################    p6c1   -----------------------------------------------------------------------------------------------------------------
  p6c1 =
    name:'石嘴山'
    sn:'石嘴山'
    code:''
    level:1
    parent:p6._id
    children:[]
  p6c1._id =Laniakea.Collection.AddressChina.insert(p6c1)

  #  ==========大武口=============================================================================================================
  p6c1c0 =
    name:'大武口'
#    sn:''
    code:''
    level:2
    parent:p6c1._id
    children:[]
  p6c1c0._id =Laniakea.Collection.AddressChina.insert(p6c1c0)

  p6c1c0t0 =
    name:'人民路'
  #    sn:''
    code:''
    level:3
    parent:p6c1c0._id
    children:[]
  p6c1c0t0._id =Laniakea.Collection.AddressChina.insert(p6c1c0t0)

  p6c1c0t1 =
    name:'石炭井'
  #    sn:''
    code:''
    level:3
    parent:p6c1c0._id
    children:[]
  p6c1c0t1._id =Laniakea.Collection.AddressChina.insert(p6c1c0t1)

  p6c1c0t2 =
    name:'白芨沟'
  #    sn:''
    code:''
    level:3
    parent:p6c1c0._id
    children:[]
  p6c1c0t2._id =Laniakea.Collection.AddressChina.insert(p6c1c0t2)

  p6c1c0t3 =
    name:'朝阳'
  #    sn:''
    code:''
    level:3
    parent:p6c1c0._id
    children:[]
  p6c1c0t3._id =Laniakea.Collection.AddressChina.insert(p6c1c0t3)

  p6c1c0t4 =
    name:'长胜'
  #    sn:''
    code:''
    level:3
    parent:p6c1c0._id
    children:[]
  p6c1c0t4._id =Laniakea.Collection.AddressChina.insert(p6c1c0t4)

  p6c1c0t5 =
    name:'长城'
  #    sn:''
    code:''
    level:3
    parent:p6c1c0._id
    children:[]
  p6c1c0t5._id =Laniakea.Collection.AddressChina.insert(p6c1c0t5)

  p6c1c0t6 =
    name:'青山'
  #    sn:''
    code:''
    level:3
    parent:p6c1c0._id
    children:[]
  p6c1c0t6._id =Laniakea.Collection.AddressChina.insert(p6c1c0t6)

  p6c1c0t7 =
    name:'沟口'
  #    sn:''
    code:''
    level:3
    parent:p6c1c0._id
    children:[]
  p6c1c0t7._id =Laniakea.Collection.AddressChina.insert(p6c1c0t7)

  p6c1c0t8 =
    name:'长兴'
  #    sn:''
    code:''
    level:3
    parent:p6c1c0._id
    children:[]
  p6c1c0t8._id =Laniakea.Collection.AddressChina.insert(p6c1c0t8)

  p6c1c0t9 =
    name:'锦林'
  #    sn:''
    code:''
    level:3
    parent:p6c1c0._id
    children:[]
  p6c1c0t9._id =Laniakea.Collection.AddressChina.insert(p6c1c0t9)

  p6c1c0t10 =
    name:'星海'
  #    sn:''
    code:''
    level:3
    parent:p6c1c0._id
    children:[]
  p6c1c0t10._id =Laniakea.Collection.AddressChina.insert(p6c1c0t10)

  children_dwk=[{'_id':p6c1c0t0._id,'name':p6c1c0t0.name},{'_id':p6c1c0t1._id,'name':p6c1c0t1.name},
    {'_id':p6c1c0t2._id,'name':p6c1c0t2.name},{'_id':p6c1c0t3._id,'name':p6c1c0t3.name},
    {'_id':p6c1c0t4._id,'name':p6c1c0t4.name},{'_id':p6c1c0t5._id,'name':p6c1c0t5.name},
    {'_id':p6c1c0t6._id,'name':p6c1c0t6.name},{'_id':p6c1c0t7._id,'name':p6c1c0t7.name},
    {'_id':p6c1c0t8._id,'name':p6c1c0t8.name},{'_id':p6c1c0t9._id,'name':p6c1c0t9.name},
    {'_id':p6c1c0t10._id,'name':p6c1c0t10.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c1c0._id},{$set:{'children':children_dwk}})

  #  ==========惠农=============================================================================================================
  p6c1c1 =
    name:'惠农'
  #    sn:''
    code:''
    level:2
    parent:p6c1._id
    children:[]
  p6c1c1._id =Laniakea.Collection.AddressChina.insert(p6c1c1)

  p6c1c1t0 =
    name:'育才路'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t0._id =Laniakea.Collection.AddressChina.insert(p6c1c1t0)

  p6c1c1t1 =
    name:'火车站'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t1._id =Laniakea.Collection.AddressChina.insert(p6c1c1t1)

  p6c1c1t2 =
    name:'南街'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t2._id =Laniakea.Collection.AddressChina.insert(p6c1c1t2)

  p6c1c1t3 =
    name:'北街'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t3._id =Laniakea.Collection.AddressChina.insert(p6c1c1t3)

  p6c1c1t4 =
    name:'中街'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t4._id =Laniakea.Collection.AddressChina.insert(p6c1c1t4)

  p6c1c1t5 =
    name:'河滨'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t5._id =Laniakea.Collection.AddressChina.insert(p6c1c1t5)

  p6c1c1t6 =
    name:'红果子'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t6._id =Laniakea.Collection.AddressChina.insert(p6c1c1t6)

  p6c1c1t7 =
    name:'尾闸'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t7._id =Laniakea.Collection.AddressChina.insert(p6c1c1t7)

  p6c1c1t8 =
    name:'园艺'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t8._id =Laniakea.Collection.AddressChina.insert(p6c1c1t8)

  p6c1c1t9 =
    name:'燕子墩'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t9._id =Laniakea.Collection.AddressChina.insert(p6c1c1t9)

  p6c1c1t10 =
    name:'庙台'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t10._id =Laniakea.Collection.AddressChina.insert(p6c1c1t10)

  p6c1c1t11 =
    name:'礼和'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t11._id =Laniakea.Collection.AddressChina.insert(p6c1c1t11)

  p6c1c1t12 =
    name:'良种繁殖场'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t12._id =Laniakea.Collection.AddressChina.insert(p6c1c1t12)

  p6c1c1t13 =
    name:'农林牧场'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t13._id =Laniakea.Collection.AddressChina.insert(p6c1c1t13)

  p6c1c1t14 =
    name:'简泉牧场'
  #    sn:''
    code:''
    level:3
    parent:p6c1c1._id
    children:[]
  p6c1c1t14._id =Laniakea.Collection.AddressChina.insert(p6c1c1t14)

  children_hn=[{'_id':p6c1c1t0._id,'name':p6c1c1t0.name},{'_id':p6c1c1t1._id,'name':p6c1c1t1.name},
    {'_id':p6c1c1t2._id,'name':p6c1c1t2.name},{'_id':p6c1c1t3._id,'name':p6c1c1t3.name},
    {'_id':p6c1c1t4._id,'name':p6c1c1t4.name},{'_id':p6c1c1t5._id,'name':p6c1c1t5.name},
    {'_id':p6c1c1t6._id,'name':p6c1c1t6.name},{'_id':p6c1c1t7._id,'name':p6c1c1t7.name},
    {'_id':p6c1c1t8._id,'name':p6c1c1t8.name},{'_id':p6c1c1t9._id,'name':p6c1c1t9.name},
    {'_id':p6c1c1t10._id,'name':p6c1c1t10.name},{'_id':p6c1c1t11._id,'name':p6c1c1t11.name}
    {'_id':p6c1c1t12._id,'name':p6c1c1t12.name},{'_id':p6c1c1t13._id,'name':p6c1c1t13.name},
    {'_id':p6c1c1t14._id,'name':p6c1c1t14.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c1c1._id},{$set:{'children':children_hn}})

  #  ==========平罗=============================================================================================================
  p6c1c2 =
    name:'平罗'
  #    sn:''
    code:''
    level:2
    parent:p6c1._id
    children:[]
  p6c1c2._id =Laniakea.Collection.AddressChina.insert(p6c1c2)

  p6c1c2t0 =
    name:'县城'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t0._id =Laniakea.Collection.AddressChina.insert(p6c1c2t0)

  p6c1c2t1 =
    name:'黄渠桥'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t1._id =Laniakea.Collection.AddressChina.insert(p6c1c2t1)

  p6c1c2t2 =
    name:'城关'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t2._id =Laniakea.Collection.AddressChina.insert(p6c1c2t2)

  p6c1c2t3 =
    name:'宝丰'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t3._id =Laniakea.Collection.AddressChina.insert(p6c1c2t3)

  p6c1c2t4 =
    name:'头闸'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t4._id =Laniakea.Collection.AddressChina.insert(p6c1c2t4)

  p6c1c2t5 =
    name:'姚伏'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t5._id =Laniakea.Collection.AddressChina.insert(p6c1c2t5)

  p6c1c2t6 =
    name:'崇岗'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t6._id =Laniakea.Collection.AddressChina.insert(p6c1c2t6)

  p6c1c2t7 =
    name:'陶乐'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t7._id =Laniakea.Collection.AddressChina.insert(p6c1c2t7)

  p6c1c2t8 =
    name:'红崖子'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t8._id =Laniakea.Collection.AddressChina.insert(p6c1c2t8)
#          前进农场
  p6c1c2t9 =
    name:'高庄'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t9._id =Laniakea.Collection.AddressChina.insert(p6c1c2t9)

  p6c1c2t10 =
    name:'灵沙'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t10._id =Laniakea.Collection.AddressChina.insert(p6c1c2t10)

  p6c1c2t11 =
    name:'渠口'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t11._id =Laniakea.Collection.AddressChina.insert(p6c1c2t11)

  p6c1c2t12 =
    name:'通伏'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t12._id =Laniakea.Collection.AddressChina.insert(p6c1c2t12)

  p6c1c2t13 =
    name:'高仁'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t13._id =Laniakea.Collection.AddressChina.insert(p6c1c2t13)

  p6c1c2t14 =
    name:'前进农场'
  #    sn:''
    code:''
    level:3
    parent:p6c1c2._id
    children:[]
  p6c1c2t14._id =Laniakea.Collection.AddressChina.insert(p6c1c2t14)


  children_pl=[{'_id':p6c1c2t0._id,'name':p6c1c2t0.name},{'_id':p6c1c2t1._id,'name':p6c1c2t1.name},
    {'_id':p6c1c2t2._id,'name':p6c1c2t2.name},{'_id':p6c1c2t3._id,'name':p6c1c2t3.name},
    {'_id':p6c1c2t4._id,'name':p6c1c2t4.name},{'_id':p6c1c2t5._id,'name':p6c1c2t5.name},
    {'_id':p6c1c2t6._id,'name':p6c1c2t6.name},{'_id':p6c1c2t7._id,'name':p6c1c2t7.name},
    {'_id':p6c1c2t8._id,'name':p6c1c2t8.name},{'_id':p6c1c2t9._id,'name':p6c1c2t9.name},
    {'_id':p6c1c2t10._id,'name':p6c1c2t10.name},{'_id':p6c1c2t11._id,'name':p6c1c2t11.name}
    {'_id':p6c1c2t12._id,'name':p6c1c2t12.name},{'_id':p6c1c2t13._id,'name':p6c1c2t13.name},
    {'_id':p6c1c2t14._id,'name':p6c1c2t14.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c1c2._id},{$set:{'children':children_pl}})


  children_szs=[{'_id':p6c1c0._id,'name':p6c1c0.name},{'_id':p6c1c1._id,'name':p6c1c1.name},
    {'_id':p6c1c2._id,'name':p6c1c2.name}]
  Laniakea.Collection.AddressChina.update({_id:p6c1._id},{$set:{'children':children_szs}})



##############################    p6c2   -----------------------------------------------------------------------------------------------------------------
  p6c2 =
    name:'吴忠'
    sn:'吴忠'
    code:''
    level:1
    parent:p6._id
    children:[]
  p6c2._id =Laniakea.Collection.AddressChina.insert(p6c2)

  #  ==========利通=============================================================================================================
  p6c2c0 =
    name:'利通'
#    sn:''
    code:''
    level:2
    parent:p6c2._id
    children:[]
  p6c2c0._id =Laniakea.Collection.AddressChina.insert(p6c2c0)

  p6c2c0t0 =
    name:'金银滩'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t0._id =Laniakea.Collection.AddressChina.insert(p6c2c0t0)

  p6c2c0t1 =
    name:'扁担沟'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t1._id =Laniakea.Collection.AddressChina.insert(p6c2c0t1)

  p6c2c0t2 =
    name:'胜利'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t2._id =Laniakea.Collection.AddressChina.insert(p6c2c0t2)

  p6c2c0t3 =
    name:'古城'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t3._id =Laniakea.Collection.AddressChina.insert(p6c2c0t3)

  p6c2c0t4 =
    name:'上桥'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t4._id =Laniakea.Collection.AddressChina.insert(p6c2c0t4)

  p6c2c0t5 =
    name:'金积'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t5._id =Laniakea.Collection.AddressChina.insert(p6c2c0t5)

  p6c2c0t6 =
    name:'高闸'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t6._id =Laniakea.Collection.AddressChina.insert(p6c2c0t6)

  p6c2c0t7 =
    name:'金星'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t7._id =Laniakea.Collection.AddressChina.insert(p6c2c0t7)

  p6c2c0t8 =
    name:'马莲渠'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t8._id =Laniakea.Collection.AddressChina.insert(p6c2c0t8)

  p6c2c0t9 =
    name:'东塔寺'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t9._id =Laniakea.Collection.AddressChina.insert(p6c2c0t9)

  p6c2c0t10 =
    name:'郭家桥'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t10._id =Laniakea.Collection.AddressChina.insert(p6c2c0t10)

  p6c2c0t11 =
    name:'板桥'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t11._id =Laniakea.Collection.AddressChina.insert(p6c2c0t11)

  p6c2c0t12 =
    name:'孙家滩'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t12._id =Laniakea.Collection.AddressChina.insert(p6c2c0t12)

  p6c2c0t13 =
    name:'太阳山'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t13._id =Laniakea.Collection.AddressChina.insert(p6c2c0t13)

  p6c2c0t14 =
    name:'巴浪湖'
  #    sn:''
    code:''
    level:3
    parent:p6c2c0._id
    children:[]
  p6c2c0t14._id =Laniakea.Collection.AddressChina.insert(p6c2c0t14)

  children_lt=[{'_id':p6c2c0t0._id,'name':p6c2c0t0.name},{'_id':p6c2c0t1._id,'name':p6c2c0t1.name},
    {'_id':p6c2c0t2._id,'name':p6c2c0t2.name},{'_id':p6c2c0t3._id,'name':p6c2c0t3.name},
    {'_id':p6c2c0t4._id,'name':p6c2c0t4.name},{'_id':p6c2c0t5._id,'name':p6c2c0t5.name},
    {'_id':p6c2c0t6._id,'name':p6c2c0t6.name},{'_id':p6c2c0t7._id,'name':p6c2c0t7.name},
    {'_id':p6c2c0t8._id,'name':p6c2c0t8.name},{'_id':p6c2c0t9._id,'name':p6c2c0t9.name},
    {'_id':p6c2c0t10._id,'name':p6c2c0t10.name},{'_id':p6c2c0t11._id,'name':p6c2c0t11.name}
    {'_id':p6c2c0t12._id,'name':p6c2c0t12.name},{'_id':p6c2c0t13._id,'name':p6c2c0t13.name},
    {'_id':p6c2c0t14._id,'name':p6c2c0t14.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c2c0._id},{$set:{'children':children_lt}})


  #  ==========红寺堡=============================================================================================================
  p6c2c1 =
    name:'红寺堡'
  #    sn:''
    code:''
    level:2
    parent:p6c2._id
    children:[]
  p6c2c1._id =Laniakea.Collection.AddressChina.insert(p6c2c1)

  p6c2c1t0 =
    name:'红寺堡'
  #    sn:''
    code:''
    level:3
    parent:p6c2c1._id
    children:[]
  p6c2c1t0._id =Laniakea.Collection.AddressChina.insert(p6c2c1t0)

  p6c2c1t1 =
    name:'太阳山'
  #    sn:''
    code:''
    level:3
    parent:p6c2c1._id
    children:[]
  p6c2c1t1._id =Laniakea.Collection.AddressChina.insert(p6c2c1t1)

  p6c2c1t2 =
    name:'大河'
  #    sn:''
    code:''
    level:3
    parent:p6c2c1._id
    children:[]
  p6c2c1t2._id =Laniakea.Collection.AddressChina.insert(p6c2c1t2)

  p6c2c1t3 =
    name:'南川'
  #    sn:''
    code:''
    level:3
    parent:p6c2c1._id
    children:[]
  p6c2c1t3._id =Laniakea.Collection.AddressChina.insert(p6c2c1t3)

  p6c2c1t4 =
    name:'工业园区'
  #    sn:''
    code:''
    level:3
    parent:p6c2c1._id
    children:[]
  p6c2c1t4._id =Laniakea.Collection.AddressChina.insert(p6c2c1t4)

  children_hsb=[{'_id':p6c2c1t0._id,'name':p6c2c1t0.name},{'_id':p6c2c1t1._id,'name':p6c2c1t1.name},
    {'_id':p6c2c1t2._id,'name':p6c2c1t2.name},{'_id':p6c2c1t3._id,'name':p6c2c1t3.name},
    {'_id':p6c2c1t4._id,'name':p6c2c1t4.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c2c1._id},{$set:{'children':children_hsb}})


  #  ==========盐池============================================================================================================
  p6c2c2 =
    name:'盐池'
  #    sn:''
    code:''
    level:2
    parent:p6c2._id
    children:[]
  p6c2c2._id =Laniakea.Collection.AddressChina.insert(p6c2c2)

  p6c2c2t0 =
    name:'花马池'
  #    sn:''
    code:''
    level:3
    parent:p6c2c2._id
    children:[]
  p6c2c2t0._id =Laniakea.Collection.AddressChina.insert(p6c2c2t0)

  p6c2c2t1 =
    name:'大水坑'
  #    sn:''
    code:''
    level:3
    parent:p6c2c2._id
    children:[]
  p6c2c2t1._id =Laniakea.Collection.AddressChina.insert(p6c2c2t1)

  p6c2c2t2 =
    name:'惠安堡'
  #    sn:''
    code:''
    level:3
    parent:p6c2c2._id
    children:[]
  p6c2c2t2._id =Laniakea.Collection.AddressChina.insert(p6c2c2t2)

  p6c2c2t3 =
    name:'高沙窝'
  #    sn:''
    code:''
    level:3
    parent:p6c2c2._id
    children:[]
  p6c2c2t3._id =Laniakea.Collection.AddressChina.insert(p6c2c2t3)

  p6c2c2t4 =
    name:'王乐井'
  #    sn:''
    code:''
    level:3
    parent:p6c2c2._id
    children:[]
  p6c2c2t4._id =Laniakea.Collection.AddressChina.insert(p6c2c2t4)

  p6c2c2t5 =
    name:'冯记沟'
  #    sn:''
    code:''
    level:3
    parent:p6c2c2._id
    children:[]
  p6c2c2t5._id =Laniakea.Collection.AddressChina.insert(p6c2c2t5)

  p6c2c2t6 =
    name:'麻黄山'
  #    sn:''
    code:''
    level:3
    parent:p6c2c2._id
    children:[]
  p6c2c2t6._id =Laniakea.Collection.AddressChina.insert(p6c2c2t6)

  p6c2c2t7 =
    name:'青山'
  #    sn:''
    code:''
    level:3
    parent:p6c2c2._id
    children:[]
  p6c2c2t7._id =Laniakea.Collection.AddressChina.insert(p6c2c2t7)

  children_ycx=[{'_id':p6c2c2t0._id,'name':p6c2c2t0.name},{'_id':p6c2c2t1._id,'name':p6c2c2t1.name},
    {'_id':p6c2c2t2._id,'name':p6c2c2t2.name},{'_id':p6c2c2t3._id,'name':p6c2c2t3.name},
    {'_id':p6c2c2t4._id,'name':p6c2c2t4.name},{'_id':p6c2c2t5._id,'name':p6c2c2t5.name},
    {'_id':p6c2c2t6._id,'name':p6c2c2t6.name},{'_id':p6c2c2t7._id,'name':p6c2c2t7.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c2c2._id},{$set:{'children':children_ycx}})


  #  ==========同心============================================================================================================
  p6c2c3 =
    name:'同心'
  #    sn:''
    code:''
    level:2
    parent:p6c2._id
    children:[]
  p6c2c3._id =Laniakea.Collection.AddressChina.insert(p6c2c3)

  p6c2c3t0 =
    name:'下马关'
  #    sn:''
    code:''
    level:3
    parent:p6c2c3._id
    children:[]
  p6c2c3t0._id =Laniakea.Collection.AddressChina.insert(p6c2c3t0)

  p6c2c3t1 =
    name:'河西'
  #    sn:''
    code:''
    level:3
    parent:p6c2c3._id
    children:[]
  p6c2c3t1._id =Laniakea.Collection.AddressChina.insert(p6c2c3t1)

  p6c2c3t2 =
    name:'豫海'
  #    sn:''
    code:''
    level:3
    parent:p6c2c3._id
    children:[]
  p6c2c3t2._id =Laniakea.Collection.AddressChina.insert(p6c2c3t2)

  p6c2c3t3 =
    name:'韦州'
  #    sn:''
    code:''
    level:3
    parent:p6c2c3._id
    children:[]
  p6c2c3t3._id =Laniakea.Collection.AddressChina.insert(p6c2c3t3)

  p6c2c3t4 =
    name:'预旺'
  #    sn:''
    code:''
    level:3
    parent:p6c2c3._id
    children:[]
  p6c2c3t4._id =Laniakea.Collection.AddressChina.insert(p6c2c3t4)

  p6c2c3t5 =
    name:'王团'
  #    sn:''
    code:''
    level:3
    parent:p6c2c3._id
    children:[]
  p6c2c3t5._id =Laniakea.Collection.AddressChina.insert(p6c2c3t5)

  p6c2c3t6 =
    name:'丁塘'
  #    sn:''
    code:''
    level:3
    parent:p6c2c3._id
    children:[]
  p6c2c3t6._id =Laniakea.Collection.AddressChina.insert(p6c2c3t6)

  p6c2c3t7 =
    name:'田老庄'
  #    sn:''
    code:''
    level:3
    parent:p6c2c3._id
    children:[]
  p6c2c3t7._id =Laniakea.Collection.AddressChina.insert(p6c2c3t7)

  p6c2c3t8 =
    name:'马高庄'
  #    sn:''
    code:''
    level:3
    parent:p6c2c3._id
    children:[]
  p6c2c3t8._id =Laniakea.Collection.AddressChina.insert(p6c2c3t8)

  p6c2c3t9 =
    name:'张家塬'
  #    sn:''
    code:''
    level:3
    parent:p6c2c3._id
    children:[]
  p6c2c3t9._id =Laniakea.Collection.AddressChina.insert(p6c2c3t9)

  p6c2c3t10 =
    name:'兴隆'
  #    sn:''
    code:''
    level:3
    parent:p6c2c3._id
    children:[]
  p6c2c3t10._id =Laniakea.Collection.AddressChina.insert(p6c2c3t10)

  p6c2c3t11 =
    name:'石狮开发区'
  #    sn:''
    code:''
    level:3
    parent:p6c2c3._id
    children:[]
  p6c2c3t11._id =Laniakea.Collection.AddressChina.insert(p6c2c3t11)

  p6c2c3t12 =
    name:'窑山'
  #    sn:''
    code:''
    level:3
    parent:p6c2c3._id
    children:[]
  p6c2c3t12._id =Laniakea.Collection.AddressChina.insert(p6c2c3t12)

  children_tx=[{'_id':p6c2c3t0._id,'name':p6c2c3t0.name},{'_id':p6c2c3t1._id,'name':p6c2c3t1.name},
    {'_id':p6c2c3t2._id,'name':p6c2c3t2.name},{'_id':p6c2c3t3._id,'name':p6c2c3t3.name},
    {'_id':p6c2c3t4._id,'name':p6c2c3t4.name},{'_id':p6c2c3t5._id,'name':p6c2c3t5.name},
    {'_id':p6c2c3t6._id,'name':p6c2c3t6.name},{'_id':p6c2c3t7._id,'name':p6c2c3t7.name},
    {'_id':p6c2c3t8._id,'name':p6c2c3t8.name},{'_id':p6c2c3t9._id,'name':p6c2c3t9.name},
    {'_id':p6c2c3t10._id,'name':p6c2c3t10.name},{'_id':p6c2c3t11._id,'name':p6c2c3t11.name}
    {'_id':p6c2c3t12._id,'name':p6c2c3t12.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c2c3._id},{$set:{'children':children_tx}})


  #  ==========青铜峡=============================================================================================================
  p6c2c4 =
    name:'青铜峡'
  #    sn:''
    code:''
    level:2
    parent:p6c2._id
    children:[]
  p6c2c4._id =Laniakea.Collection.AddressChina.insert(p6c2c4)

  p6c2c4t0 =
    name:'裕民'
  #    sn:''
    code:''
    level:3
    parent:p6c2c4._id
    children:[]
  p6c2c4t0._id =Laniakea.Collection.AddressChina.insert(p6c2c4t0)

  p6c2c4t1 =
    name:'青铜峡'
  #    sn:''
    code:''
    level:3
    parent:p6c2c4._id
    children:[]
  p6c2c4t1._id =Laniakea.Collection.AddressChina.insert(p6c2c4t1)

  p6c2c4t2 =
    name:'陈袁滩'
  #    sn:''
    code:''
    level:3
    parent:p6c2c4._id
    children:[]
  p6c2c4t2._id =Laniakea.Collection.AddressChina.insert(p6c2c4t2)

  p6c2c4t3 =
    name:'小坝'
  #    sn:''
    code:''
    level:3
    parent:p6c2c4._id
    children:[]
  p6c2c4t3._id =Laniakea.Collection.AddressChina.insert(p6c2c4t3)

  p6c2c4t4 =
    name:'大坝'
  #    sn:''
    code:''
    level:3
    parent:p6c2c4._id
    children:[]
  p6c2c4t4._id =Laniakea.Collection.AddressChina.insert(p6c2c4t4)

  p6c2c4t5 =
    name:'叶盛'
  #    sn:''
    code:''
    level:3
    parent:p6c2c4._id
    children:[]
  p6c2c4t5._id =Laniakea.Collection.AddressChina.insert(p6c2c4t5)

  p6c2c4t6 =
    name:'瞿靖'
  #    sn:''
    code:''
    level:3
    parent:p6c2c4._id
    children:[]
  p6c2c4t6._id =Laniakea.Collection.AddressChina.insert(p6c2c4t6)

  p6c2c4t7 =
    name:'峡口'
  #    sn:''
    code:''
    level:3
    parent:p6c2c4._id
    children:[]
  p6c2c4t7._id =Laniakea.Collection.AddressChina.insert(p6c2c4t7)

  p6c2c4t8 =
    name:'邵刚'
  #    sn:''
    code:''
    level:3
    parent:p6c2c4._id
    children:[]
  p6c2c4t8._id =Laniakea.Collection.AddressChina.insert(p6c2c4t8)

  p6c2c4t9 =
    name:'连湖'
  #    sn:''
    code:''
    level:3
    parent:p6c2c4._id
    children:[]
  p6c2c4t9._id =Laniakea.Collection.AddressChina.insert(p6c2c4t9)

  p6c2c4t10 =
    name:'树新'
  #    sn:''
    code:''
    level:3
    parent:p6c2c4._id
    children:[]
  p6c2c4t10._id =Laniakea.Collection.AddressChina.insert(p6c2c4t10)

  children_qtx=[{'_id':p6c2c4t0._id,'name':p6c2c4t0.name},{'_id':p6c2c4t1._id,'name':p6c2c4t1.name},
    {'_id':p6c2c4t2._id,'name':p6c2c4t2.name},{'_id':p6c2c4t3._id,'name':p6c2c4t3.name},
    {'_id':p6c2c4t4._id,'name':p6c2c4t4.name},{'_id':p6c2c4t5._id,'name':p6c2c4t5.name},
    {'_id':p6c2c4t6._id,'name':p6c2c4t6.name},{'_id':p6c2c4t7._id,'name':p6c2c4t7.name},
    {'_id':p6c2c4t8._id,'name':p6c2c4t8.name},{'_id':p6c2c4t9._id,'name':p6c2c4t9.name},
    {'_id':p6c2c4t10._id,'name':p6c2c4t10.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c2c4._id},{$set:{'children':children_qtx}})



  children_wz=[{'_id':p6c2c0._id,'name':p6c2c0.name},{'_id':p6c2c1._id,'name':p6c2c1.name},
    {'_id':p6c2c2._id,'name':p6c2c2.name},{'_id':p6c2c3._id,'name':p6c2c3.name},
    {'_id':p6c2c4._id,'name':p6c2c4.name}]
  Laniakea.Collection.AddressChina.update({_id:p6c2._id},{$set:{'children':children_wz}})



##############################    p6c3   -----------------------------------------------------------------------------------------------------------------
  p6c3 =
    name:'固原'
    sn:'固原'
    code:''
    level:1
    parent:p6._id
    children:[]
  p6c3._id =Laniakea.Collection.AddressChina.insert(p6c3)

#  ==========原州=============================================================================================================
  p6c3c0 =
    name:'原州'
#    sn:''
    code:''
    level:2
    parent:p6c3._id
    children:[]
  p6c3c0._id =Laniakea.Collection.AddressChina.insert(p6c3c0)

  p6c3c0t0 =
    name:'城区'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t0._id =Laniakea.Collection.AddressChina.insert(p6c3c0t0)

  p6c3c0t1 =
    name:'南关'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t1._id =Laniakea.Collection.AddressChina.insert(p6c3c0t1)

  p6c3c0t2 =
    name:'新区'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t2._id =Laniakea.Collection.AddressChina.insert(p6c3c0t2)

  p6c3c0t3 =
    name:'北塬'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t3._id =Laniakea.Collection.AddressChina.insert(p6c3c0t3)

  p6c3c0t4 =
    name:'黄铎堡'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t4._id =Laniakea.Collection.AddressChina.insert(p6c3c0t4)

  p6c3c0t5 =
    name:'官厅'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t5._id =Laniakea.Collection.AddressChina.insert(p6c3c0t5)

  p6c3c0t6 =
    name:'三营'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t6._id =Laniakea.Collection.AddressChina.insert(p6c3c0t6)

  p6c3c0t7 =
    name:'开城'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t7._id =Laniakea.Collection.AddressChina.insert(p6c3c0t7)

  p6c3c0t8 =
    name:'张易'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t8._id =Laniakea.Collection.AddressChina.insert(p6c3c0t8)

  p6c3c0t9 =
    name:'彭堡'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t9._id =Laniakea.Collection.AddressChina.insert(p6c3c0t9)

  p6c3c0t10 =
    name:'头营'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t10._id =Laniakea.Collection.AddressChina.insert(p6c3c0t10)

  p6c3c0t11 =
    name:'中河'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t11._id =Laniakea.Collection.AddressChina.insert(p6c3c0t11)

  p6c3c0t12 =
    name:'河川'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t12._id =Laniakea.Collection.AddressChina.insert(p6c3c0t12)

  p6c3c0t13 =
    name:'炭山'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t13._id =Laniakea.Collection.AddressChina.insert(p6c3c0t13)

  p6c3c0t14 =
    name:'寨科'
  #    sn:''
    code:''
    level:3
    parent:p6c3c0._id
    children:[]
  p6c3c0t14._id =Laniakea.Collection.AddressChina.insert(p6c3c0t14)


  #  children_lc=[p6c3c0t0._id,p6c3c0t1._id,p6c3c0t2._id,p6c3c0t3._id,p6c3c0t4._id,p6c3c0t5._id,
  #               p6c3c0t6._id,p6c3c0t7._id,p6c3c0t8._id,p6c3c0t9._id,p6c3c0t10._id,p6c3c0t11._id,
  #               p6c3c0t12._id,p6c3c0t13._id,p6c3c0t14._id]
  children_yz=[{'_id':p6c3c0t0._id,'name':p6c3c0t0.name},{'_id':p6c3c0t1._id,'name':p6c3c0t1.name},
    {'_id':p6c3c0t2._id,'name':p6c3c0t2.name},{'_id':p6c3c0t3._id,'name':p6c3c0t3.name},
    {'_id':p6c3c0t4._id,'name':p6c3c0t4.name},{'_id':p6c3c0t5._id,'name':p6c3c0t5.name},
    {'_id':p6c3c0t6._id,'name':p6c3c0t6.name},{'_id':p6c3c0t7._id,'name':p6c3c0t7.name},
    {'_id':p6c3c0t8._id,'name':p6c3c0t8.name},{'_id':p6c3c0t9._id,'name':p6c3c0t9.name},
    {'_id':p6c3c0t10._id,'name':p6c3c0t10.name},{'_id':p6c3c0t11._id,'name':p6c3c0t11.name},
    {'_id':p6c3c0t12._id,'name':p6c3c0t12.name},{'_id':p6c3c0t13._id,'name':p6c3c0t13.name},
    {'_id':p6c3c0t14._id,'name':p6c3c0t14.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c3c0._id},{$set:{'children':children_yz}})

#  ==========西吉=============================================================================================================
  p6c3c1 =
    name:'西吉'
  #    sn:''
    code:''
    level:2
    parent:p6c3._id
    children:[]
  p6c3c1._id =Laniakea.Collection.AddressChina.insert(p6c3c1)

  p6c3c1t0 =
    name:'吉强'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t0._id =Laniakea.Collection.AddressChina.insert(p6c3c1t0)

  p6c3c1t1 =
    name:'平峰'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t1._id =Laniakea.Collection.AddressChina.insert(p6c3c1t1)

  p6c3c1t2 =
    name:'兴隆'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t2._id =Laniakea.Collection.AddressChina.insert(p6c3c1t2)

  p6c3c1t3 =
    name:'火石寨'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t3._id =Laniakea.Collection.AddressChina.insert(p6c3c1t3)

  p6c3c1t4 =
    name:'沙沟'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t4._id =Laniakea.Collection.AddressChina.insert(p6c3c1t4)

  p6c3c1t5 =
    name:'新营'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t5._id =Laniakea.Collection.AddressChina.insert(p6c3c1t5)

  p6c3c1t6 =
    name:'红耀'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t6._id =Laniakea.Collection.AddressChina.insert(p6c3c1t6)

  p6c3c1t7 =
    name:'田坪'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t7._id =Laniakea.Collection.AddressChina.insert(p6c3c1t7)

  p6c3c1t8 =
    name:'马建'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t8._id =Laniakea.Collection.AddressChina.insert(p6c3c1t8)

  p6c3c1t9 =
    name:'震湖'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t9._id =Laniakea.Collection.AddressChina.insert(p6c3c1t9)

  p6c3c1t10 =
    name:'兴平'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t10._id =Laniakea.Collection.AddressChina.insert(p6c3c1t10)

  p6c3c1t11 =
    name:'西滩'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t11._id =Laniakea.Collection.AddressChina.insert(p6c3c1t11)

  p6c3c1t12 =
    name:'王民'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t12._id =Laniakea.Collection.AddressChina.insert(p6c3c1t12)

  p6c3c1t13 =
    name:'什字'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t13._id =Laniakea.Collection.AddressChina.insert(p6c3c1t13)

  p6c3c1t14 =
    name:'马莲'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t14._id =Laniakea.Collection.AddressChina.insert(p6c3c1t14)

  p6c3c1t15 =
    name:'将台'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t15._id =Laniakea.Collection.AddressChina.insert(p6c3c1t15)

  p6c3c1t16 =
    name:'硝河'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t16._id =Laniakea.Collection.AddressChina.insert(p6c3c1t16)

  p6c3c1t17 =
    name:'偏城'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t17._id =Laniakea.Collection.AddressChina.insert(p6c3c1t17)

  p6c3c1t18 =
    name:'白崖'
  #    sn:''
    code:''
    level:3
    parent:p6c3c1._id
    children:[]
  p6c3c1t18._id =Laniakea.Collection.AddressChina.insert(p6c3c1t18)

  #  children_lc=[p6c3c1t0._id,p6c3c1t1._id,p6c3c1t2._id,p6c3c1t3._id,p6c3c1t4._id,p6c3c1t5._id,
  #               p6c3c1t6._id,p6c3c1t7._id,p6c3c1t8._id,p6c3c1t9._id,p6c3c1t10._id,p6c3c1t11._id,
  #               p6c3c1t12._id,p6c3c1t13._id,p6c3c1t14._id,p6c3c1t15._id,p6c3c1t16._id,
  #               p6c3c1t17._id,p6c3c1t18._id]
  children_xj=[{'_id':p6c3c1t0._id,'name':p6c3c1t0.name},{'_id':p6c3c1t1._id,'name':p6c3c1t1.name},
    {'_id':p6c3c1t2._id,'name':p6c3c1t2.name},{'_id':p6c3c1t3._id,'name':p6c3c1t3.name},
    {'_id':p6c3c1t4._id,'name':p6c3c1t4.name},{'_id':p6c3c1t5._id,'name':p6c3c1t5.name},
    {'_id':p6c3c1t6._id,'name':p6c3c1t6.name},{'_id':p6c3c1t7._id,'name':p6c3c1t7.name},
    {'_id':p6c3c1t8._id,'name':p6c3c1t8.name},{'_id':p6c3c1t9._id,'name':p6c3c1t9.name},
    {'_id':p6c3c1t10._id,'name':p6c3c1t10.name},{'_id':p6c3c1t11._id,'name':p6c3c1t11.name},
    {'_id':p6c3c1t12._id,'name':p6c3c1t12.name},{'_id':p6c3c1t13._id,'name':p6c3c1t13.name},
    {'_id':p6c3c1t14._id,'name':p6c3c1t14.name},{'_id':p6c3c1t15._id,'name':p6c3c1t15.name},
    {'_id':p6c3c1t16._id,'name':p6c3c1t16.name},{'_id':p6c3c1t17._id,'name':p6c3c1t17.name},
    {'_id':p6c3c1t18._id,'name':p6c3c1t18.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c3c1._id},{$set:{'children':children_xj}})


  #  ==========隆德=============================================================================================================
  p6c3c2 =
    name:'隆德'
  #    sn:''
    code:''
    level:2
    parent:p6c3._id
    children:[]
  p6c3c2._id =Laniakea.Collection.AddressChina.insert(p6c3c2)

  p6c3c2t0 =
    name:'六盘山'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t0._id =Laniakea.Collection.AddressChina.insert(p6c3c2t0)

  p6c3c2t1 =
    name:'城关'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t1._id =Laniakea.Collection.AddressChina.insert(p6c3c2t1)

  p6c3c2t2 =
    name:'沙塘'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t2._id =Laniakea.Collection.AddressChina.insert(p6c3c2t2)

  p6c3c2t3 =
    name:'联财'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t3._id =Laniakea.Collection.AddressChina.insert(p6c3c2t3)

  p6c3c2t4 =
    name:'观庄'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t4._id =Laniakea.Collection.AddressChina.insert(p6c3c2t4)

  p6c3c2t5 =
    name:'山河'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t5._id =Laniakea.Collection.AddressChina.insert(p6c3c2t5)

  p6c3c2t6 =
    name:'凤岭'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t6._id =Laniakea.Collection.AddressChina.insert(p6c3c2t6)

  p6c3c2t7 =
    name:'杨河'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t7._id =Laniakea.Collection.AddressChina.insert(p6c3c2t7)

  p6c3c2t8 =
    name:'好水'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t8._id =Laniakea.Collection.AddressChina.insert(p6c3c2t8)

  p6c3c2t9 =
    name:'陈靳'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t9._id =Laniakea.Collection.AddressChina.insert(p6c3c2t9)

  p6c3c2t10 =
    name:'神林'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t10._id =Laniakea.Collection.AddressChina.insert(p6c3c2t10)

  p6c3c2t11 =
    name:'张程'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t11._id =Laniakea.Collection.AddressChina.insert(p6c3c2t11)

  p6c3c2t12 =
    name:'温堡'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t12._id =Laniakea.Collection.AddressChina.insert(p6c3c2t12)

  p6c3c2t13 =
    name:'奠安'
  #    sn:''
    code:''
    level:3
    parent:p6c3c2._id
    children:[]
  p6c3c2t13._id =Laniakea.Collection.AddressChina.insert(p6c3c2t13)

  #  children_lc=[p6c3c2t0._id,p6c3c2t1._id,p6c3c2t2._id,p6c3c2t3._id,p6c3c2t4._id,p6c3c2t5._id,
  #               p6c3c2t6._id,p6c3c2t7._id,p6c3c2t8._id,p6c3c2t9._id,p6c3c2t10._id,p6c3c2t11._id,
  #               p6c3c2t12._id,p6c3c2t13._id]
  children_ld=[{'_id':p6c3c2t0._id,'name':p6c3c2t0.name},{'_id':p6c3c2t1._id,'name':p6c3c2t1.name},
    {'_id':p6c3c2t2._id,'name':p6c3c2t2.name},{'_id':p6c3c2t3._id,'name':p6c3c2t3.name},
    {'_id':p6c3c2t4._id,'name':p6c3c2t4.name},{'_id':p6c3c2t5._id,'name':p6c3c2t5.name},
    {'_id':p6c3c2t6._id,'name':p6c3c2t6.name},{'_id':p6c3c2t7._id,'name':p6c3c2t7.name},
    {'_id':p6c3c2t8._id,'name':p6c3c2t8.name},{'_id':p6c3c2t9._id,'name':p6c3c2t9.name},
    {'_id':p6c3c2t10._id,'name':p6c3c2t10.name},{'_id':p6c3c2t11._id,'name':p6c3c2t11.name},
    {'_id':p6c3c2t12._id,'name':p6c3c2t12.name},{'_id':p6c3c2t13._id,'name':p6c3c2t13.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c3c2._id},{$set:{'children':children_ld}})


#  ==========泾源=============================================================================================================
  p6c3c3 =
    name:'泾源'
  #    sn:''
    code:''
    level:2
    parent:p6c3._id
    children:[]
  p6c3c3._id =Laniakea.Collection.AddressChina.insert(p6c3c3)

  p6c3c3t0 =
    name:'泾河源'
  #    sn:''
    code:''
    level:3
    parent:p6c3c3._id
    children:[]
  p6c3c3t0._id =Laniakea.Collection.AddressChina.insert(p6c3c3t0)

  p6c3c3t1 =
    name:'六盘山'
  #    sn:''
    code:''
    level:3
    parent:p6c3c3._id
    children:[]
  p6c3c3t1._id =Laniakea.Collection.AddressChina.insert(p6c3c3t1)

  p6c3c3t2 =
    name:'香水'
  #    sn:''
    code:''
    level:3
    parent:p6c3c3._id
    children:[]
  p6c3c3t2._id =Laniakea.Collection.AddressChina.insert(p6c3c3t2)

  p6c3c3t3 =
    name:'新民'
  #    sn:''
    code:''
    level:3
    parent:p6c3c3._id
    children:[]
  p6c3c3t3._id =Laniakea.Collection.AddressChina.insert(p6c3c3t3)

  p6c3c3t4 =
    name:'兴盛'
  #    sn:''
    code:''
    level:3
    parent:p6c3c3._id
    children:[]
  p6c3c3t4._id =Laniakea.Collection.AddressChina.insert(p6c3c3t4)

  p6c3c3t5 =
    name:'黄花'
  #    sn:''
    code:''
    level:3
    parent:p6c3c3._id
    children:[]
  p6c3c3t5._id =Laniakea.Collection.AddressChina.insert(p6c3c3t5)

  p6c3c3t6 =
    name:'大湾'
  #    sn:''
    code:''
    level:3
    parent:p6c3c3._id
    children:[]
  p6c3c3t6._id =Laniakea.Collection.AddressChina.insert(p6c3c3t6)

  #  children_lc=[p6c3c3t0._id,p6c3c3t1._id,p6c3c3t2._id,p6c3c3t3._id,p6c3c3t4._id,p6c3c3t5._id,
  #               p6c3c3t6._id]
  children_jy=[{'_id':p6c3c3t0._id,'name':p6c3c3t0.name},{'_id':p6c3c3t1._id,'name':p6c3c3t1.name},
    {'_id':p6c3c3t2._id,'name':p6c3c3t2.name},{'_id':p6c3c3t3._id,'name':p6c3c3t3.name},
    {'_id':p6c3c3t4._id,'name':p6c3c3t4.name},{'_id':p6c3c3t5._id,'name':p6c3c3t5.name},
    {'_id':p6c3c3t6._id,'name':p6c3c3t6.name}]
  Laniakea.Collection.AddressChina.update({_id:p6c3c3._id},{$set:{'children':children_jy}})


  #  ==========彭阳=============================================================================================================
  p6c3c4 =
    name:'彭阳'
  #    sn:''
    code:''
    level:2
    parent:p6c3._id
    children:[]
  p6c3c4._id =Laniakea.Collection.AddressChina.insert(p6c3c4)


  p6c3c4t0 =
    name:'古城'
  #    sn:''
    code:''
    level:3
    parent:p6c3c4._id
    children:[]
  p6c3c4t0._id =Laniakea.Collection.AddressChina.insert(p6c3c4t0)

  p6c3c4t1 =
    name:'白阳'
  #    sn:''
    code:''
    level:3
    parent:p6c3c4._id
    children:[]
  p6c3c4t1._id =Laniakea.Collection.AddressChina.insert(p6c3c4t1)

  p6c3c4t2 =
    name:'王洼'
  #    sn:''
    code:''
    level:3
    parent:p6c3c4._id
    children:[]
  p6c3c4t2._id =Laniakea.Collection.AddressChina.insert(p6c3c4t2)

  p6c3c4t3 =
    name:'新集'
  #    sn:''
    code:''
    level:3
    parent:p6c3c4._id
    children:[]
  p6c3c4t3._id =Laniakea.Collection.AddressChina.insert(p6c3c4t3)

  p6c3c4t4 =
    name:'城阳'
  #    sn:''
    code:''
    level:3
    parent:p6c3c4._id
    children:[]
  p6c3c4t4._id =Laniakea.Collection.AddressChina.insert(p6c3c4t4)

  p6c3c4t5 =
    name:'红河'
  #    sn:''
    code:''
    level:3
    parent:p6c3c4._id
    children:[]
  p6c3c4t5._id =Laniakea.Collection.AddressChina.insert(p6c3c4t5)

  p6c3c4t6 =
    name:'冯庄'
  #    sn:''
    code:''
    level:3
    parent:p6c3c4._id
    children:[]
  p6c3c4t6._id =Laniakea.Collection.AddressChina.insert(p6c3c4t6)

  p6c3c4t7 =
    name:'小岔'
  #    sn:''
    code:''
    level:3
    parent:p6c3c4._id
    children:[]
  p6c3c4t7._id =Laniakea.Collection.AddressChina.insert(p6c3c4t7)

  p6c3c4t8 =
    name:'孟塬'
  #    sn:''
    code:''
    level:3
    parent:p6c3c4._id
    children:[]
  p6c3c4t8._id =Laniakea.Collection.AddressChina.insert(p6c3c4t8)

  p6c3c4t9 =
    name:'罗圭'
  #    sn:''
    code:''
    level:3
    parent:p6c3c4._id
    children:[]
  p6c3c4t9._id =Laniakea.Collection.AddressChina.insert(p6c3c4t9)

  p6c3c4t10 =
    name:'交岔'
  #    sn:''
    code:''
    level:3
    parent:p6c3c4._id
    children:[]
  p6c3c4t10._id =Laniakea.Collection.AddressChina.insert(p6c3c4t10)

  p6c3c4t11 =
    name:'草庙'
  #    sn:''
    code:''
    level:3
    parent:p6c3c4._id
    children:[]
  p6c3c4t11._id =Laniakea.Collection.AddressChina.insert(p6c3c4t11)

  #  children_lc=[p6c3c4t0._id,p6c3c4t1._id,p6c3c4t2._id,p6c3c4t3._id,p6c3c4t4._id,p6c3c4t5._id,
  #               p6c3c4t6._id,p6c3c4t7._id,p6c3c4t8._id,p6c3c4t9._id,p6c3c4t10._id,p6c3c4t11._id]
  children_py=[{'_id':p6c3c4t0._id,'name':p6c3c4t0.name},{'_id':p6c3c4t1._id,'name':p6c3c4t1.name},
    {'_id':p6c3c4t2._id,'name':p6c3c4t2.name},{'_id':p6c3c4t3._id,'name':p6c3c4t3.name},
    {'_id':p6c3c4t4._id,'name':p6c3c4t4.name},{'_id':p6c3c4t5._id,'name':p6c3c4t5.name},
    {'_id':p6c3c4t6._id,'name':p6c3c4t6.name},{'_id':p6c3c4t7._id,'name':p6c3c4t7.name},
    {'_id':p6c3c4t8._id,'name':p6c3c4t8.name},{'_id':p6c3c4t9._id,'name':p6c3c4t9.name},
    {'_id':p6c3c4t10._id,'name':p6c3c4t10.name},{'_id':p6c3c4t11._id,'name':p6c3c4t11.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c3c4._id},{$set:{'children':children_py}})
  #  children_cz=[p6c3c0._id,p6c3c1._id,p6c3c2._id,p6c3c3._id,p6c3c4._id]
  children_gy=[{'_id':p6c3c0._id,'name':p6c3c0.name},{'_id':p6c3c1._id,'name':p6c3c1.name},
    {'_id':p6c3c2._id,'name':p6c3c2.name},{'_id':p6c3c3._id,'name':p6c3c3.name},
    {'_id':p6c3c4._id,'name':p6c3c4.name}]
  Laniakea.Collection.AddressChina.update({_id:p6c3._id},{$set:{'children':children_gy}})

##############################    p6c3 end  -----


##############################    p6c4   ---------------------------------------------------------------------------------------------------------------
  p6c4 =
    name:'中卫'
    sn:'中卫'
    code:''
    level:1
    parent:p6._id
    children:[]
  p6c4._id =Laniakea.Collection.AddressChina.insert(p6c4)

  #  ==========沙坡头=============================================================================================================
  p6c4c0 =
    name:'沙坡头'
#    sn:''
    code:''
    level:2
    parent:p6c4._id
    children:[]
  p6c4c0._id =Laniakea.Collection.AddressChina.insert(p6c4c0)

  p6c4c0t0 =
    name:'蒿川'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t0._id =Laniakea.Collection.AddressChina.insert(p6c4c0t0)

  p6c4c0t1 =
    name:'美利工业园'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t1._id =Laniakea.Collection.AddressChina.insert(p6c4c0t1)

  p6c4c0t2 =
    name:'山羊选育场'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t2._id =Laniakea.Collection.AddressChina.insert(p6c4c0t2)

  p6c4c0t3 =
    name:'迎水桥'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t3._id =Laniakea.Collection.AddressChina.insert(p6c4c0t3)

  p6c4c0t4 =
    name:'常乐'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t4._id =Laniakea.Collection.AddressChina.insert(p6c4c0t4)

  p6c4c0t5 =
    name:'滨河'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t5._id =Laniakea.Collection.AddressChina.insert(p6c4c0t5)

  p6c4c0t6 =
    name:'文昌'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t6._id =Laniakea.Collection.AddressChina.insert(p6c4c0t6)

  p6c4c0t7 =
    name:'东园'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t7._id =Laniakea.Collection.AddressChina.insert(p6c4c0t7)

  p6c4c0t8 =
    name:'柔远'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t8._id =Laniakea.Collection.AddressChina.insert(p6c4c0t8)

  p6c4c0t9 =
    name:'镇罗'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t9._id =Laniakea.Collection.AddressChina.insert(p6c4c0t9)

  p6c4c0t10 =
    name:'宣和'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t10._id =Laniakea.Collection.AddressChina.insert(p6c4c0t10)

  p6c4c0t11 =
    name:'永康'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t11._id =Laniakea.Collection.AddressChina.insert(p6c4c0t11)

  p6c4c0t12 =
    name:'兴仁'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t12._id =Laniakea.Collection.AddressChina.insert(p6c4c0t12)

  p6c4c0t13 =
    name:'香山'
  #    sn:''
    code:''
    level:3
    parent:p6c4c0._id
    children:[]
  p6c4c0t13._id =Laniakea.Collection.AddressChina.insert(p6c4c0t13)


  children_spt=[{'_id':p6c4c0t0._id,'name':p6c4c0t0.name},{'_id':p6c4c0t1._id,'name':p6c4c0t1.name},
    {'_id':p6c4c0t2._id,'name':p6c4c0t2.name},{'_id':p6c4c0t3._id,'name':p6c4c0t3.name},
    {'_id':p6c4c0t4._id,'name':p6c4c0t4.name},{'_id':p6c4c0t5._id,'name':p6c4c0t5.name},
    {'_id':p6c4c0t6._id,'name':p6c4c0t6.name},{'_id':p6c4c0t7._id,'name':p6c4c0t7.name},
    {'_id':p6c4c0t8._id,'name':p6c4c0t8.name},{'_id':p6c4c0t9._id,'name':p6c4c0t9.name},
    {'_id':p6c4c0t10._id,'name':p6c4c0t10.name},{'_id':p6c4c0t11._id,'name':p6c4c0t11.name}
    {'_id':p6c4c0t12._id,'name':p6c4c0t12.name},{'_id':p6c4c0t13._id,'name':p6c4c0t13.name}]
  Laniakea.Collection.AddressChina.update({_id:p6c4c0._id},{$set:{'children':children_spt}})

  #  ==========中宁=============================================================================================================
  p6c4c1 =
    name:'中宁'
  #    sn:''
    code:''
    level:2
    parent:p6c4._id
    children:[]
  p6c4c1._id =Laniakea.Collection.AddressChina.insert(p6c4c1)


  p6c4c1t0 =
    name:'宁安'
  #    sn:''
    code:''
    level:3
    parent:p6c4c1._id
    children:[]
  p6c4c1t0._id =Laniakea.Collection.AddressChina.insert(p6c4c1t0)

  p6c4c1t1 =
    name:'鸣沙'
  #    sn:''
    code:''
    level:3
    parent:p6c4c1._id
    children:[]
  p6c4c1t1._id =Laniakea.Collection.AddressChina.insert(p6c4c1t1)

  p6c4c1t2 =
    name:'石空'
  #    sn:''
    code:''
    level:3
    parent:p6c4c1._id
    children:[]
  p6c4c1t2._id =Laniakea.Collection.AddressChina.insert(p6c4c1t2)

  p6c4c1t3 =
    name:'新堡'
  #    sn:''
    code:''
    level:3
    parent:p6c4c1._id
    children:[]
  p6c4c1t3._id =Laniakea.Collection.AddressChina.insert(p6c4c1t3)

  p6c4c1t4 =
    name:'恩和'
  #    sn:''
    code:''
    level:3
    parent:p6c4c1._id
    children:[]
  p6c4c1t4._id =Laniakea.Collection.AddressChina.insert(p6c4c1t4)

  p6c4c1t5 =
    name:'大战场'
  #    sn:''
    code:''
    level:3
    parent:p6c4c1._id
    children:[]
  p6c4c1t5._id =Laniakea.Collection.AddressChina.insert(p6c4c1t5)

  p6c4c1t6 =
    name:'喊叫水'
  #    sn:''
    code:''
    level:3
    parent:p6c4c1._id
    children:[]
  p6c4c1t6._id =Laniakea.Collection.AddressChina.insert(p6c4c1t6)

  p6c4c1t7 =
    name:'白马'
  #    sn:''
    code:''
    level:3
    parent:p6c4c1._id
    children:[]
  p6c4c1t7._id =Laniakea.Collection.AddressChina.insert(p6c4c1t7)

  p6c4c1t8 =
    name:'舟塔'
  #    sn:''
    code:''
    level:3
    parent:p6c4c1._id
    children:[]
  p6c4c1t8._id =Laniakea.Collection.AddressChina.insert(p6c4c1t8)

  p6c4c1t9 =
    name:'余丁'
  #    sn:''
    code:''
    level:3
    parent:p6c4c1._id
    children:[]
  p6c4c1t9._id =Laniakea.Collection.AddressChina.insert(p6c4c1t9)

  p6c4c1t10 =
    name:'长山头'
  #    sn:''
    code:''
    level:3
    parent:p6c4c1._id
    children:[]
  p6c4c1t10._id =Laniakea.Collection.AddressChina.insert(p6c4c1t10)

  p6c4c1t11 =
    name:'渠口'
  #    sn:''
    code:''
    level:3
    parent:p6c4c1._id
    children:[]
  p6c4c1t11._id =Laniakea.Collection.AddressChina.insert(p6c4c1t11)

  p6c4c1t12 =
    name:'县城'
  #    sn:''
    code:''
    level:3
    parent:p6c4c1._id
    children:[]
  p6c4c1t12._id =Laniakea.Collection.AddressChina.insert(p6c4c1t12)


  children_zn=[{'_id':p6c4c1t0._id,'name':p6c4c1t0.name},{'_id':p6c4c1t1._id,'name':p6c4c1t1.name},
    {'_id':p6c4c1t2._id,'name':p6c4c1t2.name},{'_id':p6c4c1t3._id,'name':p6c4c1t3.name},
    {'_id':p6c4c1t4._id,'name':p6c4c1t4.name},{'_id':p6c4c1t5._id,'name':p6c4c1t5.name},
    {'_id':p6c4c1t6._id,'name':p6c4c1t6.name},{'_id':p6c4c1t7._id,'name':p6c4c1t7.name},
    {'_id':p6c4c1t8._id,'name':p6c4c1t8.name},{'_id':p6c4c1t9._id,'name':p6c4c1t9.name},
    {'_id':p6c4c1t10._id,'name':p6c4c1t10.name},{'_id':p6c4c1t11._id,'name':p6c4c1t11.name}
    {'_id':p6c4c1t12._id,'name':p6c4c1t12.name}]
  Laniakea.Collection.AddressChina.update({_id:p6c4c1._id},{$set:{'children':children_zn}})


  #  ==========海原=============================================================================================================
  p6c4c2 =
    name:'海原'
  #    sn:''
    code:''
    level:2
    parent:p6c4._id
    children:[]
  p6c4c2._id =Laniakea.Collection.AddressChina.insert(p6c4c2)

  p6c4c2t0 =
    name:'海城'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t0._id =Laniakea.Collection.AddressChina.insert(p6c4c2t0)

  p6c4c2t1 =
    name:'李旺'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t1._id =Laniakea.Collection.AddressChina.insert(p6c4c2t1)

  p6c4c2t2 =
    name:'西安'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t2._id =Laniakea.Collection.AddressChina.insert(p6c4c2t2)

  p6c4c2t3 =
    name:'黑城'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t3._id =Laniakea.Collection.AddressChina.insert(p6c4c2t3)

  p6c4c2t4 =
    name:'七营'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t4._id =Laniakea.Collection.AddressChina.insert(p6c4c2t4)

  p6c4c2t5 =
    name:'史店'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t5._id =Laniakea.Collection.AddressChina.insert(p6c4c2t5)

  p6c4c2t6 =
    name:'树台'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t6._id =Laniakea.Collection.AddressChina.insert(p6c4c2t6)

  p6c4c2t7 =
    name:'关桥'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t7._id =Laniakea.Collection.AddressChina.insert(p6c4c2t7)

  p6c4c2t8 =
    name:'徐套'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t8._id =Laniakea.Collection.AddressChina.insert(p6c4c2t8)

  p6c4c2t9 =
    name:'兴隆'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t9._id =Laniakea.Collection.AddressChina.insert(p6c4c2t9)

  p6c4c2t10 =
    name:'高崖'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t10._id =Laniakea.Collection.AddressChina.insert(p6c4c2t10)

  p6c4c2t11 =
    name:'郑旗'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t11._id =Laniakea.Collection.AddressChina.insert(p6c4c2t11)

  p6c4c2t12 =
    name:'贾塘'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t12._id =Laniakea.Collection.AddressChina.insert(p6c4c2t12)

  p6c4c2t13 =
    name:'曹洼'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t13._id =Laniakea.Collection.AddressChina.insert(p6c4c2t13)

  p6c4c2t14 =
    name:'九彩'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t14._id =Laniakea.Collection.AddressChina.insert(p6c4c2t14)

  p6c4c2t15 =
    name:'李俊'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t15._id =Laniakea.Collection.AddressChina.insert(p6c4c2t15)

  p6c4c2t16 =
    name:'红羊'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t16._id =Laniakea.Collection.AddressChina.insert(p6c4c2t16)

  p6c4c2t17 =
    name:'关庄'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t17._id =Laniakea.Collection.AddressChina.insert(p6c4c2t17)

  p6c4c2t18 =
    name:'甘城'
  #    sn:''
    code:''
    level:3
    parent:p6c4c2._id
    children:[]
  p6c4c2t18._id =Laniakea.Collection.AddressChina.insert(p6c4c2t18)

  children_hy=[{'_id':p6c4c2t0._id,'name':p6c4c2t0.name},{'_id':p6c4c2t1._id,'name':p6c4c2t1.name},
    {'_id':p6c4c2t2._id,'name':p6c4c2t2.name},{'_id':p6c4c2t3._id,'name':p6c4c2t3.name},
    {'_id':p6c4c2t4._id,'name':p6c4c2t4.name},{'_id':p6c4c2t5._id,'name':p6c4c2t5.name},
    {'_id':p6c4c2t6._id,'name':p6c4c2t6.name},{'_id':p6c4c2t7._id,'name':p6c4c2t7.name},
    {'_id':p6c4c2t8._id,'name':p6c4c2t8.name},{'_id':p6c4c2t9._id,'name':p6c4c2t9.name},
    {'_id':p6c4c2t10._id,'name':p6c4c2t10.name},{'_id':p6c4c2t11._id,'name':p6c4c2t11.name}
    {'_id':p6c4c2t12._id,'name':p6c4c2t12.name},{'_id':p6c4c2t13._id,'name':p6c4c2t13.name},
    {'_id':p6c4c2t14._id,'name':p6c4c2t14.name},{'_id':p6c4c2t15._id,'name':p6c4c2t15.name},
    {'_id':p6c4c2t16._id,'name':p6c4c2t16.name},{'_id':p6c4c2t17._id,'name':p6c4c2t17.name},
    {'_id':p6c4c2t18._id,'name':p6c4c2t18.name}]

  Laniakea.Collection.AddressChina.update({_id:p6c4c2._id},{$set:{'children':children_hy}})

  children_zw=[{'_id':p6c4c0._id,'name':p6c4c0.name},{'_id':p6c4c1._id,'name':p6c4c1.name},
    {'_id':p6c4c2._id,'name':p6c4c2.name}]
  Laniakea.Collection.AddressChina.update({_id:p6c4._id},{$set:{'children':children_zw}})

  children=[{'_id':p6c0._id,'name':p6c0.name},{'_id':p6c1._id,'name':p6c1.name},
    {'_id':p6c2._id,'name':p6c2.name},{'_id':p6c3._id,'name':p6c3.name},
    {'_id':p6c4._id,'name':p6c4.name}]
  Laniakea.Collection.AddressChina.update({_id:p6._id},{$set:{'children':children}})
