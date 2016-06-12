AutoForm.hooks
  addWorkListForm:
    onError: (operation, error)->
#      console.log(error)
    onSuccess: ->
      $('#addWorkListModal').modal('hide');
    onSubmit:(insertDoc,updateDoc,currentDoc)->
      exms = Session.get('wlExms')
      if Meteor.user().profile.nurse
        peo = Meteor.user()?.profile?.nurse
      else
        if Meteor.user().profile.doctor
          peo = Meteor.user()?.profile?.doctor
      if exms && exms.length > 0
        exms.forEach (element) ->
          insertDoc['hosid'] = peo.hosid
          insertDoc['exmpt'] = element.pt
          insertDoc['exmitm'] = element.itm
          insertDoc['fee'] = Number(element.fee)
          Meteor.call 'addWorklist',insertDoc, (error,result)->
          if error?
            toastr.error('添加失败')
      this.done()
Template.worklistAdd.onCreated ->
  Session.set('ptAddName', '')
  Session.set('searchPats', '*****')
  Session.set('modName', '')
  Session.set('index', 1)
  Session.set('itm_fee', '')
  Session.set('wlExms', [])
Template.worklistAdd.helpers
  wlExms: ->
    Session.get('wlExms')
  itm_fee: ->
    Session.get('itm_fee')
  addState: ->
    '确认'
  dep_id: ->
    Meteor.user()?.profile?.nurse?.depid
  patients: ->
    text = Session.get('searchPats')
    if text != '*****'
      reg = new RegExp(text, 'i')
      return Meteor.users.find({'profile.si': reg,$and:['profile.patient.hosids':Meteor.user()?.profile?.nurse?.hosid,roles:{$in:['patient']}]})
    else
      return Meteor.users.find({'profile.si': '*****',roles:{$in:['patient']},'profile.patient.hosids':Meteor.user()?.profile?.nurse?.hosid})
  doctors: ->
    Meteor.users.find({roles:{$in:['doctor']},'profile.doctor.depid':Meteor.user()?.profile?.nurse?.depid})
  exmptOptions: ->
    getDepExmpts()
  exmitmAddOptions:  ->
    getDepExmitms(Session.get('ptAddName'))
  docOptions: ->
    getDocs()
  devOptions: ->
    getDevs(Session.get('modName'))
Template.worklistAdd.events
  'submit #addWorkListForm':(e)->
    e.preventDefault()
  "keydown #sel_input": (e,t)->
    type = 'liHover'
    #上下键获取焦点
    key = e.which
#    if key == 13
#      Search()
    ###回车搜索###
    if $.trim($('#sel_input').val()).length == 0
      return
    text = Session.get('searchPats')
    if text != '*****'
      reg = new RegExp(text, 'i')
      patLen = Meteor.users.find({'profile.si': reg,$and:['profile.patient.hosids':Meteor.user()?.profile?.nurse?.hosid,roles:{$in:['patient']}]}).count()
    else
      patLen Meteor.users.find({'profile.si': '*****',roles:{$in:['patient']},'profile.patient.hosids':Meteor.user()?.profile?.nurse?.hosid}).count()
    $('.search_list').show()
    if key == 38
      ###向上按钮###
      Session.set('index', Session.get('index')-1)
      if Session.get('index') < 0
        Session.set('index', patLen-1)
  #到顶了，
    else if key == 40
      ###向下按钮###
      Session.set('index', Session.get('index')+1)
      if Session.get('index') >= patLen
        Session.set('index', 0 )
    #到底了
    if key == 13
      li = $('.search_list li:eq('+Session.get('index')+')')
      patid = li.attr('selValue')
      if patid
        pat = Meteor.users.findOne patid
        if pat
          $('#pat').val(pat.profile.name)
          $('#sex').val(pat.profile.sex)
          if pat.profile.birthday
            aDate = moment(new Date).format 'YYYY-MM-DD'
            thisYear = aDate.substr(0, 4)
            brith = moment(pat.profile.birthday).format 'YYYY-MM-DD'
            brith = brith.substr(0, 4)
            age = thisYear - brith
            $('#age').val(age)
      patName = li[0].innerText
      $('#patid').val(patid)
      $('#sel_input').val(patName)
      $('.search_list').hide()
      e.preventDefault()
    else
      li = $('.search_list li:eq('+Session.get('index')+')')
      li.css('background', '#f3f3f3').siblings().css 'background', ''
#      type = li.attr 'class'
  "click #search": ->
    $('.search_list').show()
  "click .btn": (e,t)->
    pt = $('#exm_pt').val()
    itm = $('#exm_itm').find("option:selected").text()
    fee = Session.get('itm_fee')
    exm = {pt: pt, itm: itm, fee: fee}
    arr = Session.get('wlExms')
    if pt != '' && !exmIsExist(arr, itm)
      arr.push(exm)
    Session.set('wlExms', arr)
#    $('#exms_add').val(Session.get('wlExms'))
    $('#exm_pt').val('')
    $('#exm_itm').val('')
    Session.set('itm_fee', '')
  'change #exm_pt':(e)->
    e.preventDefault()
    pt_id = $('#exm_pt').val()
    Session.set('ptAddName', pt_id)
  'change #exm_itm':(e)->
    e.preventDefault()
    itm = $('#exm_itm').find("option:selected").text()
    str = $('#exm_itm').val()
    fee = str.substring(str.indexOf('_')+1, str.length)
    Session.set('itm_fee', fee)
  'change [name=mod]':(e,t)->
    e.preventDefault()
    mod = t.$('#mod').val()
    Session.set('modName', mod)
  'click .search_list li':(e)->
    patid = $(e.target).attr('selValue')
    if patid
      pat = Meteor.users.findOne patid
      if pat
        $('#pat').val(pat.profile.name)
        $('#sex').val(pat.profile.sex)
        if pat.profile.birthday
          aDate = moment(new Date).format 'YYYY-MM-DD'
          thisYear = aDate.substr(0, 4)
          brith = moment(pat.profile.birthday).format 'YYYY-MM-DD'
          brith = brith.substr(0, 4)
          age = thisYear - brith
          $('#age').val(age)
    patName = $(e.target).context.innerText
    $('#patid').val(patid)
    $('#sel_input').val(patName)
    $('.search_list').hide()
  'input #sel_input':(e)->
    e.preventDefault();
    sp = $('#sel_input').val()
    if sp == ''
      sp = '*****'
    Session.set('searchPats', sp)

Template.worklistAdd.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    reg = Session.get('searchPats')
    selector={}
    if reg
      selector['text']= reg
    hosId = Meteor.user()?.profile?.nurse?.hosid
    selector['$and']=
      [
        roles:{$in:['patient']}
        'profile.patient.hosids':hosId
      ]
    options=
      limit:10
    instance.subscribe 'patientSearch', selector,options
    selector_doc={}
    depId = Meteor.user()?.profile?.nurse?.depid
    selector_doc['$and']=
      [
        roles:{$in:['doctor']}
        'profile.doctor.depid':depId
      ]
    instance.subscribe 'doctorSearch', selector_doc,{}
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
                label: el.itmn
                value: el.itmn+'_'+el.fee
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

#判断重复的检查项
exmIsExist = (exms,itm) ->
  bl = false
  if exms && exms.length > 0
    exms.forEach (e) ->
      if e.itm == itm
        bl = true
    return bl

