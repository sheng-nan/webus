Template.doctorProfile.onCreated ->
  this.tipClass = new ReactiveVar("");
  this.tip = new ReactiveVar("");
Template.doctorProfile.helpers
  currentUser:->
    Meteor.user()
  tip:->
    Template.instance().tip.get()
  tipClass:->
    Template.instance().tipClass.get()
Template.doctorProfile.events
  'submit form[name=profileForm]':(e,t)->
    e.preventDefault()
    cropped = $('#cropperImg')?.cropper('getCroppedCanvas')?.toDataURL('image/png')
    if cropped
      Meteor.call 'AliYun',(error,result)->
        if error or result != "TRUE"
          alert('阿里云环境错误！')
        else if result is "TRUE"
          file = dataURItoBlob(cropped)
          mongoID = (new Mongo.ObjectID)._str
          key = 'img/'+ mongoID+'.jpg'
          successCallback = ->
            $('#currentImg').css('display','block')
            $('#cropperImg').cropper('destroy');
            Meteor.users.update({_id:Meteor.userId()},{$set:{'profile.photo':OSS.config.Endpoint+'/'+key}})
          OSS.PostObject file,key,successCallback
    instance = Template.instance()
    form = e.target
    name = form['name']?.value
    unless name
      instance.tipClass.set('alert alert-danger')
      instance.tip.set('姓名不能为空')
      return
    doct = form['doct']?.value
    exp = form['exp']?.value
    desc = form['desc']?.value
    Meteor.users.update({_id:Meteor.userId()},{$set:{'profile.name':name,'profile.doctor.doct':doct,'profile.doctor.exp':exp,'profile.doctor.desc':desc}})
  'submit form[name=accountForm]':(e,t)->
    e.preventDefault()
    instance = Template.instance()
    form = e.target
    curPassword = form['curPassword']?.value
    newPassword = form['newPassword']?.value
    unless curPassword or newPassword
      instance.tipClass.set('alert alert-danger')
      instance.tip.set('密码不能为空')
      return
    Accounts.changePassword(curPassword, newPassword, (error)->
      if (error)
        instance.tipClass.set('alert alert-danger')
        instance.tip.set('修改密码失败,当前输入密码不正确')
        return
      else
        instance.tipClass.set('text-navy')
        instance.tip.set('修改密码成功')
    )
  'click #bigImgDiv .js-select-file': (e, t) ->
    t.$('#bigImgDiv .js-file').click()

  'change #bigImgDiv .js-file': (e, t) ->
    files = e.target.files
    file = files[0]
    $inputImage = $('#inputImage');
    $image = $('#cropperImg')
    $('#currentImg').css('display','none')
    URL = window.URL || window.webkitURL;
    if (!$image.data('cropper'))
      $image.cropper(
        strict:true
        aspectRatio: 1,
        autoCropArea: 0.65,
        modal:true,
        crop: (e)->
#          console.log(e.x);
#          console.log(e.y);
#          console.log(e.width);
#          console.log(e.height);
#          console.log(e.rotate);
#          console.log(e.scaleX);
#          console.log(e.scaleY);
      );

    if (files && files.length)
      file = files[0];

      if (/^image\/\w+$/.test(file.type))
        blobURL = URL.createObjectURL(file);
        $image.one('built.cropper', ->
          URL.revokeObjectURL(blobURL);
        ).cropper('reset').cropper('replace', blobURL);
        $inputImage.val('');
      else
        toastr.info('请选择一张图片')

  'click #iconDiv .js-select-file': (e, t) ->
    t.$('#iconDiv .js-file').click()
Template.doctorProfile.onRendered ->
  $('.minHeight').css('min-height',$(window).height()-54)
  $( window ).resize ->
    $('.minHeight').css('min-height',$(window).height()-54)
  $('body').addClass 'fixed-sidebar'
  $('body').addClass 'full-height-layout'
  # Set the height of the wrapper
  $('#page-wrapper').css 'min-height', $(window).height() + 'px'

Template.doctorProfile.onDestroyed ->
  $('body').removeClass 'fixed-sidebar'
  $('body').removeClass 'full-height-layout'
  # Destroy slimScroll for left navigation
  $('#page-wrapper').removeAttr 'style'


