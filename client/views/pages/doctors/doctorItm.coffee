Template.doctorItm.helpers
  'photo':->
    if this.profile?.photo
      this.profile.photo
    else if this.profile?.sex == '女'
      '/img/user-girl-default.png'
    else
      '/img/user-boy-default.png'
  'exp': ->
    exp = @.profile?.doctor?.exp
    if exp and exp.length > 18
      exp.substr(0,18)+'...'
    else
      return exp
  'isFollowed':->
    if Meteor.user()?.profile?.doctor?.following
      @_id in Meteor.user()?.profile?.doctor?.following

Template.doctorItm.events
  'click #followBtn':(e,t)->
    e.preventDefault()
    if Meteor.user()?.profile?.doctor?.following and @_id in Meteor.user()?.profile?.doctor?.following
      Meteor.users.update({_id:Meteor.userId()},{$pull:{'profile.doctor.following':@_id}})
      Meteor.users.update({_id:@_id},{$pull:{'profile.doctor.followers':Meteor.userId()}})
    else
      Meteor.users.update({_id:Meteor.userId()},{$push:{'profile.doctor.following':@_id}})
      Meteor.users.update({_id:@_id},{$push:{'profile.doctor.followers':Meteor.userId()}})
