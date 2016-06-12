Template.medimgReportEditForm.onRendered ->
  if Meteor.user()?.profile?.nurse
    depid = Meteor.user()?.profile?.nurse?.depid
  if Meteor.user()?.profile?.doctor
    depid = Meteor.user()?.profile?.doctor?.depid
  instance = Template.instance()
  instance.autorun ->
    instance.subscribe "singleDepartment", depid
#  console.log this
#  console.log 'currExms'
#  Session.set('currExms',@doc?.exms)
Template.medimgReportEditForm.helpers
  itmIsExist: ->
    rid = Session.get('currentMedimgReport')?._id
    #console.log(" itmIsExist  rid :",rid);
    #console.log("   Session.get('currentMedimgReport') :", Session.get('currentMedimgReport'));
    if rid
      rep = Laniakea.Collection.MedimgReports.findOne(rid)
      if rep?.exmitm && rep?.exmitm != ''
        return true
      else
        return false
  itm_fee: ->
    if (this?.doc)
       this.doc?.fee
    else
      ''
  exmptOptions: ->
    options = []
    if Meteor.user()?.profile?.nurse
      depid = Meteor.user()?.profile?.nurse?.depid
    if Meteor.user()?.profile?.doctor
      depid = Meteor.user()?.profile?.doctor?.depid
    if depid
      dep = Laniakea.Collection.Departments.findOne(depid)
      if dep
        dep.exmpt.forEach (element) ->
          options.push
            label: element.posn
            value: element.posn
          return
        options
  exmitmOptions:  ->
    pt_id =Session.get('ptAddName')
    options = []
    if Meteor.user()?.profile?.nurse
      depid = Meteor.user()?.profile?.nurse?.depid
    if Meteor.user()?.profile?.doctor
      depid = Meteor.user()?.profile?.doctor?.depid
    if depid
      dep = Laniakea.Collection.Departments.findOne(depid)
      if dep
        dep.exmpt.forEach (element) ->
          if element.posn == pt_id
            element.exmitm.forEach (el) ->
              options.push
                label: el.itmn
                value: el.itmn+'_'+el.fee
          return
        options
Template.medimgReportEditForm.events
  'submit #medimgReportEditForm':(e,t)->
    e.preventDefault()
    if @ws?
      document.title = "{\"action\":\"EndUSReport\",\"id\":\""+@doc._id+"\"}"
  'click a[id=saveReport]':(e,t)->
    t.$('#medimgReportEditForm').submit()
    Template.cameraCapture.stopRecord();
  'input #medimgReportEditForm':(e,t)->
    e.preventDefault()
    Session.set("editInputReport",true)
    if (@doc?.state !="编辑中")
      Laniakea.Collection.MedimgReports.update({_id: this.doc._id}, {$set:{state:'编辑中'}})
      unless @ws?
        Template.cameraCapture.startRecord();
    if @ws?
      document.title = "{\"action\":\"EditUSReport\",\"id\":\""+@doc._id+"\"}"
  'click .autoform-remove-item':(e,t)->
    e.preventDefault()
    butId = e.target.parentNode.id || e.target.id
    num = butId.substr(butId.length-1)
    li = document.getElementById('li'+num)
    li.parentNode.removeChild(li)
  'change #exm_pt':(e)->
    e.preventDefault()
    pt_id = $('#exm_pt').val()
    Session.set('ptAddName', pt_id)
  'change #exm_itm':(e)->
    e.preventDefault()
    itm = $('#exm_itm').find("option:selected").text()
    $('#exmItem').val(itm)
    str = $('#exm_itm').val()
    fee = str.substring(str.indexOf('_')+1, str.length)
    Session.set('selectedFee',fee)
AutoForm.hooks
  medimgReportEditForm:
    onError: (operation, error)->
#      alert("保存失败" + error)
#      console.log " err:", error
    onSuccess: ->
      AutoForm.resetForm('medimgReportEditForm')
      if this.currentDoc.state == '编辑中' or this.currentDoc.state == '已新建'
        Laniakea.Collection.MedimgReports.update({_id: this.currentDoc._id}, {$set: {state: '已保存'}})
        wsid = this.currentDoc?.wlid
        if wsid
          ws = Laniakea.Collection.Worklists.find({_id: wsid})
          if  ws?.state != '已完成'
            Laniakea.Collection.Worklists.update({_id: wsid}, {$set: {state: '完成'}}, (err, result) ->
#              console.log " save report update wlist err: ", err ," result: ", result
              Meteor.call 'updateOutmediaWl',wsid, (error,result)->
#                if result.success
#                  console.log('门诊工作流修改成功!')
            )

      Session.set('currentMedimgReport','')
      #form reset

    onSubmit:(insertDoc, updateDoc, currentDoc)->
      Session.set("editInputReport",'')

Template.medimgReportEditForm.onRendered ->
    height = $(window).height()-130
    $('.box-full-height').css("min-height",height)
    $(window).resize ->
      height = $(window).height()-130
      $('.box-full-height').css("min-height",height)

    $('#text1').height((height-300)/2)
    $('#text2').height((height-300)/2)
