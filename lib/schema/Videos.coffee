#console.log 'Loading Videos.coffee'

##COLLECTION
@Laniakea.Collection.Videos = new Mongo.Collection "videos"

##Schema
@Laniakea.Schema.Video = new SimpleSchema
  title:
    type:String
    label:'标题'
    optional:true

  subtitle:
    type:String
    label:'小标题'
    optional:true

  img:
    type:String
    label:'缩略图'
    optional:true

  url:
    type:String
    label:'视频'
    optional:true

  intro:
    type:String
    label:'说明'
    autoform:
      rows: 5
    optional:true

  si:
    type:String
    label:''
    optional:true
    autoform:
      afFieldInput:
        type: 'hidden'
    autoValue: ->
      si(this,['title','subtitle'])

@Laniakea.Collection.Videos.attachSchema Laniakea.Schema.Video

## PUBLISH
if Meteor.isServer
  Meteor.publish 'videos',(selector,options)->
    unless selector
      selector = {}
    else
      if selector?.text
        text = selector?.text
        selector['$or'] =[
          'si': new RegExp(text,'i')
        ]
        delete selector.text
    unless options
      options = {}
      options.limit = 20
    Laniakea.Collection.Videos.find(selector,options)

  Meteor.publish 'singleVideo', (id) ->
    Laniakea.Collection.Videos.find id

##PERIMISSION
Laniakea.Collection.Videos.allow
  'insert':(userId,doc)->
    userId and Roles.userIsInRole(userId,['admin'])
  'update':(userId,doc,fieldNames,modifier)->
    userId and Roles.userIsInRole(userId,['admin'])
  'remove': (userId, doc)->
    userId and Roles.userIsInRole(userId,['admin'])