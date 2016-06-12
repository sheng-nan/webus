Template.bgChartView.rendered = ->
  instance = Template.instance()
  instance.patId = new ReactiveVar(this.data._id)

  instance.autorun ->
    hr=Laniakea.Collection.HealthRecords.findOne instance.patId.get()
    bbbg=hr?.bbbg
    len=bbbg?.length
    bgData = new Array
    xData=new Array
    if len>0
      #显示最近10天的数据
      if len>10
        min=len-10
      else
        min=0
      for i in [min..len-1]
        time=moment(bbbg[i].t).format('MM-DD')
        xData.push [time]
        bgData.push [bbbg[i].v]
    $('#bgChart').highcharts
      colors:['#ffffff']
      credits: false,
      chart:
        backgroundColor: 'transparent'
        type: 'line'
#        panning: true
#        panKey: 'shift'
        marginTop: 25
#        marginRight: 1
        height: 300
      title:
        text: null
      legend:
        enabled: true
        floating: false
        align: 'right'
        verticalAlign: 'top'
        borderWidth: 0
        x: -15
      plotOptions:
        spline:
          lineWidth: 3
        area:
          fillOpacity: 0.2
      lang:
        noData:'<span style="color:#fff">'+'您还没有添加记录'+'</span>'
      xAxis:
        gridLineColor:'rgba(255,255,255,.3)'
        tickColor: 'rgba(255,255,255,.3)'
        lineColor: 'rgba(255,255,255,.3)',
        categories: xData
        labels:
          style:
            color: 'rgba(255,255,255,.9)'
      yAxis:
        gridLineColor:'rgba(255,255,255,.3)'
        tickColor: 'rgba(255,255,255,.3)'
        lineColor: 'rgba(255,255,255,.3)',
        title: text: null
        plotLines: [ {
          value: 0
          width: 1
          color: '#808080'
        } ]
        labels:
          style:
            color: 'rgba(255,255,255,.9)'
      tooltip:
        pointFormat:'血糖:{point.y}'
        valueSuffix: 'mmol/L'

      series: [ {
        showInLegend:false
        data: bgData
      } ]