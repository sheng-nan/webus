AutoForm.hooks
    addKnowledgeForm:
        onError: (operation, error)->
        onSuccess:->
            $('#addKnowledgeModal').modal('hide');