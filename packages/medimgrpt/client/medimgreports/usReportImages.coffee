Template.usReportImages.helpers
  'images':->
    Laniakea.Collection.MedimgReports.findOne(Router.current().params._id)?.imgs