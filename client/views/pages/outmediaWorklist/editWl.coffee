Template.editWl.onCreated ->
  Session.set('ptName', '')
  Session.set('DepId', '')
Template.editWl.helpers
  depOptions: ->
    getDepartmetns()
  selectedWorklist:->
    wl = Laniakea.Collection.Worklists.findOne Session.get('selectedOutmediaWlId')
    if wl
      Session.set('itm_fee', wl.fee)
      return wl
  devsOptions: ->
    if Session.get('DepId')
      getDevs(Session.get('DepId'))
  sersOptions: ->
    if Session.get('DepId')
      getSers(Session.get('DepId'))
  itm_fee: ->
    Session.get('itm_fee')
  exmptOptions_p: ->
    if Session.get('DepId')
      getDepExmpts(Session.get('DepId'))
  exmitmAddOptions_p:  ->
    getDepExmitms(Session.get('ptName'), Session.get('DepId'))
Template.editWl.events
  "change [name=exmdepid]":(e)->
    str = $('#edit_exmdepid').val()
    $('#edit_dep_name').val($('#edit_exmdepid').find("option:selected").text())
    Session.set('DepId', str)
  'change [name=exmpt]':(e,t)->
    e.preventDefault()
    pt_id = t.$('#owl_exmpt_edit').val()
    Session.set('ptName', pt_id)
  'change [name=exmitm]':(e)->
    e.preventDefault()
    itm = $('#owl_itm_edit').find("option:selected").text()
    fee = itm.substring(itm.indexOf('(')+1, itm.length-1)
    Session.set('itm_fee', fee)
Template.editWl.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    if Meteor.user()?.profile?.nurse
      hosid = Meteor.user()?.profile?.nurse?.hosid
    else
      if Meteor.user()?.profile?.doctor
        hosid = Meteor.user()?.profile?.doctor?.hosid
    instance.subscribe 'departments', hosid
  instance.autorun ->
    instance.subscribe "singleDepartment", Session.get('DepId')
AutoForm.hooks
  editOutmediaWlForm:
    onError: (operation, error)->
    onSuccess:->
      $('#editOutmediaWlModal').modal('hide')
getDevs = (depid) ->
  options = []
  if depid
    dep = Laniakea.Collection.Departments.findOne(depid)
    if dep
      dep.dev.forEach (element) ->
        options.push
          label: element.name
          value: element.name
        return
      options
getSers = (depid) ->
  options = []
  if depid
    dep = Laniakea.Collection.Departments.findOne(depid)
    if dep
      dep.servs.forEach (element) ->
        options.push
          label: element
          value: element
        return
      options
getDepartmetns = ->
  options = []
  if Meteor.user()?.profile?.nurse
    hosid = Meteor.user()?.profile?.nurse?.hosid
  else
    if Meteor.user()?.profile?.doctor
      hosid = Meteor.user()?.profile?.doctor?.hosid
  if hosid?
    Laniakea.Collection.Departments.find({"hosid" : hosid}).fetch().forEach (element) ->
      options.push
        label: element.name
        value: element._id
      return
    options
getDepExmpts = (depid) ->
  options = []
  if depid? && depid != ''
    Laniakea.Collection.Departments.findOne(depid).exmpt.forEach (element) ->
      options.push
        label: element.posn
        value: element.posn
      return
    options
getDepExmitms = (pt_id, depid) ->
  options = []
  if pt_id && pt_id != ''
    if depid && depid != ''
      dep = Laniakea.Collection.Departments.findOne(depid)
      if dep
        dep.exmpt.forEach (element) ->
          if element.posn == pt_id
            element.exmitm.forEach (el) ->
              options.push
                label: el.itmn+'('+el.fee+')'
                value: el.itmn
          return
        options
#判断重复的检查项
exmIsExist = (exms, itm) ->
  bl = false
  exms.forEach (e) ->
    if e.itm == itm
      bl = true
  return bl

