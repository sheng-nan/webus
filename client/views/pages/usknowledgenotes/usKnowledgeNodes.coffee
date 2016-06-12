#Meteor.subscribe 'UsKnowledgeNodes'
Template.usKnowledgeNodes.helpers
  usKnowledgeNodes: ->
    Laniakea.Collection.UsKnowledgeNodes.find()



