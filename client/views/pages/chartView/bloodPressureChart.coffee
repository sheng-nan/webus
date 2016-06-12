
Template.bloodPressureChart.rendered = ->
  instance = Template.instance()
  instance.patId = new ReactiveVar(this.data._id)

  instance.autorun ->
    hr=Laniakea.Collection.HealthRecords.findOne instance.patId.get()
    bp=hr?.bp
    len=bp?.length
    bphvData = new Array
    bplvData = new Array　
    bphrData=new Array
    xDate=new Array
    if len>0
      #显示最近10天的数据
      if len>10
        min=len-10
      else
        min=0
      for i in [min..len-1]
        time=moment(bp[i].t).format('MM-DD')
        xDate.push [time]
        bphvData.push [bp[i].hv]
        bplvData.push [bp[i].lv]
        bphrData.push [bp[i].hr]

    $('#bloodPreChart').highcharts
        colors:['#ffffff','#ffffff']
        chart:
          type: 'line'
          borderWidth:0
          marginTop: 25
          renderTo: "lineChart"
          backgroundColor:'rgba(255,255,255,0)'
          height: 300
        title: text: ''
        xAxis:
          categories: xDate
          gridLineColor:'rgba(255,255,255,.3)'
          tickColor: 'rgba(255,255,255,.3)'
          lineColor: 'rgba(255,255,255,.3)',
          labels:
            style:
              color: 'rgba(255,255,255,.9)'
        yAxis:
          title: text: ''
          gridLineColor:'rgba(255,255,255,.3)'
          tickColor: 'rgba(255,255,255,.3)'
          lineColor: 'rgba(255,255,255,.3)',
          labels:
            style:
              color: 'rgba(255,255,255,.9)'
        legend:
          enabled: false
        lang:
          noData:'<span style="color:#fff">'+'您还没有添加记录'+'</span>'
        tooltip:
          shared: true
          valueSuffix: ' mmHg'
        credits: enabled: false
        plotOptions:
          areaspline:
            fillOpacity: 0.5

        series: [
          {
            name: '高压'
            data: bphvData
          }
          {
            name: '低压'
            data: bplvData
          }
        ]
