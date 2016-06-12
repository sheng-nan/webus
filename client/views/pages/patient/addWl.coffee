Template.addWl.onRendered ->
  Session.set('modName', '')
Template.addWl.helpers
  patAge: ->
    if Session.get('selectedPatient') != ''
      return moment().diff(Session.get('selectedPatient')?.profile?.birthday, 'years')      #年龄
  selectedPatient:->
    Session.get('selectedPatient')
  addState: ->
    '确认'
  docOptions_p: ->
    getDocs()
  dep_id: ->
    Meteor.user()?.profile?.nurse?.depid
  devOptions: ->
    getDevs(Session.get('modName'))
  doctors: ->
    Meteor.users.find({roles:{$in:['doctor']},'profile.doctor.depid':Meteor.user()?.profile?.nurse?.depid})
Template.addWl.events
  'submit #addPatWorkListForm':(e)->
    e.preventDefault()
AutoForm.hooks
  addPatWorkListForm:
    onError: (operation, error)->
#      console.log("addwrklist  err :",error)
    onSuccess:->
#      console.log("   add worklist  succ ");
      $('#addPatientWorkListModal').modal('hide');
    onSubmit:(insertDoc,updateDoc,currentDoc)->
      exms = Session.get('wlExms')
      if Meteor.user().profile.nurse
        peo = Meteor.user()?.profile?.nurse
      else
        if Meteor.user().profile.doctor
          peo = Meteor.user()?.profile?.doctor
      if exms && exms.length > 0
        exms.forEach (element) ->
          insertDoc['hosid'] = peo.hosid
          insertDoc['exmpt'] = element.pt
          insertDoc['exmitm'] = element.itm
          insertDoc['fee'] = parseInt(element.fee)
          Meteor.call 'addWorklist',insertDoc, (error,result)->
            if error?
              toastr.error('添加失败')
      this.done()

getDocs = ->
  options = []
  if Meteor.user().profile.nurse
    depid = Meteor.user()?.profile?.nurse?.depid
    if depid?
      Meteor.users.find({"profile.doctor.depid" : depid}).fetch().forEach (element) ->
        options.push
          label: element.profile.name
          value: element._id
        return
      options
getDevs = (mod) ->
#  if mod != ''
  options = []
  if Meteor.user()?.profile?.nurse
    depid = Meteor.user()?.profile?.nurse?.depid
    if depid
      dep = Laniakea.Collection.Departments.findOne(depid)
      if dep
        dep.dev.forEach (element) ->
#            if element.mod == mod
          options.push
            label: element.name
            value: element.name
          return
        options
