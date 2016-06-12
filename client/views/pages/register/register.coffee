Template.register.onRendered ->
  Session.set('validMobile', '')
  Session.set('registerUserId', null)
  instance = Template.instance()
  instance.autorun ->
      instance.subscribe "securityCodes"
AutoForm.hooks
  registerUserForm:
    onError: (operation, error)->
      console.log("添加失败" + error)
    onSuccess:(form,result)->

    onSubmit:(insertDoc,updateDoc,currentDoc)->
      userPhone = $('#userPhone').val()
      userCode = $('#userCode').val()
      userPwd = $('#userPwd').val()
      userRePwd = $('#userRePwd').val()
      if userPhone && userPhone != ''
        Session.set('validMobile', userPhone)
        insertDoc['profile.name'] = userPhone
        insertDoc['username'] = userPhone
        insertDoc['roles'] = ['doctor']
        insertDoc['profile.doctor.verify'] = 0 #自行注册的医生状态默认为0(未审核)
        if userCode && userCode != ''
          codes = Laniakea.Collection.SecurityCodes.find({'mobile':userPhone})
          if codes?.count() > 0
            code = codes.fetch()[0].code
            console.log code
            console.log userCode
            if userCode == code
              if userPwd && userPwd != '' && userPwd == userRePwd
                insertDoc['password'] = userPwd
                insertDoc['confirmPassword'] = userRePwd
                Meteor.call 'addUser', insertDoc, (error,result)->
                  if result?.success
                    Session.set('registerUser', result._id)
                    #判断是否跳转界面
                    if $("#checkbox1").prop("checked")
                      Router.go('/register2')
                    else
                      alert('请先查看并同意注册协议!')
                  else
                    console.log error
                    toastr.error('添加失败')
                    return
              else
                toastr.error('密码不一致或不能为空!')
                return
          else
            toastr.error('验证码不正确,请确认!')
            return
        else
          toastr.error('请输入验证码!')
          return
      else
        toastr.error('手机号不能为空!')
        return
      Meteor.call 'addUser',insertDoc, (error,result)->
        if result?.success
          #          Meteor.users.update({_id:result},{$set:{'profile.photo':insertDoc.profile.photo}})
        else
          console.log error
          toastr.error('添加失败')
      this.done()
Template.register.events
    'click #registNext': (e, t)->
        e.preventDefault()
    'click #getCode': (e, t)->
        e.preventDefault()
        userPhone = $('#userPhone').val()
        if userPhone && userPhone != ''
            Meteor.call 'sendSMSCode',userPhone
        else
            toastr.error('手机号不能为空!')
            return
