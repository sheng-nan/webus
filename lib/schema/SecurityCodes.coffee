## COLLECTION
@Laniakea.Collection.SecurityCodes = new Mongo.Collection "securityCodes"

## INDEX
if Meteor.isServer
  @Laniakea.Collection.SecurityCodes._ensureIndex {mobile: 1}
## SCHEMA
@Laniakea.Schema.SecurityCodes = new SimpleSchema
  mobile:
    type:String  #手机号
  code:
    type:String  #验证码

@Laniakea.Collection.SecurityCodes.attachSchema Laniakea.Schema.SecurityCodes

if Meteor.isServer
  Meteor.publish 'securityCodes', ()->
    Laniakea.Collection.SecurityCodes.find()

#PERIMISSION
Laniakea.Collection.SecurityCodes.allow
  insert: ->
    true
  remove: ->
    true
  update: ->
    true

