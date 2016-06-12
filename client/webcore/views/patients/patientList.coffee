Template.patientList.onCreated ->
  instance = this
  instance.query = new ReactiveVar()
  instance.showNotPrm = new ReactiveVar(false)
  if Meteor.userId() and Roles.userIsInRole(Meteor.userId(),['doctor'])
    selector=
      $or:[
        {'profile.patient.prmdocid':Meteor.userId()},
        {'profile.patient.docids':Meteor.userId()}
      ]
    options =
      sort:
        updatedAt:-1
    subs.subscribe 'patients', selector,options
    depid = Meteor.user()?.profile?.doctor?.depid
    instance.subscribe "singleDepartment", depid

Template.patientList.helpers
  showNotPrm:->
    Template.instance().showNotPrm.get()
  isWS:->
    Template.instance().data?.ws
  'prmPatientList':->
    reg = Template.instance().query.get()
    if reg?
      Meteor.users.find({$or:[{'profile.si': reg}],$and:['profile.patient.prmdocid':Meteor.userId(),roles:{$in:['patient']}]},{sort:{updatedAt:-1}})
    else
      Meteor.users.find({roles:{$in:['patient']},'profile.patient.prmdocid':Meteor.userId()},{sort:{updatedAt:-1}})
  'patientList': ->
    reg = Template.instance().query.get()
    if reg?
      Meteor.users.find({$or:[{'profile.si': reg}],$and:['profile.patient.docids':Meteor.userId(),roles:{$in:['patient']}]},{sort:{updatedAt:-1}})
    else
      Meteor.users.find({roles:{$in:['patient']},'profile.patient.docids':Meteor.userId()},{sort:{updatedAt:-1}})

Template.patientList.events
  'input [name=patientListQueryPara]':(e,t)->
    text = t.$(e.target).val()?.trim()
    if text?
      reg = new RegExp(text, 'i')
      Template.instance().query.set(reg)
  'click .showPrm':(e,t)->
    $('.Prm').removeClass('active btn-primary').addClass('btn-white')
    $('.showPrm').removeClass('btn-white').addClass('active btn-primary')
    Template.instance().showNotPrm.set(true)
  'click .Prm':(e,t)->
    $('.showPrm').removeClass('active btn-primary').addClass('btn-white')
    $('.Prm').removeClass('btn-white').addClass('active btn-primary')
    Template.instance().showNotPrm.set(false)
#  'change input[name=showPrm]':(e,t)->
#    Template.instance().showNotPrm.set(t.find('input[name=showPrm]').checked)
  'submit #patientListQuery':(e)->
    e.preventDefault()