Template.medicineReceiving.onCreated ->
    increment = 10
    instance = this
    instance.queryText = new ReactiveVar()
    instance.limit = new ReactiveVar(increment)
    Session.set('selectedPrescriptionId', '')
Template.prescriptionItem.events
    'input #prescriptionQueryParam':(e,t)->
        text = t.$(e.target).val()?.trim()
        if text?
            Template.instance().queryparam.set(text)
Template.medicineReceiving.helpers
    prescriptions: ->
        Laniakea.Collection.Prescriptions.find({'state': '已收费'})
Template.medicineReceiving.onRendered ->
    $('body').addClass 'fixed-sidebar'
    $('body').addClass 'full-height-layout'
    $('#page-wrapper').css 'min-height', $(window).height() + 'px'
    $('.full-height-scroll').slimscroll height: '100%'
    instance = Template.instance()
    instance.autorun ->
        text = instance.queryText.get()
        limit = instance.limit.get()
        selector=
            pat:text
            state:'已收费'
        options =
            limit:limit
            sort:
                updatedAt:-1
            fields:
                patid:1
                pat:1
                age:1
                state:1
                hosid:1
                sex:1
                birthday:1
                feetype:1
                fee:1
                drugs:1
        subs.subscribe 'prescriptions', selector,options

    $(window).scroll ->
#      文档高度                滚动条高度               浏览器高度
        if $(document).height() - $(window).scrollTop() - $(window).height()<300
            text = instance.queryText.get()
            limit = instance.limit.get()
            if Meteor.user().profile.nurse
                hosid = Meteor.user()?.profile?.nurse?.hosid
            else
                if Meteor.user().profile.doctor
                    hosid = Meteor.user()?.profile?.doctor?.hosid
            if text
                reg = new RegExp(text, 'i')
                count = Laniakea.Collection.Prescriptions.find({$or:[{'pat': reg}],$and:['hosid': hosid, 'state': '已收费']}).count()
            else
                count = Laniakea.Collection.Prescriptions.find({'hosid': hosid}).count()
            hasMore = count == limit
            limit =  if hasMore then limit + 5 else count
            instance.limit.set(limit)
Template.medicineReceiving.onDestroyed ->
    $('body').removeClass 'fixed-sidebar'
    $('body').removeClass 'full-height-layout'
    $('.sidebar-collapse').removeAttr 'style'
    $('#page-wrapper').removeAttr 'style'