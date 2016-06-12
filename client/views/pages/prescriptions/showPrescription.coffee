Template.showPrescription.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    instance.subscribe 'singlePrescription',Session.get('selectedPrescriptionId')
Template.showPrescription.helpers
  'selectedPrescription':->
    Laniakea.Collection.Prescriptions.findOne Session.get('selectedPrescriptionId')