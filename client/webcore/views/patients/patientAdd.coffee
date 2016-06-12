AutoForm.hooks
  insertPatientForm:
    onError: (operation, error)->
#      console.log("添加失败" + error)
    onSuccess: ->
      $("#addPatientModal").modal 'hide'
    onSubmit:(insertDoc,updateDoc,currentDoc)->
      insertDoc.username = insertDoc.profile.mobile
      insertDoc.roles =['patient']
      insertDoc.profile.patient = {}
      if Roles.userIsInRole(Meteor.userId(),['doctor'])
        insertDoc.profile.patient.prmdocid = Meteor.userId()
        insertDoc.profile.patient.hosids = [Meteor.user().profile?.doctor?.hosid]
        Meteor.call 'addUser',insertDoc, (error,result)->
          if error?
            toastr.error('添加失败')
      else if Roles.userIsInRole(Meteor.userId(),['nurse'])
        insertDoc.profile.patient.hosids = [Meteor.user().profile?.nurse?.hosid]
        Meteor.call 'addUser',insertDoc, (error,result)->
          if error?
            toastr.error('添加失败')
      this.done()
Template.patientAdd.events
  'submit #insertPatientForm':(e)->
    e.preventDefault()