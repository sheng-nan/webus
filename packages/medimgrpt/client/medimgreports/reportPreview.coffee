Template.reportPreview.onRendered ->
  h =$('.report_height').height()
  $('.rizhi_height').height(h)
  $('.report_height').bind('resize',->
    h =$('.report_height').height()
    $('.rizhi_height').height(h)
  )
  $('.fancybox').fancybox padding:0;
#  $('#showmedimgReportModal').appendTo("body")
#  document.getElementById("big-img-div").style.top=(document.documentElement.scrollTop+(document.documentElement.clientHeight-576)/2)+"px";
#  document.getElementById("big-img-div").style.left=(document.documentElement.scrollLeft+(document.documentElement.clientWidth-1600)/2)+"px";
#  console.log 'width:',document.body.offsetWidth
#  console.log 'height:',document.body.offsetHeight
#  document.getElementById('big-img-div').style.left = (document.body.offsetWidth - 720) / 2
#  document.getElementById('big-img-div').style.top = (document.body.offsetHeight - 170) / 2
  instance = Template.instance()
  instance.autorun ->
    instance.subscribe "singleMedimgReport", Session.get('selectedReport')
    selectId=Session.get('selectedReport')
    $('#'+selectId).addClass 'active'

Template.reportPreview.helpers
  selectedReport:->
    Laniakea.Collection.MedimgReports.findOne Session.get('selectedReport')
  Imgs:->
    imgs_arr=[]
    mir=Laniakea.Collection.MedimgReports.findOne Session.get('selectedReport')
    imgs=mir?.imgs
    print_imgs=[]
    if mir&&imgs.length>0
      i=0
      while i<imgs.length
#        console.log imgs[i]
        if imgs[i].print
          print_imgs.push(imgs[i])
        i++
      if print_imgs.length>2
        imgs_arr.push(print_imgs[0])
        imgs_arr.push(print_imgs[1])
      else
        imgs_arr=print_imgs
    else
      imgs_arr=mir?.imgs
    return imgs_arr
  hos:->
    hos=''
    if Meteor.user()?.profile?.doctor?
      hos = Meteor.user()?.profile?.doctor?.hos
    if Meteor.user()?.profile?.nurse?
      hos = Meteor.user()?.profile?.nurse?.hos
    return hos
Template.reportPreview.events
  'click a[href=#bigImgModal]':(e,t)->
    t.$('#big-img-div img').attr "src", @url
    t.$('#big-img-div').removeClass('none')
  'click #imgPreviewCloseBtn':(e,t)->
    t.$('#big-img-div img').attr "src", ''
    t.$('#big-img-div').addClass('none')
  'click button[i18n-content=printButton]':(e,t)->
  'click button[i18n-content=cancelButton]':(e,t)->