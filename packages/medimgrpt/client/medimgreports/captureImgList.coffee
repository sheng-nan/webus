Template.captureImgList.events
  "mouseover .img-span":(e,t)->
    t.$(e.currentTarget).find('.operate_btn').removeClass('none')
  "mouseout .img-span":(e,t)->
    t.$(e.currentTarget).find('.operate_btn').addClass('none')
  'click a[id=img-close-btn]':(e,t)->
    reportID = Session.get('currentMedimgReport')?._id
    img={fid:@fid,url:@url,print:@print}
    Meteor.call 'removeImage',reportID,img,(error,result)->
      if error?
        toastr.success("更新图片失败")
  'click a[id=img-show-btn]':(e,t)->
    reportID = Session.get('currentMedimgReport')?._id
    t.$('#big-img-div img').attr "src", @url
    t.$('#bigImgModal').modal 'show'
#    t.$('#big-img-div').removeClass('none')
#  'click a[id=pre-close-btn]':(e,t)->
#    t.$('#big-img-div img').attr "src",''
#    t.$('#big-img-div').addClass('none')
  'click img[name=captureImage]':(e,t)->
    reportID = Session.get('currentMedimgReport')?._id
    Meteor.call 'updateImageStatus',reportID,@url,!@print,(error,result)->
      if error?
        toastr.success("更新图片状态失败")
  'change #video':(e,t)->
    t.find('video').src = this.data.url;

Template.captureImgList.helpers
  'imgs':->
    Laniakea.Collection.MedimgReports.findOne(Session.get('currentMedimgReport')?._id)?.imgs