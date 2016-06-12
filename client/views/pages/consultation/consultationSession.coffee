vgaConstraints =
  audio: true
  video: true
stream = null
mediaRecorder = null
multiStreamRecorder = null
preReportId = ""
imgkey = ""
instance = null
intervalId = null
upload = true
slider = null
Template.consultationSession.onCreated ->
  this.loading = new ReactiveVar(true)
  this.videoSecond = new ReactiveVar(60)
  this.hiddenCancelAndSendButton = new ReactiveVar('hidden')
  this.hiddenStartButton = new ReactiveVar('')
  instance = this
Template.consultationSession.onRendered ->
  instance = this
  $('.fancybox').fancybox padding:0;
  this.autorun ->
    if Meteor.subscribe('singleConsultation', instance.data._id).ready()
      con = Laniakea.Collection.Consultations.findOne(instance.data._id)
      docids = []
      docids.push con?.prmdocid
      con?.condocs?.map (c)->
        docids.push c._id
      if Meteor.subscribe('doctorSearch', {roles: {$in: ['doctor']}, _id: {$in: docids}},
        {fields: {'profile.name': 1, 'profile.photo'}}).ready()
        $(window).resize ->
          height = $(window).height()-190
          $('.chat-mes').css('height',height)
          $('.leftBox .slimScrollDiv').css('height',$('.chat-mes').height())
          $('.chat-mes').slimscroll height:height,scrollBy:'1000px',alwaysVisible:true,start:'bottom'
        Meteor.defer(->
          $('.chat-mes').slimscroll height:$(window).height()-190,scrollBy:'1000px',alwaysVisible:true,start:'bottom'
        )
        $('.element-detail-box').css('padding','0px')
      if con and Meteor.subscribe('singleUser', con?.patid).ready() and Meteor.subscribe('healthRecords',
        con?.patid).ready() and Meteor.subscribe('dicomList', con?.patid).ready()
        instance.loading.set(false)
  Laniakea.Collection.Consultations.find(instance.data._id).observeChanges(
    changed: (id,fields) ->
      $('.chat-mes').slimscroll height:$(window).height()-190,alwaysVisible:true,scrollBy:'1000px'
  )

Template.consultationSession.onDestroyed ->
  $('.element-detail-box').css('padding','25px')

Template.consultationSession.helpers
  load: -> #是否已经订阅完成
    Template.instance().loading.get()
  videoSecond:-> #还可以录制多少秒
    Template.instance().videoSecond.get()
  hiddenCancelAndSendButton:->
    Template.instance().hiddenCancelAndSendButton.get()
  hiddenStartButton:->
    Template.instance().hiddenStartButton.get()
  'currentConsultation': ->
    Laniakea.Collection.Consultations.findOne(@_id)
  patient: ->
    con = Laniakea.Collection.Consultations.findOne(@_id)
    Meteor.users.findOne(con?.patid)
  isFromMe: (from)->
    from is Meteor.userId()
  doctorPhoto: (docid)->
    Meteor.users.findOne(docid)?.profile?.photo
  doctorName: (docid)->
    Meteor.users.findOne(docid)?.profile?.name
  sessionType: (type)->
    this.type is type
  isPrmdoc:->
    con = Laniakea.Collection.Consultations.findOne(@_id)
    con?.prmdocid is Meteor.userId()
