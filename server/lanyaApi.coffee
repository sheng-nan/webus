settingHeader=->
  @response.statusCode = 200
  @response.setHeader("Content-Type", "application/json")
  @response.setHeader("Access-Control-Allow-Headers", "Origin, X-Requested-With, Content-Type, Accept")

respData=(isSuccess,reason)->
  resp =
    success: isSuccess
    reason: reason

#蓝牙设备获取绑定用户的信息
Router.route '/lanya/show',where:'server',name:'lanyaShow'
.get ->
  settingHeader
  mobile=@params.query.scanCode
  user=Meteor.users.findOne('profile.mobile':mobile)
  resp={}
  if user
    resp=
#      birthday:user.profile.birthday
      birthday:'1988-10-05'
      height:'175'
      sex:'1'
      weight:'75'
  else
    resp=
      success: false
      reason: "on user 手机号输入错误，没有此用户"

  @response.end(JSON.stringify(resp))

# 网关统一入口，配置nignx对路径解析,如果能访问到upload方法，表示程序出错了
Router.route '/lanya/upload',where:'server',name:'lanyaUpload'
.post ->
  settingHeader
  mobilePhone=@params.query.scanCode
  resp =
    success: false
    reason: '网关统一入口，配置nignx对路径解析,如果能访问到此方法并且能返回数据,表示程序配置出错了'
  @response.end(JSON.stringify(resp))

#体重
#测试 curl -X POST -H "Content-Type: application/json" -d '[{"weight": 80,"measureTime": "2015-08-31 10:24:21" },{"weight": 70,"measureTime": "2015-08-31 10:24:21"},{"weight": 75,"measureTime": "2015-08-31 10:24:21"} ]' http://localhost:3000/lanya/upload/wt/901/0/3?scanCode=18837689566
Router.route '/lanya/upload/wt/901/0/3',where:'server',name:'addWeight'
.post ->
    settingHeader
    resp={}
    lastData={}
    mobile=@params.query.scanCode
    user=Meteor.users.findOne('profile.mobile':mobile)
    if user
      hr=Laniakea.Collection.HealthRecords.findOne user._id
      wtDatas=this.request.body
#      wtDatas=JSON.parse this.request.body._json
      wtDatas.forEach (val)->
        wt=
          v:Number(val.weight)
#          t:val.measureTime
          t: moment(new Date()).format("YYYY-MM-DD H:m")

        #保存
        Meteor.call 'addweight',user._id,wt
#        if hr
#          Laniakea.Collection.HealthRecords.update user._id,{$push:{wt:wt}}
#        else
#          Laniakea.Collection.HealthRecords.insert "_id":user._id,wt:[wt]
#          hr=Laniakea.Collection.HealthRecords.findOne user._id
#        Laniakea.Collection.HealthRecords.update user._id,{$set:'ld.wt':wt}
      resp =
        success: true
        reason: "体重"
    else
      resp =
        success: false
        reason: "用户不存在"

    @response.end(JSON.stringify(resp))

#血压
Router.route '/lanya/upload/bp/201/2/3',where:'server',name:'addPressure'
.post ->
    settingHeader
    resp={}
    mobile=@params.query.scanCode
    user=Meteor.users.findOne('profile.mobile':mobile)
    if user
        hr=Laniakea.Collection.HealthRecords.findOne user._id
#        pbDatas=JSON.parse this.request.body._json
        pbDatas=this.request.body
        pbDatas.forEach (val)->
          bp=
            hv:val.systolic
            lv:val.diastolic
#            t:val.measureTime
            t:moment(new Date()).format("YYYY-MM-DD H:m")

          #保存
          Meteor.call 'addbp',user._id,bp
          ###if hr?
            Laniakea.Collection.HealthRecords.update user._id,{$push:{bp:bp}}
          else
            Laniakea.Collection.HealthRecords.insert "_id":user._id,bp:[bp]
            hr=Laniakea.Collection.HealthRecords.findOne user._id
          #添加最新测量
          Laniakea.Collection.HealthRecords.update user._id,{$set:'ld.bp':bp}###
        resp =
          success: true
          reason: "血压"
    else
      resp =
        success: false
        reason: "用户不存在"

    @response.end(JSON.stringify(resp))

#心电图
Router.route '/lanya/upload/ecg/301/1/3',where:'server',name:'addEcg'
.post ->
  settingHeader
  mobile=@params.query.scanCode
  user=Meteor.users.findOne('profile.mobile':mobile)
  if user
    hr=Laniakea.Collection.HealthRecords.findOne user._id
