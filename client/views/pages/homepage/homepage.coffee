#格式化时间，用于所有模板
Template.registerHelper 'simpleDate',(date)->
   moment(date).format('YYYY/MM/DD')

Template.registerHelper 'completeDate',(date)->
  moment(date).format('YYYY-MM-DD HH:mm:ss')
   
Template.registerHelper 'currentUser',->
   Meteor.user()




