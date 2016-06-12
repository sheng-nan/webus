Template.consultationInvite.onCreated ->
  Meteor.subscribe('singleConsultation',@_id)
Template.consultationInvite.helpers
  'currentConsultation':->
    Laniakea.Collection.Consultations.findOne(@_id)
  'isInvited':->
    tmp = false;
    Laniakea.Collection.Consultations.findOne(@_id)?.condocs.map (doc)->
      if Meteor.userId() is doc._id and doc.status
        tmp = true
        return
    tmp
Template.consultationInvite.events
  "click button[id=invite][class='btn btn-primary']":(e,t)->
    e.preventDefault()
    Meteor.call 'updateConsultationDoctorStatus',@_id,Meteor.userId(),true