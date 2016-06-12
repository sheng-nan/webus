Template.showWl.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    instance.subscribe 'singleWorklist',Session.get('selectedOutmediaWlId')
Template.showWl.helpers
  'selectedWl':->
    Laniakea.Collection.Worklists.findOne Session.get('selectedOutmediaWlId')