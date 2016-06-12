@Laniakea.Collection.Feedbacks = new Mongo.Collection('feedbacks')

@Laniakea.Schema.FeedbackSchema = new SimpleSchema
  uId:
    type: String
    label: '用户id'
    optional: true

  uName:
    type: String
    label: '用户名'
    optional: true

  content:
    type: String
    label: '反馈内容'
    optional: true

  time:
    type: Date
    label: '反馈时间'
    defaultValue:new Date()



  @Laniakea.Collection.Feedbacks.attachSchema Laniakea.Schema.FeedbackSchema


  if Meteor.isServer
    Laniakea.Collection.Feedbacks.allow
      insert:(userId,doc,fieldNames,modifier)->
         return userId


