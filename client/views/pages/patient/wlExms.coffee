Template.wlExms.onRendered ->
    Session.set('emptName', '')
    Session.set('itm_fee', '')
    Session.set('wlExms', [])
Template.wlExms.helpers
    wlExms: ->
        Session.get('wlExms')
    itm_fee: ->
        Session.get('itm_fee')
    exmptOptions_p: ->
        getDepExmpts()
    exmitmAddOptions_p:  ->
        getDepExmitms(Session.get('emptName'))
Template.wlExms.events
    "change #pat_exmpt":(e)->
        pt_id = $('#pat_exmpt').val()
        Session.set('emptName', pt_id)
    "change #pat_exmitm":(e)->
        e.preventDefault()
        itm = $('#pat_exmitm').find("option:selected").text()
        str = $('#pat_exmitm').val()
        fee = str.substring(str.indexOf('_')+1, str.length)
        Session.set('itm_fee', fee)
    "click .btn": (e)->
        pt = $('#pat_exmpt').val()
        itm = $('#pat_exmitm').find("option:selected").text()
        fee = Session.get('itm_fee')
        exm = {pt: pt, itm: itm, fee: fee}
        arr = Session.get('wlExms')
        if pt != '' && !exmIsExist(arr, itm)
            arr.push(exm)
        Session.set('wlExms', arr)
        #    $('#exms_add').val(Session.get('wlExms'))
        $('#pat_exmpt').val('')
        $('#pat_exmitm').val('')
        Session.set('itm_fee', '')
getDepExmpts = ->
    options = []
    if Meteor.user().profile.nurse
        depid = Meteor.user()?.profile?.nurse?.depid
        if depid?
            Laniakea.Collection.Departments.findOne(depid).exmpt.forEach (element) ->
                options.push
                    label: element.posn
                    value: element.posn
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
#判断重复的检查项
exmIsExist = (exms, itm) ->
  bl = false
  exms.forEach (e) ->
    if e.itm == itm
      bl = true
  return bl
