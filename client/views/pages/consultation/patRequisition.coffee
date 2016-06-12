Template.patRequisition.onCreated ->
  this.patientSearch = new ReactiveVar('')
  this.index = new ReactiveVar(1)
  selector=
    $or:[
      {'profile.patient.prmdocid':Meteor.userId()}
    ]
  options =
    sort:
      updatedAt:-1
  Meteor.subscribe 'patients', selector,options
  following = Meteor.user()?.profile?.doctor?.following
  Meteor.subscribe('doctorSearch',{roles:{$in:['doctor']},_id:{$nin:[Meteor.userId()],$in:following}},{fields:{'profile.name':1,'profile.doctor':1}})
Template.patRequisition.helpers
  patients: ->
    text = Template.instance().patientSearch.get()
    if text?
      reg = new RegExp(text, 'i')
      return Meteor.users.find({'profile.si': reg,$and:[{'profile.patient.prmdocid':Meteor.userId()},roles:{$in:['patient']}]}).map((u,index)->
        u.index = index;
        u;
      )
    else
      return Meteor.users.find({roles:{$in:['patient']},'profile.patient.prmdocid':Meteor.userId()}).map((u,index)->
        u.index = index;
        u;
      )
  doctors: ->
    following = Meteor.user()?.profile?.doctor?.following
    Meteor.users.find({roles:{$in:['doctor']},_id:{$nin:[Meteor.userId()],$in:following}})
  prmdoc :->
    Meteor.user()?.profile?.name
Template.patRequisition.events
  "click .search_list.unstyled li":(e,t)->
    instance = Template.instance()
    li = t.$(e.target)
    console.log(li)
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
    instance.index.set(instance.$(e.target).data('index'))
    $('#patid').val(patid)
    $('#sel_input').val(patName)
    $('.search_list').hide()
    e.preventDefault()

  "keydown #sel_input": (e,t)->
    instance = Template.instance()
    #上下键获取焦点
    key = e.which
    ###回车搜索###
    text = Template.instance().patientSearch.get()
    if text?
      reg = new RegExp(text, 'i')
      patLen = Meteor.users.find({'profile.si': reg,$and:[{'profile.patient.prmdocid':Meteor.userId()},roles:{$in:['patient']}]}).count()
    else
      patLen = Meteor.users.find({roles:{$in:['patient']},'profile.patient.prmdocid':Meteor.userId()}).count()
    $('.search_list').show()
    if key == 38
      ###向上按钮###
      instance.index.set(instance.index.get()-1)
      if instance.index.get() < 0
        instance.index.set(patLen-1)
#到顶了，
    else if key == 40
      ###向下按钮###
      instance.index.set(instance.index.get()+1)
      if instance.index.get() >= patLen
        instance.index.set(0)
    #到底了
    #回车 key =13
    if key == 13
      li = $('.search_list li:eq('+instance.index.get()+')')
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
      li = $('.search_list li:eq('+instance.index.get()+')')
      li.css('background', '#f3f3f3').siblings().css 'background', ''
  "click #search": ->
    $('.search_list').show()
  'input #sel_input':(e)->
    e.preventDefault();
    sp = $('#sel_input').val()
    if sp == ''
      sp = ''
    Template.instance().patientSearch.set(sp)
  'submit #patRequisitionForm':(e,t)->
    e.preventDefault()
    li = $('.search_list li:eq('+Template.instance().index.get()+')')
    patid = li.data('id')
    pat = li.data('name')
    patreq =
      condition:e.target['condition'].value
      st:new Date
    docreq =
      'conmod':e.target['conmod'].value
      'conpur':e.target['conpur'].value
      'initdiag':e.target['initdiag'].value
      'st':new Date
    condocs = []
    t.$('input[name=condocs]:checked').each(()->
      doc =
        _id:$(this).data('id')
        name:$(this).data('name')
        status:false
      condocs.push doc
    )
    Laniakea.Collection.Consultations.insert({pat:pat,patid:patid,prmdoc:Meteor.user().profile.name,prmdocid:Meteor.userId(),patreq:patreq,docreq:docreq,condocs:condocs,constatus:'待会诊'})
    t.$('#patRequisitionModal').modal('hide')
  'show.bs.modal #patRequisitionModal':(e,t)->
    patRequisitionForm.reset()
    t.$('input[name=prmdoc]').val(Meteor.user()?.profile?.name)