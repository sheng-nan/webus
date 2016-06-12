Template.addChartForm.events
#添加体重
  'submit #addweightChartFrom':(e)->
    e.preventDefault()
    chartDate1=new Date()
    dayWrapper = moment(chartDate1)
    chartDate = dayWrapper.format("YYYY-MM-DD H:m")
    hrid= this.hrid
    weightValue=$("#weightValue").val()
    weightTime=chartDate
    $("#weightModal").modal 'hide'
    $('#weightModal').on('hidden.bs.modal',(e)->
      $("#weightValue").val("")
    )
    hr=Laniakea.Collection.HealthRecords.findOne hrid
    wt=
      v:Number(weightValue)
      t:weightTime
    Meteor.call 'addweight',hrid,wt

#    if hr
#      Laniakea.Collection.HealthRecords.update hrid,
#        {
#          $push:{
#            wt:{
#              $each:[wt],
#              $slice:-10
#            }
#          },
#          $set:{'ld.wt':wt}
#        }
#    else
#      Laniakea.Collection.HealthRecords.insert "_id":hrid,wt:[wt],ld:{wt:wt}
#    Laniakea.Collection.Weights.insert({u:hrid ,t:wt.t, v:wt.v})
#运动
  'submit #addchartActivityForm':(e)->
    e.preventDefault()
    chartDate1=new Date()
    dayWrapper = moment(chartDate1)
    chartDate = dayWrapper.format("YYYY-MM-DD H:m")
    hrid= this.hrid
    stepValue=$("#stepValue").val()
    stepTime=chartDate
    $("#chartActivityModal").modal 'hide'
    $('#chartActivityModal').on('hidden.bs.modal',(e)->
      $("#stepValue").val("")
    )
    ac=
      step:Number(stepValue)
      t:stepTime
    Meteor.call 'addactivity',hrid,ac


#血氧
  'submit #addchartboForm':(e)->
    e.preventDefault()
    chartDate1=new Date()
    dayWrapper = moment(chartDate1)
    chartDate = dayWrapper.format("YYYY-MM-DD H:m")
    hrid= this.hrid
    boValue=$("#boValue").val()
    boTime=chartDate
    $("#chartboModal").modal 'hide'
    $('#chartboModal').on('hidden.bs.modal',(e)->
      $("#boValue").val("")
    )

    bo=
      v:boValue
      t:boTime
    Meteor.call 'addbo',hrid,bo


#血糖
  'submit #addchartbgForm':(e)->
    e.preventDefault()
    chartDate1=new Date()
    dayWrapper = moment(chartDate1)
    chartDate = dayWrapper.format("YYYY-MM-DD H:m")
    hrid= this.hrid
    bgValue=$("#bgValue").val()
    bgTime=chartDate
    $("#chartbgModal").modal 'hide'
    $('#chartbgModal').on('hidden.bs.modal',(e)->
      $("#bgValue").val("")
    )
    bbbg=
      v:bgValue
      t:bgTime
    Meteor.call 'addbbbg',hrid,bbbg


#  添加心率
  'submit #addchartheartForm':(e)->
    e.preventDefault()
    chartDate1=new Date()
    dayWrapper = moment(chartDate1)
    chartDate = dayWrapper.format("YYYY-MM-DD H:m")
    #this.hrid是heathRecord的Id
    hrid= this.hrid
    heartValue=$("#heartValue").val()
    heartTime=chartDate
    $("#chartheartModal").modal 'hide'
    $('#chartheartModal').on('hidden.bs.modal',(e)->
      $("#heartValue").val("")
    )

    heartRate=
      v:heartValue
      t:heartTime
    Meteor.call 'addheartRate',hrid,heartRate

#   添加血压
  'submit #chartbloodModal':(e)->
    e.preventDefault()
    chartDate1=new Date()
    dayWrapper = moment(chartDate1)
    chartDate = dayWrapper.format("YYYY-MM-DD H:m")
    hrid= this.hrid
    highbloodValue=$("#highbloodValue").val()
    lowbloodValue=$("#lowbloodValue").val()
    bloodTime=chartDate
    $("#chartbloodModal").modal 'hide'
    $('#chartbloodModal').on('hidden.bs.modal',(e)->
      $("#highbloodValue").val("")
      $("#lowbloodValue").val("")
    )

    bp=
      hv:highbloodValue
      lv:lowbloodValue
      t:bloodTime
    Meteor.call 'addbp',hrid,bp