#    ecgDatas=JSON.parse this.request.body._json
    ecgDatas=this.request.body
    base64encode=''
    ecgDatas.forEach (val)->
      ecgImg=CryptoJS.enc.Base64.stringify(CryptoJS.enc.Utf8.parse(val.ecgImg))
      base64encode=ecgImg
      mongoID = (new Mongo.ObjectID)._str
      ecg=
        _id:mongoID
#        t:val.measureTime
        t:moment(new Date()).format("YYYY-MM-DD H:m")
        e:ecgImg
      if hr?
        Laniakea.Collection.HealthRecords.update user._id,{$push:{ecg:ecg}}
      else
        Laniakea.Collection.HealthRecords.insert "_id":user._id,ecg:[ecg]
        hr=Laniakea.Collection.HealthRecords.findOne user._id
    resp =
      success: true
      reason: "心电图"
      #base64encode:base64encode
  else
    resp =
      success: false
      reason: "用户不存在"
  @response.end(JSON.stringify(resp))

#血糖
Router.route '/lanya/upload/bg/1001/0/3',where:'server',name:'addGlucose'
.post ->
  settingHeader
  resp={}
  lastData={}
  mobile=@params.query.scanCode
  user=Meteor.users.findOne('profile.mobile':mobile)
  if user
    hr=Laniakea.Collection.HealthRecords.findOne user._id
#    bgDatas=JSON.parse this.request.body._json
    bgDatas=this.request.body
    bgDatas.forEach (val)->
      bg=
        v:Number(val.bgValue)
#        t:val.measureTime
        t:moment(new Date()).format("YYYY-MM-DD H:m")

      #保存
      Meteor.call 'addbbbg',user._id,bg
      ###if hr?
        Laniakea.Collection.HealthRecords.update user._id,{$push:{bbbg:bg}}

      else
        Laniakea.Collection.HealthRecords.insert "_id":user._id,bbbg:[bg]
        hr=Laniakea.Collection.HealthRecords.findOne user._id
      #添加最新测量
      Laniakea.Collection.HealthRecords.update user._id,{$set:'ld.bg':bg}###
    resp =
      success: true
      reason: "血糖"
  else
    resp =
      success: false
      reason: "用户不存在"

  @response.end(JSON.stringify(resp))

#血氧
Router.route '/lanya/upload/po/401/1/3',where:'server',name:'addOxygen'
.post ->
  settingHeader
  resp={}
  mobile=@params.query.scanCode
  user=Meteor.users.findOne('profile.mobile':mobile)
  if user
    hr=Laniakea.Collection.HealthRecords.findOne user._id
#    boDatas=JSON.parse this.request.body._json
    boDatas=this.request.body
    boDatas.forEach (val)->
      bo=
        v:val.spo2
#        t:val.measureTime
        t:moment(new Date()).format("YYYY-MM-DD H:m")

      Meteor.call 'addbo',user._id,bo
      ###if hr?
        Laniakea.Collection.HealthRecords.update user._id,{$push:{bo:bo}}
      else
        Laniakea.Collection.HealthRecords.insert "_id":user._id,bo:[bo]
        hr=Laniakea.Collection.HealthRecords.findOne user._id
      #添加最新测量
      Laniakea.Collection.HealthRecords.update user._id,{$set:'ld.bo':bo}###
    resp =
      success: true
      reason: "血氧"
  else
    resp =
      success: false
      reason: "用户不存在"

  @response.end(JSON.stringify(resp))

#血氧2
Router.route '/lanya/upload/po/403/1/3',where:'server',name:'addOxygen2'
.post ->
  settingHeader
  resp={}
  mobile=@params.query.scanCode
  user=Meteor.users.findOne('profile.mobile':mobile)
  if user
    hr=Laniakea.Collection.HealthRecords.findOne user._id
#    boDatas=JSON.parse this.request.body._json
    boDatas=this.request.body
    boDatas.forEach (val)->
      bo=
        v:val.spo2
#        t:val.measureTime
        t:moment(new Date()).format("YYYY-MM-DD H:m")

      Meteor.call 'addbo',user._id,bo
      ###if hr?
        Laniakea.Collection.HealthRecords.update user._id,{$push:{bo:bo}}
      else
        Laniakea.Collection.HealthRecords.insert "_id":user._id,bo:[bo]
        hr=Laniakea.Collection.HealthRecords.findOne user._id
      #添加最新测量
      Laniakea.Collection.HealthRecords.update user._id,{$set:'ld.bo':bo}###
    resp =
      success: true
      reason: "血氧"
  else
    resp =
      success: false
      reason: "用户不存在"

  @response.end(JSON.stringify(resp))
