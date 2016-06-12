Template.consultationEnd.onRendered ->
  instance = this
  $('.fancybox').fancybox padding:0;
  this.autorun ->
    if Meteor.subscribe('singleConsultation', instance.data._id).ready()
      con = Laniakea.Collection.Consultations.findOne(instance.data._id)
      docids = []
      docids.push con?.prmdocid
      con?.condocs?.map (c)->
        docids.push c._id
      Meteor.subscribe('doctorSearch', {roles: {$in: ['doctor']}, _id: {$in: docids}},
        {fields: {'profile.name': 1, 'profile.photo'}})
      if con and Meteor.subscribe('singleUser', con?.patid).ready() and Meteor.subscribe('healthRecords',
        con?.patid).ready() and Meteor.subscribe('dicomList', con?.patid).ready()
        instance.loading.set(false)
Template.consultationEnd.helpers
  'currentConsultation':->
    Laniakea.Collection.Consultations.findOne(@_id)
  patient: ->
    con = Laniakea.Collection.Consultations.findOne(@_id)
    Meteor.users.findOne(con?.patid)
  isFromMe: (from)->
    from is Meteor.userId()
  doctorPhoto: (docid)->
    Meteor.users.findOne(docid)?.profile?.photo
  doctorName: (docid)->
    Meteor.users.findOne(docid)?.profile?.name
  sessionType: (type)->
    this.type is type