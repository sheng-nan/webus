##  COLLECTION
@Laniakea.Collection.Activitys = new Mongo.Collection ("activitys")

##  INDEX

##  SCHEMA

@Laniakea.Schema.Activitys = new SimpleSchema
  u:
    type: String
    label: "用户"
    optional: false
  t:
    type: Date
    label: "测量时间"
    optional: true
  step:
    type: Number
    label: "步数"
    decimal: true
    optional: true

## PUBLISH
if Meteor.isServer
  Meteor.publish 'Activitys',(id)->
    Laniakea.Collection.Activitys.find(id)
  Meteor.publish 'ActivityByUser',(uid)->
    Laniakea.Collection.Activitys.find({u:uid})
