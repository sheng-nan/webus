Template.outmediaWorklist.helpers
    currentoutmedrecord:->
        Laniakea.Collection.OutMedRecords.findOne Session.get('currentoutmedrecord')
Template.outmediaWorklist.events
    'click .editWl':(e,t)->
        Session.set('selectedOutmediaWlId',@_id)
        $('#editOutmediaWlModal').modal 'show'

    'click .delWl':(e,t)->
        e.preventDefault()
        if confirm('确定删除该处方吗?')
            Laniakea.Collection.Worklists.remove({_id:@_id})
            wls = Laniakea.Collection.OutMedRecords.findOne({_id:Session.get('currentoutmedrecord')}).wls
            i=0
            while i<wls?.length
                if wls[i]._id==@_id
                    wls.splice(i,1)
                    break
                i++
            Laniakea.Collection.OutMedRecords.update({_id:Session.get('currentoutmedrecord')},{$set:{'wls':wls}})
    'click .showWl':(e,t)->
        e.preventDefault()
        Session.set('selectedOutmediaWlId',@_id)
        $('#showOutmediaWlModal').modal 'show'



