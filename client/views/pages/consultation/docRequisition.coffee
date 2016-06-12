Template.docRequisition.onCreated ->
  Meteor.subscribe('singleConsultation',this._id)
  following = Meteor.user()?.profile?.doctor?.following
  Meteor.subscribe('doctorSearch',{roles:{$in:['doctor']},_id:{$nin:[Meteor.userId()],$in:following}},{fields: {'profile.name': 1, 'profile.doctor'}})
Template.docRequisition.helpers
  'currentConsultation':->
    Laniakea.Collection.Consultations.findOne(@_id)
  doctors: ->
    following = Meteor.user()?.profile?.doctor?.following
    Meteor.users.find({roles:{$in:['doctor']},_id:{$nin:[Meteor.userId()],$in:following}})
Template.docRequisition.events
  'submit #docRequisitionForm':(e,t)->
    e.preventDefault()
    docreq =
      'conmod':e.target['conmod'].value
      'conpur':e.target['conpur'].value
      'initdiag':e.target['initdiag'].value
      'st':new Date
    condocs = []
    t.$('input[name=condocs]:checked').each(()->
      doc =
        _id:$(this).data('id')
        name:$(this).data('name')
        status:false
      condocs.push doc
    )
    Laniakea.Collection.Consultations.update({_id:@_id},{$set:{docreq:docreq,condocs:condocs,constatus:'待会诊'}})