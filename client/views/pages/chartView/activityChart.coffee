Template.activityChartView.rendered = ->
  instance = Template.instance()
  instance.patId = new ReactiveVar(this.data._id)

  instance.autorun ->
    hr=Laniakea.Collection.HealthRecords.findOne instance.patId.get()
    ac=hr?.ac
    len=ac?.length
    activityData = new Array
    xData=new Array
    if len>0
      #显示最近10天的数据
      if len>10
        min=len-10
      else
        min=0
      for i in [min..len-1]
        time=moment(ac[i].t).format('MM-DD')
        xData.push [time]
        activityData.push [ac[i].step]
    $('#activityChart').highcharts
      colors:['#ffffff']
      chart:
        type: 'line'
        backgroundColor:'rgba(255,255,255,0)'
        height: 300
      title:
        text:''
      lang:
        noData:'<span style="color:#fff">'+'您还没有添加记录'+'</span>'
      xAxis:
        categories: xData
        gridLineColor:'rgba(255,255,255,.3)'
        tickColor: 'rgba(255,255,255,.3)'
        lineColor: 'rgba(255,255,255,.3)',
        labels:
          style:
            color: 'rgba(255,255,255,.9)'
      yAxis:
        title:
          text:''
        gridLineColor:'rgba(255,255,255,.3)'
        tickColor: 'rgba(255,255,255,.3)'
        lineColor: 'rgba(255,255,255,.3)',
        labels:
          style:
            color: 'rgba(255,255,255,.9)'
      tooltip:
        pointFormat:'运动:{point.y}'
        valueSuffix: '步'
      credits:
        href:''
        text:''
      series: [ {
        showInLegend:false
        data: activityData
      } ]