Template.consultationSession.events
  'submit #sessionForm': (e, t)->
    e.preventDefault()
    session =
      from: Meteor.userId()
      type: 'text'
      content: e.target['content'].value
      st: new Date()
    Laniakea.Collection.Consultations.update({_id: @_id}, {$push: {session: session}})
    e.target['content'].value = ''
  'submit #endConsultationForm': (e, t)->
    e.preventDefault()
    Laniakea.Collection.Consultations.update({_id: @_id}, {$set: {conresult:e.target['conresult'].value,et:new Date(),constatus:'会诊结束'}})
    t.$('#endConsultationModal').modal('hide')
  'click #cancelRecordVideo':(e,t)->
    upload = false
    multiStreamRecorder?.stop();
    clearInterval(intervalId)
    instance.videoSecond.set(60)
    $("input[name=videoSecond]").data('ionRangeSlider')?.update({
      from:0
    })
    instance.hiddenStartButton.set('')
    instance.hiddenCancelAndSendButton.set('hidden')
  'click #sendVideo':(e,t)->
    upload = true
    multiStreamRecorder?.stop();
    clearInterval(intervalId)
    instance.videoSecond.set(60)
    $("input[name=videoSecond]").data('ionRangeSlider')?.update({
      from:0
    })
    instance.hiddenStartButton.set('')
    instance.hiddenCancelAndSendButton.set('hidden')
  'click #startRecordVideo':(e,t)->
    instance.hiddenStartButton.set('hidden')
    instance.hiddenCancelAndSendButton.set('')
    $("input[name=videoSecond]").data('ionRangeSlider')?.update({
      from:0
    })
    instance.videoSecond.set(60)
    intervalId = setInterval(()->
      instance.videoSecond.set(instance.videoSecond.get()-1);
      $("input[name=videoSecond]").data('ionRangeSlider')?.update({
        from:60-instance.videoSecond.get()
      })
      if instance.videoSecond.get() <=0
        multiStreamRecorder?.stop();
        clearInterval(intervalId)
    ,1000);
    multiStreamRecorder.start(60 * 1000);
  'click #uploadImage':(e,t)->
    t.$('#inputImage').click()
  'change #inputImage':(e,t)->
    conid = @_id
    files = e.target.files
    file = files[0]

    if (files && files.length)
      file = files[0];
      if (/^image\/\w+$/.test(file.type))
        Meteor.call 'AliYun',(error,result)->
          if error or result != "TRUE"
            throw new Meteor.Error('未启用阿里云上传')
          else if result is "TRUE"
            mongoID = (new Mongo.ObjectID)._str
            key = 'img/'+ mongoID+'.jpg'
            successCallback = ->
              session =
                from: Meteor.userId()
                type: 'image'
                content: OSS.config.Endpoint + '/' + key
                st: new Date()
              Laniakea.Collection.Consultations.update({_id: conid}, {$push: {session: session}})
            OSS.PostObject file,key,successCallback
      else
        toastr.info('请选择一张图片')
    input = $('#inputImage')
    input.replaceWith(input.val('').clone(true))
  'hidden.bs.modal #recordVideoModal': (e, t)->
    multiStreamRecorder?.stop()
#    stream?.stop()
  'shown.bs.modal #recordVideoModal': (e, t)->
    instance.hiddenStartButton.set('')
    instance.hiddenCancelAndSendButton.set('hidden')
    unless t.$("input[name=videoSecond]").data('ionRangeSlider')
      t.$("input[name=videoSecond]").ionRangeSlider({
        min:0
        max:60
        from:0
      });
    slider = t.$("input[name=videoSecond]").data('ionRangeSlider')
    if intervalId
      clearInterval(intervalId)
    Template.instance().videoSecond.set(60);
    conid = @_id
    errorCallback = (e)->
#      console.log('Reeeejected!', e);
    navigator.getUserMedia(vgaConstraints, (localMediaStream)->
      if localMediaStream?
        video = $.find('#sessionRecordVideo')[0]
        video.src = window.URL.createObjectURL(localMediaStream);
        stream = localMediaStream
        video.onloadedmetadata = (e)->
          multiStreamRecorder = new MultiStreamRecorder(stream);
          multiStreamRecorder.video = video
          multiStreamRecorder.ondataavailable = (blob)->
            audio = Laniakea.Collection.Upload.insert(blob.audio,(err,fileObj)->)
            video = Laniakea.Collection.Upload.insert(blob.video,(err,fileObj)->)
            ar = instance.autorun ->
              if instance.subscribe('singleUploadFile',audio._id).ready() and instance.subscribe('singleUploadFile',video._id).ready()
                a = Laniakea.Collection.Upload.findOne(audio._id)
                v = Laniakea.Collection.Upload.findOne(video._id)
                if a.isUploaded() and a.uploadProgress() is 100 and a.url()? and v.isUploaded() and v.uploadProgress() is 100 and v.url()?
                  ar.stop()
                  audioPath = Laniakea.Collection.Upload.storesLookup['upload'].path+'/'+a.copies['upload'].key
                  videoPath = Laniakea.Collection.Upload.storesLookup['upload'].path+'/'+v.copies['upload'].key
                  Meteor.call('avconv',audioPath,videoPath,audio._id,video._id,conid,->)
    , errorCallback)
