Template.outMediaRecordEditForm.onCreated ->
  @autorun ->
    Meteor.subscribe 'singleOutMedRecord', Session.get('currentoutmedrecord')

Template.outMediaRecordEditForm.events
  'click a[id=saveRecord]':(e,t)->
    t.$('#medimgRecordEditForm').submit()

Template.outMediaRecordEditForm.helpers
  currentoutmedrecord:->
    Laniakea.Collection.OutMedRecords.findOne Session.get('currentoutmedrecord')
