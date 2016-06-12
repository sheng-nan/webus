Template.prescriptions.onRendered ->
  height = $(window).height()-130
  $('.box-full-height').css("min-height",height)
  $(window).resize ->
    height = $(window).height()-130
    $('.box-full-height').css("min-height",height)
  $('#text1').height((height-300)/2)
  $('#text2').height((height-300)/2)

Template.prescriptions.helpers
  currentoutmedrecord:->
    Laniakea.Collection.OutMedRecords.findOne Session.get('currentoutmedrecord')

Template.prescriptions.events
  'click .showPre':(e,t)->
    e.preventDefault()
    Session.set('selectedPrescriptionId',@_id)
    $('#showPrescriptionModal').modal 'show'
  'submit #addPrescriptionForm':(e,t)->
    e.preventDefault()

  'submit #editPrescriptionForm':(e,t)->
    e.preventDefault()

  'click #addPrescriptionDiv':(e,t)->
    e.preventDefault()
    omr = Laniakea.Collection.OutMedRecords.findOne Session.get('currentoutmedrecord')
    $('#show_pat').val(omr?.pat)
    $('#show_age').val(omr?.age)
    $('#show_sex').val(omr?.sex)
    $('#show_fetp').val(omr?.fetp)
    Session.set('drugs',[])

  'click .editPre':(e,t)->
    Session.set('selectedPrescriptionId',@_id)
    $('#editPrescriptionModal').modal 'show'

  'click .deletePre':(e,t)->
    e.preventDefault()
    if confirm('确定删除该处方吗?')
      Laniakea.Collection.Prescriptions.remove({_id:@_id})
      pres = Laniakea.Collection.OutMedRecords.findOne({_id:Session.get('currentoutmedrecord')}).pres
      i=0
      while i<pres?.length
        if pres[i]._id==@_id
          pres.splice(i,1)
          break
        i++
      Laniakea.Collection.OutMedRecords.update({_id:Session.get('currentoutmedrecord')},{$set:{'pres':pres}})


