Template.boChartView.rendered = ->
  instance = Template.instance()
  instance.patId = new ReactiveVar(this.data._id)

  instance.autorun ->
    hr=Laniakea.Collection.HealthRecords.findOne instance.patId.get()
    bo=hr?.bo
    len=bo?.length
    boData = new Array
    xData=new Array
    if len>0
      #显示最近10天的数据
      if len>10
        min=len-10
      else
        min=0
      for i in [min..len-1]
        time=moment(bo[i].t).format('MM-DD')
        xData.push [time]
        boData.push [bo[i].v]
    $('#boChart').highcharts
      colors:['#ffffff']
      chart:
        type: 'line'
        backgroundColor:'rgba(255,255,255,0)'
        height: 300
      title:
        text:''
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
        pointFormat:'血氧:{point.y}'
        valueSuffix: '%'
      lang:
        noData:'<span style="color:#fff">'+'您还没有添加记录'+'</span>'
      credits:
        href:''
        text:''
      series: [ {
        showInLegend:false
        data: boData
      } ]