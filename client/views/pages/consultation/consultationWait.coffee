Template.consultationWait.onCreated ->
  Meteor.subscribe('singleConsultation',@_id)
Template.consultationWait.helpers
  'currentConsultation':->
    Laniakea.Collection.Consultations.findOne(@_id)
  'isInvitedCount':->
    tmp = 0;
    Laniakea.Collection.Consultations.findOne(@_id)?.condocs.map (doc)->
      if doc.status
        tmp++
    tmp
Template.consultationWait.events
  "click #startConsultation":(e,t)->
    e.preventDefault()
    Laniakea.Collection.Consultations.update({_id:@_id},{$set:{constatus:'会诊中',st:new Date()}})