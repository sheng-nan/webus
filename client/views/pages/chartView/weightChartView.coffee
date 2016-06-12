
Template.weightChartView.rendered= ->
  instance = Template.instance()
  instance.patId = new ReactiveVar(this.data._id)

  instance.autorun ->
    hr=Laniakea.Collection.HealthRecords.findOne instance.patId.get()
    wt=hr?.wt
    len=wt?.length
    weightData = new Array
    xData=new Array
    if len>0
      #显示最近10天的数据
      if len>10
        min=len-10
      else
        min=0
      for i in [min..len-1]
        time=moment(wt[i].t).format('MM-DD')
        xData.push [time]
        weightData.push [wt[i].v]
    $('#weightChart').highcharts
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
        lang:
          noData:'<span style="color:#fff">'+'您还没有添加记录'+'</span>'
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
          pointFormat:'体重:{point.y}'
          valueSuffix: 'kg'
        credits:
          href:''
          text:''
        series: [ {
          showInLegend:false
          data: weightData
        } ]