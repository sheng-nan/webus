Template.myCurrentReports.helpers
  'currentMedimgReports': ->
    today = moment().startOf('day')
    tomorrow = moment(today).add(1, 'days');
    selecter = {
      st: {
        $gte: today.toDate(),
        $lt: tomorrow.toDate()
      },
      state:{$in:['已新建','编辑中','已保存' ]}
    }
    Laniakea.Collection.MedimgReports.find(selecter,{sort:{updatedAt:-1},limit:15})
Template.myCurrentReports.events
  'click a[href=#showmedimgReportModal]':(e,t)->
    Session.set('selectedReport',@_id)
  'click  #showmedimgReportModalDiv1': (e, t)->
    rid= Session.get("currentMedimgReport")?._id
    currentReport = Laniakea.Collection.MedimgReports.findOne({_id:rid})
    if @_id == rid
      return
    if currentReport and  currentReport?.state != '已保存'
      alert("请保存现有报告再编辑新报告")
      return
    else
      Session.set('currentMedimgReport', @)
      if($("#medimgReportEditForm"))
        AutoForm.resetForm("medimgReportEditForm")
      Laniakea.Collection.MedimgReports.update({_id: @._id}, {$set:{state:'编辑中'}})
      Session.set("editInputReport",'')
      if t.parent()?.data?.ws
        document.title = "{\"action\":\"StartEditReport\",\"id\":\"" + @._id + "\"}"
      else
        Template.cameraCapture.startRecord();

Template.myCurrentReports.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    today = moment().startOf('day')
    tomorrow = moment(today).add(1, 'days');
    selecter = {
      st: {
        $gte: today.toDate(),
        $lt: tomorrow.toDate()
      },
      state:{$in:['已新建','编辑中','已保存' ]}
    }
    instance.subscribe 'medimgReports', selecter, {}




