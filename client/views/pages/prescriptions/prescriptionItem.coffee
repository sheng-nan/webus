Template.prescriptionItem.events
  'click .list-group-item': (e,t)->
      Session.set('selectedPrescriptionId', @_id)