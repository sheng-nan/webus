##  COLLECTION
@Laniakea.Collection.Bos = new Mongo.Collection ("bos")

##  INDEX

##  SCHEMA

@Laniakea.Schema.Bos = new SimpleSchema
  bo:
    type: [ Laniakea.Schema.Bo ]
    label: "血氧"
    optional: true

## PUBLISH
if Meteor.isServer
  Meteor.publish 'bos',(id)->
    Laniakea.Collection.Bos.find(id)
