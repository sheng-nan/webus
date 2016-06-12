Template.registerHelper 'formatName', (str) ->
  if str?.length >3
    str.substr(0,3)+'...'
  else
    str
Template.myCurrentWorklisItem.events
    "click .re-box" :(e,t )->
        wlReport = Laniakea.Collection.MedimgReports.findOne({wlid: this._id})
        if wlReport and wlReport?._id
          old =  Session.get('currentMedimgReport')
          rep = Laniakea.Collection.MedimgReports.findOne old?._id
          if rep and  rep?.state != '已保存'
            toastr.warning('请保存现有报告再编辑新报告')
            return
          else
            if($("#medimgReportEditForm"))
              AutoForm.resetForm("medimgReportEditForm")
              Laniakea.Collection.MedimgReports.update({_id: @._id}, {$set:{state:'编辑中'}})

            if t.parent()?.data?.ws
                token = Session.get("querytoken")
                document.title = "{\"action\":\"StartEditReport\",\"id\":\""+wlReport._id+"\"}"
                url = '/uscapture/'+wlReport_id+"?token="+token
                Router.go(url)
            if @state == '确认'
                Laniakea.Collection.Worklists.update({_id:@_id},{$set:{state: '完成'}},(err,result ) ->
#                  console.log " update wlist err: ", err , "result: ", result
                  Meteor.call 'updateOutmediaWl',@_id, (error,result)->
#                    if result.success
#                      console.log('门诊工作流修改成功!')
                )
            Session.set('currentMedimgReport',wlReport)
        else
#预约创建报告跳转到报告
            r =
                wlid:this._id
                pat: @pat #姓名
                hosid:@hospid
                hos:@hosp
                patid: @patid
                age: @age
                sex: @sex #性别
                doc: Meteor.user()?.profile?.name
                docid: Meteor.userId()
                depid: Meteor.user()?.profile?.doctor?.depid
                dep: Meteor.user()?.profile?.doctor?.dep
                st : new Date
                apldep: @apldep
                apldoc: @apldoc
                exmpt: @exmitm
                exmitm: @exmpt
                fee: @fee
                find: ''
                hint: ''
                mod:'US'
                state:'编辑中'
                logs:[
                    uid:Meteor.userId()
                    u:Meteor.user()?.profile?.name
                    a:'创建'
                ]

            unless r?.hosid
              r.hosid = Meteor.user()?.profile?.doctor?.hosid

            unless r?.hos
              r.hos =Meteor.user()?.profile?.doctor?.hos

            sessionReprot =  Session.get('currentMedimgReport')
            rep = Laniakea.Collection.MedimgReports.findOne({_id:sessionReprot?._id })
            if rep and  rep?.state == '编辑中'
              toastr.warning('请保存现有报告再编辑新报告')
              return
            else

              newrep_id = Laniakea.Collection.MedimgReports.insert(r)

              ur = Laniakea.Collection.MedimgReports.findOne(newrep_id)
              Session.set('currentMedimgReport',ur)
              if newrep_id
                if t.parent()?.data?.ws
                    document.title = "{\"action\":\"StartEditReport\",\"id\":\""+newrep_id+"\"}"
                    token = Session.get("querytoken")
                    url = '/uscapture/'+_id+"?token="+token
                    Router.go(url)
                else
                  Template.cameraCapture.startRecord();
                Laniakea.Collection.Worklists.update({_id:@_id},{$set:{state: '完成'}},(err,result ) ->
#                  console.log " after insert ws to report update wlist err: ", err , "result: ", result
                  Meteor.call 'updateOutmediaWl',@_id, (error,result)->
#                    if result.success
#                      console.log('门诊工作流修改成功!')
                )
              else
                  throw new Meteor.Error("error", "insert report error");


Template.myCurrentWorklisItem.helpers
    'equals':(a, b) ->
        a == b

