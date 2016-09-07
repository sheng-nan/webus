Template.register2.onRendered ->
  instance = Template.instance()
  instance.autorun ->
      instance.subscribe "singleUser", Session.get('registerUserId'), {}
Template.register2.helpers
  registUser: ()->
    return Meteor.users.findOne Session.get('registerUserId')

Template.register2.events
    'click #registNext2': (e, t)->
      e.preventDefault()
      userName = $('#username').val()
      userSex = $('#usersex').val()
      userDate = $('#userdata').val()
      userPhoto = $('#userphoto').val()
      if userName && userName != ''
        console.log userName
        Router.go '/register3'
      else
        toastr.error('姓名不能为空!')
        return false

