instanceData = ""
instanceNum = 0
currentDicomUrl = ""


#滚动时调用的展示图片方法
showNewDicoms = (url) ->
  element = $('#dicomImage').get(0)
  cornerstone.enable element
  cornerstone.loadAndCacheImage(url).then (image) ->
    cornerstone.displayImage element, image
    cornerstone.fitToWindow element
  #鼠标滚动会产生多余canvas标签，页面会出现滚动条，因此删除，除了第一个之外的canvas标签
  $('canvas')[1].remove()

#  改变WW/WCD成某些特定的值
changeWWWC1 = ->
    element = $('#dicomImage').get(0)
    viewport = cornerstone.getViewport element
    viewport.voi.windowWidth = (110)
    viewport.voi.windowCenter = (35)
    cornerstone.setViewport element, viewport
changeWWWC2 = ->
  element = $('#dicomImage').get(0)
  viewport = cornerstone.getViewport element
  viewport.voi.windowWidth = (320)
  viewport.voi.windowCenter = (50)
  cornerstone.setViewport element, viewport
changeWWWC3 = ->
  element = $('#dicomImage').get(0)
  viewport = cornerstone.getViewport element
  viewport.voi.windowWidth = (400)
  viewport.voi.windowCenter = (80)
  cornerstone.setViewport element, viewport
changeWWWC4 = ->
  element = $('#dicomImage').get(0)
  viewport = cornerstone.getViewport element
  viewport.voi.windowWidth = (2000)
  viewport.voi.windowCenter = (350)
  cornerstone.setViewport element, viewport

changeWWWC5 = ->
  element = $('#dicomImage').get(0)
  viewport = cornerstone.getViewport element
  viewport.voi.windowWidth = (1500)
  viewport.voi.windowCenter = (-500)
  cornerstone.setViewport element, viewport
#第一次显示dicom图片时加载的方法
showInitDicom = (url) ->
  element = $('#dicomImage').get(0)
  # Listen for changes to the viewport so we can update the text overlays in the corner

  onViewportUpdated = (e) ->
    viewport = cornerstone.getViewport(e.target)
    $('#mrbottomleft').text 'WW/WC: ' + Math.round(viewport.voi.windowWidth) + '/' + Math.round(viewport.voi.windowCenter)
    $('#mrbottomright').text 'Zoom: ' + viewport.scale.toFixed(2)
    return

  $('#dicomImage').on 'CornerstoneImageRendered', onViewportUpdated
  cornerstone.enable element
  cornerstone.loadImage(url).then (image) ->

    activate = (id) ->
      $('button').removeClass 'active'
      $(id).addClass 'active'
      return

    # helper function used by the tool button handlers to disable the active tool
    # before making a new tool active

    disableAllTools = ->
      cornerstoneTools.wwwc.disable element
      cornerstoneTools.pan.activate element, 2
      # 2 is middle mouse button
      cornerstoneTools.zoom.activate element, 4
      # 4 is right mouse button
      cornerstoneTools.probe.deactivate element, 1
      cornerstoneTools.length.deactivate element, 1
      cornerstoneTools.ellipticalRoi.deactivate element, 1
      cornerstoneTools.rectangleRoi.deactivate element, 1
      cornerstoneTools.angle.deactivate element, 1
      cornerstoneTools.highlight.deactivate element, 1
      cornerstoneTools.freehand.deactivate element, 1

    cornerstone.displayImage element, image
    # Fit the image to the viewport window
    cornerstone.fitToWindow element
    cornerstoneTools.mouseInput.enable element
    cornerstoneTools.mouseWheelInput.enable element
    # Enable all tools we want to use with this element
    cornerstoneTools.wwwc.activate element, 1
    # ww/wc is the default tool for left mouse button
    cornerstoneTools.pan.activate element, 2
    # pan is the default tool for middle mouse button
    cornerstoneTools.zoom.activate element, 4
    # zoom is the default tool for right mouse button
    #cornerstoneTools.zoomWheel.activate(element); // zoom is the default tool for middle mouse wheel
    cornerstoneTools.probe.enable element
    cornerstoneTools.length.enable element
    cornerstoneTools.ellipticalRoi.enable element
    cornerstoneTools.rectangleRoi.enable element
    cornerstoneTools.angle.enable element
    cornerstoneTools.highlight.enable element
    activate '#enableWindowLevelTool'
    # Tool button event handlers that set the new active tool
    $('#enableWindowLevelTool').click ->
      activate '#enableWindowLevelTool'
      disableAllTools()
      cornerstoneTools.wwwc.activate element, 1
      return
    $('#pan').click ->
      activate '#pan'
      disableAllTools()
      cornerstoneTools.pan.activate element, 3
      # 3 means left mouse button and middle mouse button
      return
    $('#zoom').click ->
      activate '#zoom'
      disableAllTools()
      cornerstoneTools.zoom.activate element, 5
      # 5 means left mouse button and right mouse button
      return
    $('#enableLength').click ->
      activate '#enableLength'
      disableAllTools()
      cornerstoneTools.length.activate element, 1
      return
    $('#probe').click ->
      activate '#probe'
      disableAllTools()
      cornerstoneTools.probe.activate element, 1
      return
    $('#circleroi').click ->
      activate '#circleroi'
      disableAllTools()
      cornerstoneTools.ellipticalRoi.activate element, 1
      return
    $('#rectangleroi').click ->
      activate '#rectangleroi'
      disableAllTools()
      cornerstoneTools.rectangleRoi.activate element, 1
      return
    $('#angle').click ->
      activate '#angle'
      disableAllTools()
      cornerstoneTools.angle.activate element, 1
      return
    $('#highlight').click ->
      activate '#highlight'
      disableAllTools()
      cornerstoneTools.highlight.activate element, 1
      return
    $('#freehand').click ->
      activate '#freehand'
      disableAllTools()
      cornerstoneTools.freehand.activate element, 1
      return
    $('#invert').click (e) ->
      activate '#invert'
      viewport = cornerstone.getViewport(element)
      if viewport.invert == true
        viewport.invert = false
      else
        viewport.invert = true
      cornerstone.setViewport element, viewport
    return
    changeWWWC element

  config =
    minScale: 0.25
    maxScale: 20.0
  cornerstoneTools.zoom.setConfiguration config
  return

