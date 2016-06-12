Template.patientEdit.onCreated ->
  $('#updatePatientModal').appendTo("body")
Template.patientEdit.helpers
  selectedPatient:->
    Session.get('selectedPatient')
Template.patientEdit.events
  'submit #editPatientForm':(e)->
    e.preventDefault()