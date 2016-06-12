vgaConstraints  =
  video: true
stream = null
mediaRecorder = null
preReportId = ""
imgkey = ""
instance = null
containsObject = (obj, list) ->
  i = 0
  while i < list.length
    if list[i] == obj
      return true
    i++
  false
Template.cameraCapture.capture = ->
  reportID = Session.get('currentMedimgReport')?._id
  unless reportID?
    console.log '请选中一条报告'
    return
  instance = Template.instance()
  video = $.find('video')[0]
  canvas = $.find('canvas')[0]
  ctx = canvas.getContext('2d')
  if stream?
    ctx.drawImage(video,0,0)
    dataURL = canvas.toDataURL('image/png')
    Meteor.call 'AliYun',(error,result)->
      if error or result != "TRUE"
        fs = Laniakea.Collection.MedimgReportImages.insert dataURL,(error,fileObj)->
        unless error
          console.log error
        imgs = Laniakea.Collection.MedimgReports.findOne(reportID)?.imgs
        preImg = {}
        instance.autorun ->
          unless imgs?
            imgs = []
          if instance.subscribe('singleMedimgReportImage',fs._id).ready()
            f = Laniakea.Collection.MedimgReportImages.findOne(fs._id)
            if f.isUploaded() and f.uploadProgress() is 100 and f.url()?
              img =
                fid:fs._id
                url:f.url()
                print:false
              if img.fid is preImg.fid
                return
              if containsObject(img,imgs)
                return
              unless img.url?
                throw Meteor.Error('上传失败')
              else
                Laniakea.Collection.MedimgReports.update({_id:reportID,},{$push:{'imgs':img}})
                preImg = img
      else if result is "TRUE"
        file = dataURItoBlob(dataURL)
        mongoID = (new Mongo.ObjectID)._str
        key = 'img/'+ mongoID+'.jpg'
        successCallback = ->
          img =
            fid:mongoID
            url:OSS.config.Endpoint+'/'+key
            print:false
          Laniakea.Collection.MedimgReports.update({_id:reportID,},{$push:{'imgs':img}})
        OSS.PostObject file,key,successCallback
Template.cameraCapture.startRecord = ->
  reportID = Session.get('currentMedimgReport')?._id
  unless reportID?
    toastr.info('请选中一条报告')
    return
  if Laniakea.Collection.MedimgReports.findOne(reportID)?.vids?[0]?
    return
  errorCallback = (e)->
    console.log('Reeeejected!', e);
  navigator.getUserMedia(vgaConstraints, (localMediaStream)->
    if localMediaStream?
      video = $.find('video')[0]
      canvas = $.find('canvas')[0]
      video.src = window.URL.createObjectURL(localMediaStream);
      stream = localMediaStream
      video.onloadedmetadata = (e)->
        canvas.width = video.videoWidth;
        canvas.height = video.videoHeight;
      mediaRecorder = new MediaStreamRecorder(stream);
      mediaRecorder.mimeType = 'video/webm';
      mediaRecorder.ondataavailable = (blob)->
        console.log 'data available'
        fs = Laniakea.Collection.Upload.insert blob,(error,fileObj)->
          unless error
            console.log error
          ar = instance.autorun ->
            if instance.subscribe('singleUploadFile',fs._id).ready()
              console.log 'sub ready'
              f = Laniakea.Collection.Upload.findOne(fs._id)
              if f.isUploaded() and f.uploadProgress() is 100 and f.url()?
                console.log 'is uploaded'
                ar.stop()
                webmPath = Laniakea.Collection.Upload.storesLookup['upload'].path+'/'+f.copies['upload'].key
                Meteor.call('mp4conv',webmPath,f._id,reportID,OSS.config.Endpoint+'/'+imgkey,->)
#        Meteor.call 'AliYun',(error,result)->
#          if error or result != "TRUE"
#            fs = Laniakea.Collection.MedimgReportImages.insert blob,(error,fileObj)->
#              unless error
#                console.log error
#              instance.autorun ->
#                if instance.subscribe('singleMedimgReportImage',fs._id).ready()
#                  f = Laniakea.Collection.MedimgReportImages.findOne(fs._id)
#                  if f.isUploaded() and f.uploadProgress() is 100 and f.url()?
#                    video =
#                      webm:f.url()
#                      img:imgkey
#                    console.log video
#                    Laniakea.Collection.MedimgReports.update({_id:reportID,},{$push:{'vids':video}})
#          else if result is "TRUE"
#            videokey = 'vid/'+ (new Mongo.ObjectID)._str+'.webm'
#            successCallback = ->
#              video =
#                webm:OSS.config.Endpoint+'/'+videokey
#                img:OSS.config.Endpoint+'/'+imgkey
#              console.log video
#              Laniakea.Collection.MedimgReports.update({_id:reportID,},{$push:{'vids':video}})
#            OSS.PostObject blob,videokey,successCallback


      mediaRecorder.start(10*60*1000);
  , errorCallback)
Template.cameraCapture.stopRecord = ->
  reportID = Session.get('currentMedimgReport')?._id
  unless reportID?
    toastr.info('请选中一条报告')
    return
  if Laniakea.Collection.MedimgReports.findOne(reportID)?.vids?[0]?
    return
  if mediaRecorder?
    video = $.find('video')[0]
    canvas = $.find('canvas')[0]
    ctx = canvas.getContext('2d')
    ctx.drawImage(video,0,0)
    dataURL = canvas.toDataURL('image/png')
    Meteor.call 'AliYun',(error,result)->
      if error or result != "TRUE"
        fs = Laniakea.Collection.MedimgReportImages.insert dataURL,(error,fileObj)->
          unless error
            console.log error
          instance.autorun ->
            if instance.subscribe('singleMedimgReportImage',fs._id).ready()
              f = Laniakea.Collection.MedimgReportImages.findOne(fs._id)
              if f.isUploaded() and f.uploadProgress() is 100 and f.url()?
                imgkey = f.url()
      else if result is "TRUE"
        imgkey = 'img/'+  (new Mongo.ObjectID)._str+'.jpg'
        file = dataURItoBlob(dataURL)
        OSS.PostObject file,imgkey,->true
    mediaRecorder.stop();
Template.cameraCapture.onRendered ->
  instance = Template.instance()
  if Laniakea.Collection.MedimgReports.findOne(Session.get('currentMedimgReport')?._id)?.state == "编辑中"
    Template.cameraCapture.startRecord()
Template.cameraCapture.events
  'click a[id=capture]':(e,t)->
    Template.cameraCapture.capture()
