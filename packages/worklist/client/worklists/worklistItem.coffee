Template.worklistItem.helpers
  stateClass: (state)->
    if state == '预约'
      return 'info-element'
    if state == '确认'
      return 'success-element'
    if state == '完成'
      return 'cencel-element'
    if state == '检查申请'
      return 'warning-element'
  equals:(a, b) ->
    a == b
Template.worklistItem.events
  'click #editWL':(e)->
    e.preventDefault()
    Router.go('worklistEdit', {_id: $('#worklist_id').val()});
  'click a[href=#editWorkListModal]':(e,t)->
    Session.set('selectedWorklist',this)
    Session.set('wlExms', Session.get('selectedWorklist')?.exms)