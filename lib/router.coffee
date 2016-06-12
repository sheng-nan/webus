@subs = new SubsManager()
Router.configure
  layoutTemplate : 'mainLayout'
  loadingTemplate: "loading"
  notFoundTemplate: "notFound"
#
# Example pages routes
#
#登录后首页
Router.route '/',
  name:'homepageMain',
  waitOn:->
    if Meteor.userId()
      ids = []
      if Roles.userIsInRole(Meteor.userId(),['doctor']) and  Meteor.user()?.profile?.doctor?.prmpatids?
        ids = ids.concat Meteor.user()?.profile?.doctor?.prmpatids
        selector=
          _id:
            $in:ids
          'profile.patient.prmdocid':Meteor.userId()
        subs.subscribe 'patients', selector,{}
      else if Roles.userIsInRole(Meteor.userId(),['nurse']) and  Meteor.user()?.profile?.nurse?.depid?
        [
          Meteor.subscribe 'subWorklists', {'apldepid': Meteor.user()?.profile?.nurse?.depid}
          Meteor.subscribe 'doctors'
          Meteor.subscribe 'singleDepartment', Meteor.user()?.profile?.nurse?.depid
        ]
      else
        []

#判断是否登录
isLogin = ->
  if !Meteor.userId()
    Session.set 'username', ''
    @layout 'blankLayout'
    @render 'login'
  else
    @next()

#  登录之前调用
Router.onBeforeAction isLogin,
  except:[
    'login','register','register2','register3','submitSuccess','examineSuccess','examineNoSuccess','usePhoneLogin','lanyaShow','lanyaUpload','addWeight','addPressure','addEcg','addGlucose','addOxygen','addOxygen2','dropzoneDicomUrl'
  ]

##登录
#Router.route '/login',
#  layoutTemplate:'blankLayout'
#  name:'login'
#  action: ->
#    if !Meteor.userId()
#      @layout 'blankLayout'
#      @render 'login'
#    else
#      Router.go "/"

#退出
Router.route '/logout',
  action: ->
    Meteor.logout (err) ->
      unless err
        Router.go '/'

Router.route "/mypatients",
  action: ->
    Session.set('queryPatPara', '')
    @render('patientList')
Router.route "/patients",
  action: ->
    @render('patientManage')
  waitOn:->
    if Meteor.userId()
      if Meteor.user()?.profile?.nurse?.depid?
        [
          Meteor.subscribe 'subWorklists', {'apldepid': Meteor.user()?.profile?.nurse?.depid}
          Meteor.subscribe 'doctors'
          Meteor.subscribe 'singleDepartment', Meteor.user()?.profile?.nurse?.depid
        ]
      else
        []

#查找
Router.route '/profile/:_id',
  name:'patientProfile'
  waitOn:->
    [
      Meteor.subscribe 'singleUser',@params._id
      Meteor.subscribe 'healthRecords',@params._id
      Meteor.subscribe 'dicomList',@params._id
    ]

  data:->
    Meteor.users.findOne @params._id
#医生好友
Router.route '/doctorList',
  name:'doctorList'
  action:->
    if Roles.userIsInRole(Meteor.userId(),'doctor')
      @render('doctorList')
Router.route '/doctors/:_id',
  name: 'doctorIndex'
  waitOn: ->
    [ Meteor.subscribe('singleUser', @params._id) ]
  data: ->
    Meteor.users.findOne @params._id
#显示医生
Router.route 'doc_profile/:_id',
  name:'doctorProfile'
  data:->
    Meteor.users.findOne this.params._id

#显示护士
Router.route 'nurseProfile/:_id',
  name:'nurseProfile'
  data:->
    Meteor.users.findOne this.params._id

Router.route '/myProfile',
  name:'myProfile'
  action:->
    if Roles.userIsInRole(Meteor.userId(),'doctor')
      @render('doctorProfile')
    else if Roles.userIsInRole(Meteor.userId(),'nurse')
      Router.go '/nurseProfile/'+currentUser._id
    else
      false

Router.route '/worklists',
  name:'worklists'
  waitOn:->
    if Meteor.user()?
      [
        subs.subscribe 'singleDepartment', Meteor.user()?.profile?.nurse?.depid
      ]

