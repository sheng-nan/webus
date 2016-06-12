Template.register2.onRendered ->
  instance = Template.instance()
  instance.autorun ->
      instance.subscribe "singleUser", Session.get('registerUserId'), {}
Template.register2.helpers
  registUser: ()->
    return Meteor.users.findOne Session.get('registerUserId')

Template.register2.events
    'click #': (e, t)->
