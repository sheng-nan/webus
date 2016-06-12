AutoForm.hooks
  editPatientForm:
    onSubmit:(insertDoc, updateDoc, currentDoc)->
      $('#updatePatientModal').modal 'hide'
    onSuccess:->
      $('#updatePatientModal').modal 'hide'

Template.patientProfile.helpers
  "healthRecord":->
    Laniakea.Collection.HealthRecords.findOne this._id
  'photo':->
    if this.profile?.photo
      this.profile.photo
    else if this.profile?.sex == '女'
      '/img/user-girl-default.png'
    else
      '/img/user-boy-default.png'