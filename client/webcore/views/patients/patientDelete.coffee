Template.patientDelete.events
  'click #deletePatient':(e,t)->
    if Roles.userIsInRole(Meteor.userId(),['doctor'])
      selectedP = Session.get('selectedPatient')
#    从患者中将相关医生移除
      Meteor.users.update({_id:selectedP?._id},{$pull:{'profile.patient.docids':Meteor.userId()},$unset:{'profile.patient.prmdocid':''}})