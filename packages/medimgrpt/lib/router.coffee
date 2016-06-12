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
  name:'uscapture',
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