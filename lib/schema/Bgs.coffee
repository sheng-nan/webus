##  COLLECTION
@Laniakea.Collection.Bgs = new Mongo.Collection ("bgs")

##  INDEX

##  SCHEMA

@Laniakea.Schema.Bgs = new SimpleSchema
  u:
    type: String
    label: "用户"
    optional: false
  t:
    type: Date
    label: "测量时间"
    optional: true
  v:
    type: Number
    label: "血糖"
    decimal: true
    optional: true

## PUBLISH
if Meteor.isServer
  Meteor.publish 'bgs',(id)->
    Laniakea.Collection.Bgs.find(id)
  Meteor.publish 'BgsByUser',(uid)->
    Laniakea.Collection.Bgs.find({u:uid})