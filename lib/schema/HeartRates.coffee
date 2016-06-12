##  COLLECTION
@Laniakea.Collection.HeartRates = new Mongo.Collection ("heartrates")

##  INDEX
if Meteor.isServer
  @Laniakea.Collection.HeartRates._ensureIndex {u: 1}
##  SCHEMA

@Laniakea.Schema.HeartRates = new SimpleSchema
  u:
    type: String
    label: "用户"
    optional: false
  t:
    type: Date
    label: "测量时间"
    optional: true
  hr:
    type: Number
    label: "心率"
    decimal: true
    optional: true
## PUBLISH
if Meteor.isServer
  Meteor.publish 'heartrates',(id)->
    Laniakea.Collection.HeartRates.find(id)

  Meteor.publish 'hrByUser',(uid)->
    Laniakea.Collection.HeartRates.find({u:uid})
