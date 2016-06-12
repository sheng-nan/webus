Template.ecgList.helpers
  'ecgList':->
    hr=Laniakea.Collection.HealthRecords.findOne this._id
    user=Meteor.users.findOne this._id
    Session.set('ecgPatName',user.profile.name)
    Session.set('ecgPatSex',user.profile.sex)
    Session.set('hrId',this._id)
    hr.ecg
  'ecgPatName':->
    return Session.get('ecgPatName')
  'ecgPatSex':->
    return Session.get('ecgPatSex')
  'healthRecordId':->
    return Session.get('hrId')