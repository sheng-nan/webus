###*
#
#  Base64 encode / decode
#  http://www.webtoolkit.info/
#
#
###
path = Npm.require('path');
fs = Npm.require('fs');
avconv = Meteor.npmRequire('avconv')
aliyun = Meteor.npmRequire('aliyun-sdk');
Base64 =
  _keyStr: 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/='
  encode: (input) ->
    output = ''
    chr1 = undefined
    chr2 = undefined
    chr3 = undefined
    enc1 = undefined
    enc2 = undefined
    enc3 = undefined
    enc4 = undefined
    i = 0
    input = Base64._utf8_encode(input)
    while i < input.length
      chr1 = input.charCodeAt(i++)
      chr2 = input.charCodeAt(i++)
      chr3 = input.charCodeAt(i++)
      enc1 = chr1 >> 2
      enc2 = (chr1 & 3) << 4 | chr2 >> 4
      enc3 = (chr2 & 15) << 2 | chr3 >> 6
      enc4 = chr3 & 63
      if isNaN(chr2)
        enc3 = enc4 = 64
      else if isNaN(chr3)
        enc4 = 64
      output = output + @_keyStr.charAt(enc1) + @_keyStr.charAt(enc2) + @_keyStr.charAt(enc3) + @_keyStr.charAt(enc4)
    output
  decode: (input) ->
    output = ''
    chr1 = undefined
    chr2 = undefined
    chr3 = undefined
    enc1 = undefined
    enc2 = undefined
    enc3 = undefined
    enc4 = undefined
    i = 0
    input = input.replace(/[^A-Za-z0-9\+\/\=]/g, '')
    while i < input.length
      enc1 = @_keyStr.indexOf(input.charAt(i++))
      enc2 = @_keyStr.indexOf(input.charAt(i++))
      enc3 = @_keyStr.indexOf(input.charAt(i++))
      enc4 = @_keyStr.indexOf(input.charAt(i++))
      chr1 = enc1 << 2 | enc2 >> 4
      chr2 = (enc2 & 15) << 4 | enc3 >> 2
      chr3 = (enc3 & 3) << 6 | enc4
      output = output + String.fromCharCode(chr1)
      if enc3 != 64
        output = output + String.fromCharCode(chr2)
      if enc4 != 64
        output = output + String.fromCharCode(chr3)
    output = Base64._utf8_decode(output)
    output
  _utf8_encode: (string) ->
    string = string.replace(/\r\n/g, '\n')
    utftext = ''
    n = 0
    while n < string.length
      c = string.charCodeAt(n)
      if c < 128
        utftext += String.fromCharCode(c)
      else if c > 127 and c < 2048
        utftext += String.fromCharCode(c >> 6 | 192)
        utftext += String.fromCharCode(c & 63 | 128)
      else
        utftext += String.fromCharCode(c >> 12 | 224)
        utftext += String.fromCharCode(c >> 6 & 63 | 128)
        utftext += String.fromCharCode(c & 63 | 128)
      n++
    utftext
  _utf8_decode: (utftext) ->
    string = ''
    i = 0
    c = c1 = c2 = 0
    while i < utftext.length
      c = utftext.charCodeAt(i)
      if c < 128
        string += String.fromCharCode(c)
        i++
      else if c > 191 and c < 224
        c2 = utftext.charCodeAt(i + 1)
        string += String.fromCharCode((c & 31) << 6 | c2 & 63)
        i += 2
      else
        c2 = utftext.charCodeAt(i + 1)
        c3 = utftext.charCodeAt(i + 2)
        string += String.fromCharCode((c & 15) << 12 | (c2 & 63) << 6 | c3 & 63)
        i += 3
    string

