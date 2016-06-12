Template.charge.onCreated ->
  instance = this
  instance.queryText = new ReactiveVar()

Template.charge.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    text = instance.queryText.get()
    selector=
      si:text
      state:'开立'
    if Meteor.user()?.profile?.nurse?.hosid?
      selector['hosid']=Meteor.user()?.profile?.nurse?.hosid
    if Meteor.user()?.profile?.doctor?.hosid?
      selector['hosid']=Meteor.user()?.profile?.doctor?.hosid
    options=
      limit:15
      field:
        pat:1
        state:1
        createdAt:1
        fee:1
        si:1
    instance.subscribe 'prescriptions', selector,options

Template.charge.helpers
  'pres':->
    if Meteor.user()?.profile?.nurse?.hosid?
      hosid=Meteor.user()?.profile?.nurse?.hosid
    if Meteor.user()?.profile?.doctor?.hosid?
      hosid=Meteor.user()?.profile?.doctor?.hosid
    text = Template.instance().queryText.get()
    if text
      pat=new RegExp(text,'i')
      Laniakea.Collection.Prescriptions.find({'si':pat,'state':'开立','hosid':hosid})
    else
      Laniakea.Collection.Prescriptions.find({'state':'开立','hosid':hosid})

Template.charge.events
  'click .showPre':(e,t)->
    e.preventDefault()
    Session.set('selectedPrescriptionId',@_id)
    $('#showPrescriptionModal').modal 'show'
  'click .chargePre':(e,t)->
    e.preventDefault()
    if confirm('确认收费?')
      Laniakea.Collection.Prescriptions.update({_id:@_id},{$set:{state:'已收费'}})
  'input [name=presListQueryPara]':(e,t)->
    text = t.$(e.target).val()?.trim()
    if text?
      Template.instance().queryText.set(text)
  'keydown [name=presListQueryPara]':(e,t)->
    if(event.which == 13 )
      e.preventDefault();
      false
