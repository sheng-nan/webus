Template.patientCard.events
  'click button[href=#updatePatientModal]':(e,t)->
    Session.set('selectedPatient',@doc)
  'click button[href=#confirmDeleteModal]':(e,t)->
    Session.set('selectedPatient',@doc)
  'click button[href=#addPatientWorkListModal]':(e,t)->
    Session.set('selectedPatient',@doc)
  'click #startUsReport':(e,t)->
    dep = Laniakea.Collection.Departments.findOne(Meteor.user()?.profile?.doctor?.depid)
    r =
      patid: @doc._id
      pat: @doc.profile?.name #姓名
      age: moment().diff(@doc.profile?.birthday, 'years')      #年龄
      sex: @doc.profile.sex
      docid: Meteor.userId()
      doc:Meteor.user()?.profile?.name
      depid: dep._id
      dep:dep.name
      hosid: dep.hosid
      hos: dep.hos
      st : new Date
      mod:'US'
      state:'已新建'
      logs:[
        uid:Meteor.userId()
        u:Meteor.user()?.profile.name
        a:'新建'
      ]
    _id = Laniakea.Collection.MedimgReports.insert(r)
    r._id = _id
    if @ws? and @ws
      document.title = "{\"action\":\"StartUSReport\",\"id\":\""+_id+"\"}"
      Session.set('currentMedimgReport',_id)
      token = Session.get("querytoken")
      url = '/uscapture/'+_id+"?token="+token
#      console.log "Router.go('"+url+"')"
    else
      Session.set('currentMedimgReport',r)
      Router.go('/uscapture/'+_id)
  'click #startOutMediaRecord':(e,t)->
    record =
      hosid: Meteor.user().profile?.doctor?.hosid
      hos: Meteor.user().profile?.doctor?.hos
      depid: Meteor.user().profile?.doctor?.depid
      dep: Meteor.user().profile?.doctor?.dep
      docid: Meteor.userId()
      doc: Meteor.user().profile.name
      patid: @doc._id
      pat: @doc.profile?.name
      age: moment().diff(@doc.profile?.birthday, 'years')
      sex: @doc.profile?.sex
      digt: new Date
    rid = Laniakea.Collection.OutMedRecords.insert(record)
    if rid
      Session.set('currentoutmedrecord',rid)
      Router.go('/outMediaRecordList/')
  'click #startChatSession':(e,t)->
    Meteor.call('startChatSession',@doc._id,(err,res)->
      if !err and res
        Session.set('currentChatSession',res._id)
        Router.go('/chatSessionList')
    )
Template.patientCard.helpers
  'photo':->
    if @doc.profile?.photo
      @doc.profile.photo
    else if @doc.profile?.sex == '女'
      '/img/user-girl-default.png'
    else
      '/img/user-boy-default.png'
   "isws": ->
     this.ws
   "profileName": ->
     if @doc.profile.name.length > 4
       @doc.profile.name.substr(0,4)+'...'
     else
       @doc.profile.name