Meteor.methods
  'saveMirs':(report)->
    mirs =
      _id:report._id
      pat:report.pat
      age:report.age
      sex:report.sex
      hos:report.hos
      doc:report.doc
      dev:report.dev
      exmpt:report.exmpt
      exmitm:report.exmitm
      st:report.st
    hr = Laniakea.Collection.HealthRecords.findOne({_id:report.patid})
    if hr
      Laniakea.Collection.HealthRecords.update({_id:report.patid},{$push:{mirs:mirs}})
    else
      Laniakea.Collection.HealthRecords.insert({_id:report.patid,mirs:[mirs]})
  'addUser':(user)->
    console.log user
    if Meteor.user()
      id = Accounts.createUser user
      return{
        success: true
        _id: id
      }
  'updateImageStatus':(reportId,imgurl,imgstatus)->
#    have security problem
    unless Meteor.userId()
      return
    Laniakea.Collection.MedimgReports.update({'_id':reportId,'imgs.url':imgurl},{'$set':{'imgs.$.print':imgstatus}})
  updateConsultationDoctorStatus:(consultationId,doctorid,status)->
    unless Meteor.userId()
      return
    Laniakea.Collection.Consultations.update({'_id':consultationId,'condocs._id':doctorid},{'$set':{'condocs.$.status':status}})
  'removeImage':(reportId,img)->
    unless Meteor.userId()
      return
    Laniakea.Collection.MedimgReports.update({'_id':reportId},{'$pull':{imgs:img}})

  'addWorklist':(worklist)->
    if Meteor.user()
      id = Laniakea.Collection.Worklists.insert(worklist)
      return{
      success: true
      _id: id
      }
#根据工作流ID修改对应的门诊部门内的工作流
  'updateOutmediaWl':(wlid)->
    if Meteor.user()
      records = Laniakea.Collection.OutMedRecords.find({'wls._id': wlid},{fields:{ wls: 1}})
      records.forEach (element) ->
        wls = Laniakea.Collection.OutMedRecords.findOne({_id:element._id})?.wls
        i=0
        while i < wls?.length
          wl = Laniakea.Collection.Worklists.findOne(wls[i]._id)
          if wl
            wls[i].state = wl.state
          i++
        Laniakea.Collection.OutMedRecords.update({_id:element._id},{$set:{'wls':wls}})
      return{
      success: true
      }
  'addDrugStockRecord':(record)->
    if Meteor.user()
      id = Laniakea.Collection.DrugStockRecords.insert(record)
      return{
      success: true
      _id: id
      }
  'getOneWorklist':(id)->
    if Meteor.user()
      wl = Laniakea.Collection.Worklists.findOne id
      return{
      success: true
      worklist: wl
      }
  'startChatSession':(patid)->
    unless Meteor.userId()
      return {code:-1,_id:'未登录'}
    if Laniakea.Collection.ChatSessions.findOne {patid:patid,docid:Meteor.userId()}
      return {code:0,_id:Laniakea.Collection.ChatSessions.findOne({patid:patid,docid:Meteor.userId()})._id}
    else
      chatsession = {}
      chatsession.patid = patid
      chatsession.docid = Meteor.userId()
      _id = Laniakea.Collection.ChatSessions.insert(chatsession)
      return {code:0,_id:_id}

  'addDicomInstance':(pid,studyUID,seriesUID,instanceData)->
     unless Meteor.userId()
      return
     Laniakea.Collection.DicomStudies.update {'pid': pid, 'stid': studyUID, 'sl.seid': seriesUID},{$push: {'sl.$.il': instanceData}}
  'addDicomSeries':(pid,studyUID,seriesData)->
    unless Meteor.userId()
      return
    Laniakea.Collection.DicomStudies.update {'pid': pid, 'stid': studyUID},{$push: {'sl': seriesData}}

  'addDicomStudy':(pid,studyUID,seriesUID,instanceUID,instanceII,studyData,seriesData,instanceData)->
    unless Meteor.userId()
      return
    #sleep 防止并发重复添加study
    Meteor.sleep 10
    dicomStudy = Laniakea.Collection.DicomStudies.findOne {'pid': pid, 'stid': studyUID}
    series = Laniakea.Collection.DicomStudies.findOne {'pid': pid, 'stid': studyUID, 'sl.seid': seriesUID}
    instance = Laniakea.Collection.DicomStudies.findOne {'pid': pid, 'stid': studyUID, 'sl.seid': seriesUID, 'sl.il.ii': instanceII}
    if dicomStudy && series && !instance
      ni=dicomStudy.ni+1
      Laniakea.Collection.DicomStudies.update {'pid': pid, 'stid': studyUID, 'sl.seid': seriesUID},{$push: {'sl.$.il': instanceData}}
      Laniakea.Collection.DicomStudies.update {'pid': pid, 'stid': studyUID},{$set: {'ni': ni}}
    else if dicomStudy && !series && !instance
      snum=dicomStudy.snum+1
      ni=dicomStudy.ni+1
      Laniakea.Collection.DicomStudies.update {'pid': pid, 'stid': studyUID},{$push: {'sl': seriesData}}
      Laniakea.Collection.DicomStudies.update {'pid': pid, 'stid': studyUID},{$set: {'snum':snum,'ni':ni}}
    else if !dicomStudy
      Laniakea.Collection.DicomStudies.insert studyData
