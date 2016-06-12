Template.addOutmediaWl.onRendered ->
    Session.set('modName', '')
    Session.set('emptName', '')
    Session.set('itm_fee', '')
    Session.set('wlExms', [])
Template.addOutmediaWl.helpers
    addState: ->
        '检查申请'
    depOptions: ->
        getDepartmetns()
    devsOptions: ->
        if Session.get('DepId')
            getDevs(Session.get('DepId'))
    sersOptions: ->
        if Session.get('DepId')
           getSers(Session.get('DepId'))
    outmediaWlExms: ->
        Session.get('wlExms')
    outmediaItm_fee: ->
        Session.get('itm_fee')
    exmptOptions_p: ->
        if Session.get('DepId')
            getDepExmpts(Session.get('DepId'))
    exmitmAddOptions_p:  ->
        getDepExmitms(Session.get('emptName'), Session.get('DepId'))
Template.addOutmediaWl.events
    'submit #addOutmediaWlForm':(e)->
        e.preventDefault()
    "change #exmdepid":(e)->
        str = $('#exmdepid').val()
        $('#dep_name').val($('#exmdepid').find("option:selected").text())
        Session.set('DepId', str)
    "change #outmedia_exmpt":(e)->
        pt_id = $('#outmedia_exmpt').val()
        Session.set('emptName', pt_id)
    "change #outmedia_exmitm":(e)->
        e.preventDefault()
        itm = $('#outmedia_exmitm').find("option:selected").text()
        str = $('#outmedia_exmitm').val()
        fee = str.substring(str.indexOf('_')+1, str.length)
        Session.set('itm_fee', fee)
    "click .btn": (e)->
        pt = $('#outmedia_exmpt').val()
        itm = $('#outmedia_exmitm').find("option:selected").text()
        fee = Session.get('itm_fee')
        exm = {pt: pt, itm: itm, fee: fee}
        arr = Session.get('wlExms')
        if pt != '' && !exmIsExist(arr, itm)
            arr.push(exm)
        Session.set('wlExms', arr)
        #    $('#exms_add').val(Session.get('wlExms'))
        $('#outmedia_exmpt').val('')
        $('#outmedia_exmitm').val('')
        Session.set('itm_fee', '')
AutoForm.hooks
    addOutmediaWlForm:
        onError: (operation, error)->
#            console.log("addwrklist  err :",error)
        onSuccess:->
#            console.log("   add worklist  succ ");
            $('#addOutmediaWlModal').modal('hide');
        onSubmit:(insertDoc,updateDoc,currentDoc)->
            exms = Session.get('wlExms')
            if Meteor.user().profile?.nurse
              peo = Meteor.user()?.profile?.nurse
            else
                if Meteor.user()?.profile?.doctor
                    peo = Meteor.user()?.profile?.doctor
            if exms && exms.length > 0
                exms.forEach (element) ->
                    insertDoc['hosid'] = peo.hosid
                    insertDoc['apldepid'] = peo.depid
                    insertDoc['apldocid'] = peo._id
                    insertDoc['exmpt'] = element.pt
                    insertDoc['exmitm'] = element.itm
                    insertDoc['fee'] = parseInt(element.fee)
                    Meteor.call 'addWorklist',insertDoc, (error,result)->
                        if error?
                            toastr.error('添加失败')
                        obj=
                            _id: result._id
                            pat: insertDoc.pat
                            dep: $('#dep_name').val()
                            state: insertDoc.state
                            apmt: insertDoc.apmt
                        rid = $('#outmedrecord_id').val()
                        if rid && rid != ''
                            Laniakea.Collection.OutMedRecords.update({_id: rid},{$push:{wls:obj}})
            this.done()
Template.addOutmediaWl.onRendered ->
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
                                label: el.itmn
                                value: el.itmn+'_'+el.fee
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
