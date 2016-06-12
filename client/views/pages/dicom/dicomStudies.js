/**
 * Created by fitark on 15-7-28.
 */
/*var instanceData;
var instanceNum=0;
var currentDicomUrl;

//滚动时调用的展示图片方法
function showNewDicoms(url){
    var element = $('#dicomImage').get(0);
    cornerstone.enable(element);
    cornerstone.loadAndCacheImage(url).then(function(image){
        cornerstone.displayImage(element, image);
        cornerstone.fitToWindow(element);
    });
    //鼠标滚动会产生多余canvas标签，页面会出现滚动条，因此删除，除了第一个之外的canvas标签
    $("canvas")[1].remove();
}

//第一次显示dicom图片时加载的方法
function showInitDicom(url){
    var element = $('#dicomImage').get(0);

    // Listen for changes to the viewport so we can update the text overlays in the corner
    function onViewportUpdated(e) {
        var viewport = cornerstone.getViewport(e.target)
        $('#mrbottomleft').text("WW/WC: " + Math.round(viewport.voi.windowWidth) + "/" + Math.round(viewport.voi.windowCenter));
        $('#mrbottomright').text("Zoom: " + viewport.scale.toFixed(2));
    };

    $('#dicomImage').on("CornerstoneImageRendered", onViewportUpdated);

    cornerstone.enable(element);

    cornerstone.loadImage(url).then(function(image) {
        cornerstone.displayImage(element, image);
        // Fit the image to the viewport window
        cornerstone.fitToWindow(element);
        cornerstoneTools.mouseInput.enable(element);
        cornerstoneTools.mouseWheelInput.enable(element);
        // Enable all tools we want to use with this element
        cornerstoneTools.wwwc.activate(element, 1); // ww/wc is the default tool for left mouse button
        cornerstoneTools.pan.activate(element, 2); // pan is the default tool for middle mouse button
        cornerstoneTools.zoom.activate(element, 4); // zoom is the default tool for right mouse button
        //cornerstoneTools.zoomWheel.activate(element); // zoom is the default tool for middle mouse wheel
        cornerstoneTools.probe.enable(element);
        cornerstoneTools.length.enable(element);
        cornerstoneTools.ellipticalRoi.enable(element);
        cornerstoneTools.rectangleRoi.enable(element);
        cornerstoneTools.angle.enable(element);
        cornerstoneTools.highlight.enable(element);

        activate("#enableWindowLevelTool");

        function activate(id)
        {
            $('button').removeClass('active');
            $(id).addClass('active');
        }
        // helper function used by the tool button handlers to disable the active tool
        // before making a new tool active
        function disableAllTools()
        {
            cornerstoneTools.wwwc.disable(element);
            cornerstoneTools.pan.activate(element, 2); // 2 is middle mouse button
            cornerstoneTools.zoom.activate(element, 4); // 4 is right mouse button
            cornerstoneTools.probe.deactivate(element, 1);
            cornerstoneTools.length.deactivate(element, 1);
            cornerstoneTools.ellipticalRoi.deactivate(element, 1);
            cornerstoneTools.rectangleRoi.deactivate(element, 1);
            cornerstoneTools.angle.deactivate(element, 1);
            cornerstoneTools.highlight.deactivate(element, 1);
            cornerstoneTools.freehand.deactivate(element, 1);
        }

        // Tool button event handlers that set the new active tool
        $('#enableWindowLevelTool').click(function() {
            activate('#enableWindowLevelTool')
            disableAllTools();
            cornerstoneTools.wwwc.activate(element, 1);
        });
        $('#pan').click(function() {
            activate('#pan')
            disableAllTools();
            cornerstoneTools.pan.activate(element, 3); // 3 means left mouse button and middle mouse button
        });
        $('#zoom').click(function() {
            activate('#zoom')
            disableAllTools();
            cornerstoneTools.zoom.activate(element, 5); // 5 means left mouse button and right mouse button
        });
        $('#enableLength').click(function() {
            activate('#enableLength')
            disableAllTools();
            cornerstoneTools.length.activate(element, 1);
        });
        $('#probe').click(function() {
            activate('#probe')
            disableAllTools();
            cornerstoneTools.probe.activate(element, 1);
        });
        $('#circleroi').click(function() {
            activate('#circleroi')
            disableAllTools();
            cornerstoneTools.ellipticalRoi.activate(element, 1);
        });
        $('#rectangleroi').click(function() {
            activate('#rectangleroi')
            disableAllTools();
            cornerstoneTools.rectangleRoi.activate(element, 1);
        });
        $('#angle').click(function () {
            activate('#angle')
            disableAllTools();
            cornerstoneTools.angle.activate(element, 1);
        });
        $('#highlight').click(function() {
            activate('#highlight')
            disableAllTools();
            cornerstoneTools.highlight.activate(element, 1);
        });
        $('#freehand').click(function() {
            activate('#freehand')
            disableAllTools();
            cornerstoneTools.freehand.activate(element, 1);
        });

        $('#invert').click(function (e) {
            var viewport = cornerstone.getViewport(element);
            if (viewport.invert === true) {
                viewport.invert = false;
            } else {
                viewport.invert = true;
            }
            cornerstone.setViewport(element, viewport);
        });
    });
    var config = {
        minScale: 0.25,
        maxScale: 20.0
    };
    cornerstoneTools.zoom.setConfiguration(config);
}

//获取不同存储路径的dicom文件
function getDicomInstanceUrl(parentData,instanceData,index){
    var url;
    if (parentData.store=="orthanc"){
        //orthanc服务器存储路径
        url = OrthancDicomwebUrl+ instanceData[index].ii + '/file';
    }else{
        //阿里云存储路径
        url = AliyunOSSDicom+instanceData[index].ii;
    }
    currentDicomUrl=url;//用于自动缩放显示
    return url;
};

//适应自缩放
function windowResize(dicomInstanceUrl){

    $(window).resize(function () {
        showNewDicoms(currentDicomUrl);
    });
}

function initWindowResize(){
    var height = $(window).height();
    var width = $(window).width()-111;
    var h = $('#listUl').height();
    if(h>height){
        $('#listUl').css('height', height).css('overflow-x','hidden').css('overflow-y','scroll')
    }
    $('#imgBox,.imgBar,.imgCon').css('width',width+'px')
    $('#dicomImage,#dicomBox').css("width",width-2).css('height',height-35)
    $(window).resize(function () {
        var height = $(window).height();
        var width = $(window).width()-111;
        if (h > height) {
            $('#listUl').css('height',height).css('overflow-x', 'hidden').css('overflow-y', 'scroll')
        }
        $('#imgBox,.imgBar,.imgCon').css('width', width + 'px');
        $('#dicomImage,#dicomBox').css("width",width-2).css('height',height-35)
        $('.imgCon').css('height',height-34);
    });
}

Template.dicomStudies.onRendered(function(){

    initWindowResize();

    //初始化显示第一个instance
    var currentData=Template.currentData();
    instanceData=currentData.sl[0].il;
    firstSeriesImageId=instanceData[0].ii;
    var url=getDicomInstanceUrl(currentData,instanceData,0);
    showInitDicom(url);


    //适应自缩放
    windowResize(currentDicomUrl);

    $("#Imagebottomleft").html("<p>Images:"+1+"/"+instanceData.length+"</p>");
    $("#mrtopleft").html("<p>Patient Name:"+currentData.pn+"</p>");
})


Template.dicomStudies.events({
    'click .dicomSeries': function() {
        instanceNum=0;
        instanceData=this.il;
        var parentData=Template.parentData(0);
        var url=getDicomInstanceUrl(parentData,instanceData,0);
        showNewDicoms(url);
        $("#Imagebottomleft").html("<p>Images:1/"+instanceData.length+"</p>");

    },
    'mousewheel  #dicomImage':function(e){
        // Firefox e.originalEvent.detail > 0 scroll back, < 0 scroll forward
        // chrome/safari e.originalEvent.wheelDelta < 0 scroll back, > 0 scroll forward
        if (e.originalEvent.wheelDelta > 0 || e.originalEvent.detail < 0) {
            //    齿轮向前滚动
            instanceNum=instanceNum-1;
        } else {
            //    齿轮向后滚动
            instanceNum=instanceNum+1;
        }

        if(0<=instanceNum && instanceNum<=instanceData.length-1){

            var parentData=Template.parentData(0);
            var url=getDicomInstanceUrl(parentData,instanceData,instanceNum);
            showNewDicoms(url);

            $("#Imagebottomleft").html("<p>Images:"+(instanceNum+1)+"/"+instanceData.length+"</p>");
        }else{
            //instanceNum=-1;
            e.preventDefault();
        }


        //prevent page fom scrolling
        return false;
    }
});*/