Router.route 'uscapturefromworklist',
  action:->
    if Meteor.userId()
      @render('uscapture')
  waitOn: ->
    if Meteor.userId()
      [
#        Meteor.subscribe 'usKnowledgeNodes', {}
      ]

Router.route 'uscapture/:_id',
  action:->
    @render('uscapture')
  waitOn: ->
    [
#      Meteor.subscribe 'usKnowledgeNodes', {}
      Meteor.subscribe 'singleMedimgReport',@params._id
    ]
  data:->
    data = Laniakea.Collection.MedimgReports.findOne @params._id
    if data  and data?.state == '已新建'
      Laniakea.Collection.MedimgReports.update({_id: @params._id}, {$set:{state:'编辑中'}})
    Laniakea.Collection.MedimgReports.findOne @params._id

Router.route '/usKnowledgeNodes'

Router.route '/medimgReports',
  name:'medimgReports'

Router.route '/usKnowledgeNode',
  name:'usKnowledgeNode',
  waitOn:->
#    Meteor.subscribe 'usKnowledgeNodes', {}

Router.route '/reportEdit/:_id' ,
  name:'usReportEdit'
  action:->
    @render('medimgReportEdit')
  waitOn:->
    [
      Meteor.subscribe 'singleMedimgReport',@params._id
#      Meteor.subscribe 'usKnowledgeNodes', {}
    ]
  data:->
    Laniakea.Collection.MedimgReports.findOne @params._id
Router.route '/medimgReports/:_id',
  name:'medimgReportDetail'
  waitOn:->
    Meteor.subscribe 'singleMedimgReport',@params._id
  data:->
    Laniakea.Collection.MedimgReports.findOne @params._id

Router.route '/reportPreview/:_id',
  name:'reportPreview'
  waitOn:->
    Meteor.subscribe 'singleMedimgReport',@params._id
  data:->
    Laniakea.Collection.MedimgReports.findOne @params._id

Router.route '/auditReports',
  name:'auditMedimgReportList'
#  action:->
#    Session.set('selectedReport',null)
#    @render('auditMedimgReportList')
  waitOn:->
    option=
      sort:{st:-1}
      limit:10
      fields:
        pat:1
        age:1
        sex:1
        st:1
        exmpt:1
        exmitm:1
        apldoc:1
        doc:1
        si:1
        state:1
    if Meteor.userId()
      if Meteor.user()?.profile?.doctor?.depid?
        selector =
          depid:Meteor.user()?.profile?.doctor?.depid
          state:'已保存'
      if Meteor.user()?.profile?.patient?.depid?
        selector =
          depid:Meteor.user()?.profile?.patient?.depid
          state:'已保存'
      if Meteor.user()?.profile?.nurse?.depid?
        selector =
          depid:Meteor.user()?.profile?.nurse?.depid
          state:'已保存'
      Meteor.subscribe 'medimgReports',selector,option

Router.route '/modifyReports',
  name:'modifyMedimgReportList'
#  action:->
#    Session.set('selectedReport',null)
#    @render('modifyMedimgReportList')
  waitOn:->
    option=
      sort:{st:-1}
      limit:10
      fields:
        pat:1
        age:1
        sex:1
        st:1
        exmpt:1
        exmitm:1
        apldoc:1
        doc:1
        si:1
        state:1
    if Meteor.userId()
      if Meteor.user()?.profile?.doctor?.depid?
        selector =
          depid:Meteor.user()?.profile?.doctor?.depid
          state:'已打回'
      if Meteor.user()?.profile?.patient?.depid?
        selector =
          depid:Meteor.user()?.profile?.doctor?.depid
          state:'已打回'
      if Meteor.user()?.profile?.nurse?.depid?
        selector =
          depid:Meteor.user()?.profile?.doctor?.depid
          state:'已打回'
      Meteor.subscribe 'medimgReports',selector,option

Router.route '/printReport',
  name:'printMedimgReportList'
