Template.usKnowledgeNodeCard.events
  'click #addKnowledgeNode':(e,t)->
    _id = @_id
    t = Template.instance().subscribe('singleUsKnowledgeNode',_id)
    Template.instance().autorun ->
      if t.ready()
        kn = Laniakea.Collection.UsKnowledgeNodes.findOne(_id)
        if kn?.find? and kn?.hint?
          find = $('textarea[name=find]').val()
          $('textarea[name=find]').val(find + '\n   ' + kn.find)
          hint = $('textarea[name=hint]').val()
          $('textarea[name=hint]').val(hint + '\n' + kn.hint)