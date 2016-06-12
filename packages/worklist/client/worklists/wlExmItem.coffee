Template.wlExmItem.events
    'click #del_exm':(e)->
        e.preventDefault()
        delExm(this.itm)
#删除指定的检查项
delExm = (itm) ->
    exms = Session.get('wlExms')
    exms.forEach (e) ->
        if e.itm == itm
            exms.splice($.inArray(e,exms),1);
    Session.set('wlExms', exms)