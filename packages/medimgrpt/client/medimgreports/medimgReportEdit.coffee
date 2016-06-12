Template.medimgReportEdit.helpers
  data:->
    if @ws? and @ws
      currentreportId = Session.get('currentMedimgReport')?._id
      if currentreportId? and currentreportId
        if Template.instance().subscribe('singleMedimgReport',currentreportId).ready()
          Session.set('selectedFee',@doc.fee)
          return @doc = Laniakea.Collection.MedimgReports.findOne(currentreportId)
      return @doc
    else
      currentR = Session.get('currentMedimgReport')
      if(currentR)
        if Template.instance().subscribe('singleMedimgReport',currentR?._id).ready()
          Session.set('selectedFee',Laniakea.Collection.MedimgReports.findOne(Session.get('currentMedimgReport')?._id)?.fee)
          return Laniakea.Collection.MedimgReports.findOne(currentR?._id)
      else
        {}
Template.medimgReportEdit.onRendered ->
  height = $(window).height()-130
  $('.box-full-height').slimscroll
    height: height,
#    alwaysVisible:true
