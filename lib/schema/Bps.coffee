##  COLLECTION
@Laniakea.Collection.Bps = new Mongo.Collection ("bps")

##  INDEX

##  SCHEMA

@Laniakea.Schema.Bps = new SimpleSchema
  bp:
    type: [ Laniakea.Schema.Bp ]
    label: "血压"
    optional: true

## PUBLISH
if Meteor.isServer
  Meteor.publish 'bps',(id)->
    Laniakea.Collection.Bps.find(id)