#    从环境变量中获取ALIYUN配置 并签名 post请求
  OssConfig:->
    oss={}
    unless Meteor.userId() and Roles.userIsInRole(Meteor.userId(),['doctor','nurse'])
      throw new Meteor.Error('权限不足')
    if process.env.ALIYUN is not "TRUE"
      throw new Meteor.Error('未启用阿里云')
    oss.aliyun = process.env.ALIYUN
    oss.access_key_id = process.env.ACCESS_KEY_ID
    date = new Date()
    policy = {
      "expiration": '2020-01-01T00:00:00.290Z',
      "conditions": [
        {"bucket": "laniakea" },
        ["content-length-range", 0, 104857600]
      ]
    }
    oss.policy_base64 = Base64.encode(JSON.stringify(policy))
    oss.signature = CryptoJS.HmacSHA1(oss.policy_base64, process.env.ACCESS_KEY_SECRET).toString(CryptoJS.enc.Base64)
    oss
#    从环境变量中获取ALIYUN配置
  AliYun:->
    unless Meteor.userId() and Roles.userIsInRole(Meteor.userId(),['doctor','nurse'])
      throw new Meteor.Error('权限不足')
    process.env.ALIYUN
  'removeHosData': (hos_id) ->
    Laniakea.Collection.Hospitals.remove
      _id: hos_id
    return
  'removeDepData': (dep_id) ->
    Laniakea.Collection.Departments.remove
      _id: dep_id
    return
  #       apath 原audio path存储路径
  #       vpath 原video path存储路径
  #       audioId videoId 原audio video所存cfs的id，转码完成后需要删除
  #       conID 转码完成后所需会诊id进行更新
  'avconv':(apath,vpath,audioId,videoId,conId)->
    unless apath or vpath
      throw new Meteor.Error('a vpath missed params error!')