#获取不同存储路径的dicom文件

getDicomInstanceUrl = (parentData, instanceData, index) ->
  url = ""
  if parentData.store == 'orthanc'
#orthanc服务器存储路径
    url = OrthancDicomwebUrl + instanceData[index].ii + '/file'
  else
#阿里云存储路径
    url = AliyunOSSDicom + instanceData[index].ii
  currentDicomUrl = url
  #用于自动缩放显示
  url

#适应自缩放
windowResize = (dicomInstanceUrl) ->
  $(window).resize ->
    showNewDicoms currentDicomUrl

initWindowResize = ->
  height = $(window).height() - 85
  width = $(window).width() - 111
  h = $('#listUl').height()
  if h > height + 30
    $('#listUl').css('height', height + 30).css('overflow-x', 'hidden').css 'overflow-y', 'scroll'
  $('#imgBox,.imgBar,.imgCon').css 'width', width + 'px'
  $('#dicomImage,#dicomBox').css('width', width - 2).css 'height', height - 2
  $(window).resize ->
    `var width`
    `var height`
    height = $(window).height() - 85
    width = $(window).width() - 111
    if h > height + 30
      $('#listUl').css('height', height + 30).css('overflow-x', 'hidden').css 'overflow-y', 'scroll'
    $('#imgBox,.imgBar,.imgCon').css 'width', width + 'px'
    $('#dicomImage,#dicomBox').css('width', width - 2).css 'height', height - 2

#按照num进行数组排序
sortByAttributeofArray = (propertyName) ->
  (object1, object2) ->
    value1 = object1[propertyName]
    value2 = object2[propertyName]
    if value1 < value2
      -1
    else if value1 > value2
      1
    else
      0
Template.dicomStudies.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    initWindowResize()
    #初始化显示第一个instance
    currentData = Template.currentData()
    instanceData = currentData.sl[0].il
    instanceData.sort(sortByAttributeofArray("num"));
    firstSeriesImageId = instanceData[0].ii
    url = getDicomInstanceUrl(currentData, instanceData, 0)
    showInitDicom url

    #适应自缩放
    windowResize currentDicomUrl
    $('#Imagebottomleft').html '<p>Images:' + 1 + '/' + instanceData.length + '</p>'
    $('#mrtopleft').html '<p>Patient Name:' + currentData.pn + '</p>'

Template.dicomStudies.events

  'click .dicomSeries': ->
    instanceNum = 0
    instanceData = this.il
    #按照num进行数组排序
    instanceData.sort(sortByAttributeofArray("num"));
    parentData = Template.parentData(0)
    url = getDicomInstanceUrl(parentData, instanceData, 0)
    showNewDicoms url
    $('#Imagebottomleft').html '<p>Images:1/' + instanceData.length + '</p>'

  'click #danao':->
    changeWWWC1()

  'click #fuqiang':->
    changeWWWC2()

  'click #zongge':->
    changeWWWC3()

  'click #gutou':->
    changeWWWC4()

  'click #feibu':->
    changeWWWC5()
  'mousewheel  #dicomImage': (e) ->
# Firefox e.originalEvent.detail > 0 scroll back, < 0 scroll forward
# chrome/safari e.originalEvent.wheelDelta < 0 scroll back, > 0 scroll forward
    if e.originalEvent.wheelDelta > 0 or e.originalEvent.detail < 0
#    齿轮向前滚动
      instanceNum = instanceNum - 1
    else
#    齿轮向后滚动
      instanceNum = instanceNum + 1
    if 0 <= instanceNum and instanceNum <= instanceData.length - 1
      parentData = Template.parentData(0)
      url = getDicomInstanceUrl(parentData, instanceData, instanceNum)
      showNewDicoms url
      $('#Imagebottomleft').html '<p>Images:' + (instanceNum + 1) + '/' + instanceData.length + '</p>'
    else
      e.preventDefault()
    #prevent page fom scrolling
    false


Template.dicomStudies.helpers
  seriesList:->
    #按照num进行数组排序
    series=this.sl.sort(sortByAttributeofArray("sn"))
    series
  getFirstInstanceUrl:->
#    OrthancUrl+this.il[0].ii+"/preview"

    instanceData2=this.il
    instanceData2.sort(sortByAttributeofArray("num"))
    instanceThumb=instanceData2[0]?.png
    instanceThumb
#    Meteor.subscribe 'dicomimages',dicomimagesId
#    src=Laniakea.Collection.DicomImages.findOne(dicomimagesId).url({store:'dicomThumbs',brokenIsFine: true,auth:false})
#    src
#    imagesrc=src+"&store=dicomThumbs"