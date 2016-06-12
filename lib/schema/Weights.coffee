##  COLLECTION
@Laniakea.Collection.Weights = new Mongo.Collection ("weights")

##  INDEX
if Meteor.isServer
  @Laniakea.Collection.Weights._ensureIndex {u: 1}
##  SCHEMA

@Laniakea.Schema.Weights = new SimpleSchema
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
    label: "体重"
    decimal: true
    optional: true

## PUBLISH
if Meteor.isServer
  Meteor.publish 'Weights',(id)->
    Laniakea.Collection.Weights.find(id)
  Meteor.publish 'WeightsByUser',(uid)->
    Laniakea.Collection.Weights.find({u:uid})