#    mongoId = (new Mongo.ObjectID)._str
#    path1 = '/dfs/lan/'+mongoId.substring(0,2)
#    path2 = path1 + '/'+mongoId.substring(2,4)
#    path3 = path2 + '/'+mongoId.substring(4)
#    unless fs.existsSync(path1)
#      console.log 'avconv make path1'
#      try
#        fs.mkdirSync(path1)
#      catch ex
#        console.log 'avconv',ex
#    unless fs.existsSync(path2)
#      console.log 'avconv make path2'
#      try
#        fs.mkdirSync(path2)
#      catch ex
#        console.log 'avconv',ex
    session =
      from: Meteor.userId()
      type: 'video'
      st: new Date()
    params = [
      '-i', apath,
      '-itsoffset', '-00:00:01',
      '-i', vpath,
      '-map', '0:0',
      '-map', '1:0',
      '-strict','experimental',
      apath+'.mp4'
    ];
    stream = avconv(params)
    stream.on('error', (data)->
      throw new Meteor.Error('avconv error!')
    );
    stream.once('exit', Meteor.bindEnvironment((exitCode, signal, metadata)->
      if exitCode is 0
        console.log 'avconv complete!!!!!!!!!!!!'
        console.log 'avconv insert complete file',apath+'.mp4'
#        传到阿里云
        oss = new aliyun.OSS({
          accessKeyId: process.env.ACCESS_KEY_ID,
          secretAccessKey: process.env.ACCESS_KEY_SECRET,
          securityToken: "",
          endpoint: 'http://oss-cn-beijing.aliyuncs.com',
          apiVersion: '2013-10-15'
        });
        mongoID = (new Mongo.ObjectID)._str
        key = 'vid/'+ mongoID+'.mp4'
        fs.readFile apath+'.mp4', Meteor.bindEnvironment((err, data) ->
          if err
            console.log 'error:', err
            return
          oss.putObject {
            Bucket: 'laniakea'
            Key: key
            Body: data
            AccessControlAllowOrigin: ''
            ContentType: 'text/plain'
            CacheControl: 'no-cache'
            ContentDisposition: ''
            ContentEncoding: 'utf-8'
            ServerSideEncryption: 'AES256'
            Expires:  '2020-01-01T00:00:00.290Z'
          },  Meteor.bindEnvironment((err, data) ->
            if err
              console.log 'aliyun upload error:', err
              return
            console.log 'aliyun upload success:', data
            session.content = 'http://laniakea.oss-cn-beijing.aliyuncs.com/'+key
            console.log 'avconv observe change update session',session
            Laniakea.Collection.Consultations.update({_id: conId}, {$push: {session: session}})
#            console.log 'avconv observe change remove audio file',audioId
#            Laniakea.Collection.Upload.remove(audioId)
#            console.log 'avconv observe change remove video file',videoId
#            Laniakea.Collection.Upload.remove(videoId)
            return
          )
          return
        )


#        t = Laniakea.Collection.ConsultationFiles.insert(apath+'.mp4')
#        f = Laniakea.Collection.ConsultationFiles.find({_id : t._id})
#        handler = f.observe({
#          changed : (file, oldFile)->
#            console.log 'avconv observe change',t._id
#            if(file.url())
#              console.log 'avconv observe change ',file.url()
#              session.content = file.url()
#              console.log 'avconv observe change update session',session
#              Laniakea.Collection.Consultations.update({_id: conId}, {$push: {session: session}})
#              console.log 'avconv observe change remove audio file',audioId
#              Laniakea.Collection.Upload.remove(audioId)
#              console.log 'avconv observe change remove video file',videoId
#              Laniakea.Collection.Upload.remove(videoId)
#              handler.stop()
#      })
      )
    );
  #       webmpath 原webm存储路径
  #       webmId 原webm所存cfs的id，转码完成后需要删除
  #       reportID imgkey  转码完成后所需超声报告reportID进行更新
  'mp4conv':(webmpath,webmId,reportID,imgkey)->
    unless webmpath
      throw new Meteor.Error('webmpath missed params error!')
