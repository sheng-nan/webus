Template.myCurrentWorklists.helpers
  worklists_qr: ->
    selector={}
    docId = Meteor.user()?._id
    if docId
      selector['docid'] = docId
      selector['state'] = '确认'
    return Laniakea.Collection.Worklists.find(selector,{}) #limit:10
Template.myCurrentWorklists.onRendered ->
  options=
    fields:
      patid: 1
      pat: 1
      age: 1
      sex: 1
      apmt: 1
      mod: 1
      apldepid: 1
      apldep: 1
      apldocid: 1
      apldoc: 1
      docid: 1
      doc : 1
      exmpt: 1
      exmitm: 1
      fee: 1
      state: 1
      note: 1
  instance = Template.instance()
  instance.autorun ->
    selector={}
    depId = Meteor.user()?.profile?.doctor?.depid
    if depId
      selector['apldepid']= depId
      startTime = moment().startOf('day').toDate()
      endTime = moment(startTime).add(1, 'days').toDate()
      selector['$and']= [{'apmt':{'$gte':startTime}},{'apmt':{'$lte':endTime}}]
    instance.subscribe "subWorklists", selector, options
