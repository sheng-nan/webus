Template.usReportImage.events
  'click':->
    Meteor.call('updateImageStatus',Router.current().params._id,Template.currentData().url,!Template.currentData().print)