#    mongoId = (new Mongo.ObjectID)._str
#    path1 = '/dfs/lan/'+mongoId.substring(0,2)
#    path2 = path1 + '/'+mongoId.substring(2,4)
#    path3 = path2 + '/'+mongoId.substring(4)
#    unless fs.existsSync(path1)
#      console.log 'mp4conv make path1'
#      try
#        fs.mkdirSync(path1)
#      catch ex
#        console.log 'mp4conv',ex
#    unless fs.existsSync(path2)
#      console.log 'mp4conv make path2'
#      try
#        fs.mkdirSync(path2)
#      catch ex
#        console.log 'mp4conv',ex
    params = [
      '-i', webmpath,
      '-vcodec','libx264',
      webmpath+'.mp4'
    ];
    stream = avconv(params)
    stream.on('error', (data)->
      throw new Meteor.Error('mp4conv error!')
    );
    stream.once('exit', Meteor.bindEnvironment((exitCode, signal, metadata)->
        console.log 'mp4conv exitCode',exitCode
        if exitCode is 0
          console.log 'mp4conv complete!!!!!!!!!!!!'
          console.log 'mp4conv insert complete file',webmpath+'.mp4'
#          传到阿里云
          oss = new aliyun.OSS({
            accessKeyId: process.env.ACCESS_KEY_ID,
            secretAccessKey: process.env.ACCESS_KEY_SECRET,
            securityToken: "",
            endpoint: 'http://oss-cn-beijing.aliyuncs.com',
            apiVersion: '2013-10-15'
          });
          mongoID = (new Mongo.ObjectID)._str
          key = 'vid/'+ mongoID+'.mp4'
          fs.readFile webmpath+'.mp4', Meteor.bindEnvironment((err, data) ->
            if err
              console.log 'error:', err
              return
            oss.putObject {
              Bucket: 'laniakea'
              Key: key
              Body: data
              AccessControlAllowOrigin: ''
              ContentType: 'text/plain'
              CacheControl: 'no-cache'
              ContentDisposition: ''
              ContentEncoding: 'utf-8'
              ServerSideEncryption: 'AES256'
              Expires:  '2020-01-01T00:00:00.290Z'
            },  Meteor.bindEnvironment((err, data) ->
              if err
                console.log 'aliyun upload error:', err
                return
              console.log 'aliyun upload success:', data
              video =
                mp4:'http://laniakea.oss-cn-beijing.aliyuncs.com/'+key
                img:imgkey
              console.log 'upload success and push video',video
              Laniakea.Collection.MedimgReports.update({_id:reportID,},{$push:{'vids':video}})#push报告中视频url
#              console.log 'upload success and remove webmId',webmId
#              Laniakea.Collection.Upload.remove(webmId)
              return
            )
            return
          )

#          cfs 存到本地
#          t = Laniakea.Collection.MedimgReportVideos.insert(webmpath+'.mp4')
#          f = Laniakea.Collection.MedimgReportVideos.find({_id : t._id})
#          handler = f.observe({
#            changed : (file, oldFile)->
#              console.log 'mp4conv observe change',t._id
#              if(file.url())
#                console.log 'mp4conv observe change',file.url()
#                video =
#                  mp4:file.url()
#                  img:imgkey
#                console.log 'mp4conv observe change push video',video
#                Laniakea.Collection.MedimgReports.update({_id:reportID,},{$push:{'vids':video}})#push报告中视频url
#                console.log 'mp4conv observe change remove webmId',webmId
#                Laniakea.Collection.Upload.remove(webmId)
#                handler.stop()
#          })
      )
    );
  sendSMSCode:(mobile)->
    _r = Random.fraction()
    if _r<0.1   #如果产生0~1之间的数小于0.1 将其+0.1凑足4位
      _r+= 0.1
    code = Math.floor(_r*10000)+'';
    domain = "http://yunpian.com/v1/sms/send.json";
    apikey = "7dd260f4c5de207fb38a4ddef66612f5";
    url = domain + "?apikey=" + apikey + "&mobile=" + mobile + "&text=【看病网】您的验证码是" + code;
    HTTP.post(url, {
        headers:
          "Content-type": "application/x-www-form-urlencoded",
          "Accept": "text/plain"
      }, (err, result)->
      console.log err
      console.log result
      if JSON.parse(result?.content+'').code is 0
        sc = Laniakea.Collection.SecurityCodes.findOne({mobile:mobile});
        if sc
          Laniakea.Collection.SecurityCodes.update({_id:sc._id},{$set:{'code':code}})
        else
          Laniakea.Collection.SecurityCodes.insert({mobile:mobile,code:code})
    );
