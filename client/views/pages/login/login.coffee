
Template.login.events
  'submit form' : (e) ->
    e.preventDefault()

    username =  $('input[name="username"]').val()
    password =  $('input[name="password"]').val()

    Meteor.loginWithPassword(username,password,(error) ->
      if error
        $("#logintip")[0].setAttribute("class" , "m-t alert alert-danger" )
        $("#logintip")[0].innerHTML  = "用户名或者密码不正确"
      else
#        Session.set('username', username)
    )

    false
#Template.login.onRendered ->
#  $('body').removeClass ('gray-bg')
#  $('body').addClass ('gray-dark-bg')
#Template.login.onDestroyed ->
#  $('body').removeClass ('gray-dark-bg')
#  $('body').addClass ('gray-bg')
##  $('body').removeClass 'fix-bg'