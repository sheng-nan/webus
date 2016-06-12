Template.worklistEdit.onCreated ->
  Session.set('ptName', '')
  Session.set('modName', '')
  Session.set('itm_fee', @.fee)
Template.worklistEdit.helpers
  exmptOptions: ->
    getDepExmpts()
  exmitmOptions:  ->
    getDepExmitms(Session.get('ptName'))
  docOptions: ->
    getDocs()
  selectedWorklist:->
    Session.get('selectedWorklist')
  devOptions: ->
    getDevs(Session.get('modName'))
  itm_fee: ->
    Session.get('itm_fee')
Template.worklistEdit.events
  'change [name=exmpt]':(e,t)->
    e.preventDefault()
    pt_id = t.$('#exmpt_edit').val()
    Session.set('ptName', pt_id)
  'change [name=mod]':(e,t)->
    e.preventDefault()
    mod = t.$('#mod').val()
    Session.set('modName', mod)
  'input [name=pn]':(e)->
    e.preventDefault()
    pn = $('#search_pn').val()
    Session.set('queryPname', pn)
  'click [id=cencel_wl]':(e)->
    id = $('#wl_id').val()
    $('#editWorkListModal').modal('hide')
    if id
      Laniakea.Collection.Worklists.update({_id:id},{$set:{state:'取消'}}, (err, result) ->
      Meteor.call 'updateOutmediaWl',id, (error,result)->
#        if result.success
#          console.log('门诊工作流修改成功!')
      )

  'change #itm_edit':(e)->
    e.preventDefault()
    itm = $('#itm_edit').find("option:selected").text()
    fee = itm.substring(itm.indexOf('(')+1, itm.length-1)
    Session.set('itm_fee', fee)
AutoForm.hooks
  editWorkListForm:
    onError: (operation, error)->
    onSuccess:->
      $('#editWorkListModal').modal('hide')
      id = $('#wl_id').val()
      if id
        Laniakea.Collection.Worklists.update({_id:id},{$set:{state:'确认'}}, (err, result) ->
          Meteor.call 'updateOutmediaWl',id, (error,result)->
#            if result.success
#              console.log('门诊工作流修改成功!')
        )
getDepExmpts = ->
  options = []
  if Meteor.user()?.profile?.nurse
    depid = Meteor.user()?.profile?.nurse?.depid
    if depid
      dep = Laniakea.Collection.Departments.findOne(depid)
      if dep
        dep.exmpt.forEach (element) ->
          options.push
            label: element.posn
            value: element.posn
          return
        options
getDocs = ->
  options = []
  if Meteor.user()?.profile?.nurse
    depid = Meteor.user()?.profile?.nurse?.depid
    if depid
      docs = Meteor.users.find({"profile.doctor.depid" : depid})
      if docs
        docs.fetch().forEach (element) ->
          options.push
            label: element.profile.name
            value: element._id
          return
        options
getDepExmitms = (pt_id) ->
  if pt_id
    options = []
    if Meteor.user()?.profile?.nurse
      depid = Meteor.user()?.profile?.nurse?.depid
      if depid
        dep = Laniakea.Collection.Departments.findOne(depid)
        if dep
          dep.exmpt.forEach (element) ->
            if element.posn == pt_id
              element.exmitm.forEach (el) ->
                options.push
                  label: el.itmn + '(' + el.fee + ')'
                  value: el.itmn
            return
          options
getDevs = (mod) ->
#  if mod != ''
  options = []
  if Meteor.user()?.profile?.nurse
    depid = Meteor.user()?.profile?.nurse?.depid
    if depid
      dep = Laniakea.Collection.Departments.findOne(depid)
      if dep
        dep.dev.forEach (element) ->
#            if element.mod == mod
          options.push
            label: element.name
            value: element.name
          return
        options