#  action:->
#    Session.set('selectedReport',null)
#    @render('printMedimgReportList')
#  waitOn:->
#    option=
#      sort:{st:-1}
#      limit:10
#      fields:
#        pat:1
#        age:1
#        sex:1
#        st:1
#        exmpt:1
#        exmitm:1
#        apldoc:1
#        doc:1
#        si:1
#        state:1
#    if Meteor.userId()
##      if Meteor.user()?.profile?.doctor?.depid?
##        selector =
##          depid:Meteor.user()?.profile?.doctor?.depid
##          state:{$in:['已审核','已打印']}
##      if Meteor.user()?.profile?.patient?.depid?
##        selector =
##          depid:Meteor.user()?.profile?.patient?.depid
##          state:{$in:['已审核','已打印']}
#      if Meteor.user()?.profile?.nurse?.depid?
#        selector =
#          depid:Meteor.user()?.profile?.nurse?.depid
#          state:{$in:['已审核','已打印']}
#      Meteor.subscribe 'medimgReports',selector,option


# 远程会诊
Router.route '/consultation/:_id',
  name:"consultation"
  waitOn:->
    Meteor.subscribe 'consultation',@params._id
  data:->
    Laniakea.Collection.Consultations.findOne @params._id
Router.route 'consultationList',
  name: "consultationList"
  waitOn: ->
    if Meteor.userId()
      Meteor.subscribe 'myConsultations'
  action: ->
    @render('consultationList')

Router.route '/chatSessionList', #咨询列表
  name: "chatSessionList"
  waitOn: ->
    if Meteor.userId()
      Meteor.subscribe 'chatSessionByDoctorID',Meteor.userId()
  action: ->
    @render('chatSessionList')

#dicom影像列表数据
Router.route '/dicomList',
  name:'dicomList'
  waitOn:->
    if Meteor.userId()
      Meteor.subscribe 'dicomList',(Meteor.userId())

Router.route '/dicomStudies/:_id',
  name:'dicomStudies'
  layoutTemplate:'dicomLayout'
  waitOn:->
    if Meteor.userId()
      Meteor.subscribe 'singleDicom',@params._id
  data:->
    Laniakea.Collection.DicomStudies.findOne @params._id

Router.route 'uploadDicom/:_id',
  name:'uploadDicom'
  waitOn:->
    Meteor.subscribe 'dicomList',@params._id
    Meteor.subscribe 'singleUser',@params._id
  data:->
    Meteor.users.findOne @params._id

Router.route '/dropzone/uploadDicom',where:'server',name:'dropzoneDicomUrl'
.post ->
  @response.end(JSON.stringify(true))

Router.route '/outMediaRecords/:_id',
  name:'outMediaRecords'
  waitOn:->
    Meteor.subscribe 'singleOutMedRecord',@params._id
  data:->
    Laniakea.Collection.OutMedRecords.findOne @params._id

Router.route '/outMediaRecordList',
  name:'outMediaRecordList'

Router.route '/ecgShow/:_id',
  name:'ecgShow'
  waitOn:->
    if Meteor.userId()
      Meteor.subscribe 'healthRecords',@params._id
  data:->
    Session.set("ecgId",@params.query.ecgId)
    Laniakea.Collection.HealthRecords.findOne @params._id

Router.route '/charge',
  name:'charge'

Router.route '/medicineReceiving',
  name: 'medicineReceiving'
  waitOn:->
    Meteor.subscribe 'drugStocks',{},{}

Router.route '/videoedu',
  name:'videoedu'
#  waitOn:->
#    Meteor.subscribe 'videos',{},{limit:18}

Router.route '/player/:_id',
  name:'player'
  waitOn:->
    Meteor.subscribe 'singleVideo',@params._id
  data:->
    Laniakea.Collection.Videos.findOne @params._id
#注册页面
#创建个人用户
Router.route '/register',
  layoutTemplate:'blankLayout'
  name:'register'
#  完善个人信息
Router.route '/register2',
  layoutTemplate:'blankLayout'
  name:'register2'
#  完善执业信息
Router.route '/register3',
  layoutTemplate:'blankLayout'
  name:'register3'
#信息提交成功
Router.route '/submitSuccess',
  layoutTemplate:'blankLayout'
  name:'submitSuccess'
#审核通过
Router.route '/examineSuccess',
  layoutTemplate:'blankLayout'
  name:'examineSuccess'
#审核未通过
Router.route '/examineNoSuccess',
  layoutTemplate:'blankLayout'
  name:'examineNoSuccess'


#使用手机验证码登陆
Router.route '/usePhoneLogin',
  layoutTemplate:'blankLayout'
  name:'usePhoneLogin'