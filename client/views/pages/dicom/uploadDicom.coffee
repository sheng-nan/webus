uploadDicomAliyun=(file,patient)->
  instanceThumbnail=''
  #CollectionFs生成缩略图
  dicomImages=Laniakea.Collection.DicomImages.insert file,(err,image) ->
    instanceThumbnail=image.url({store:'dicomThumbs',brokenIsFine: true,auth:false})
  reader = new FileReader
  file2 = file
  reader.onload = (file) ->
    arrayBuffer = reader.result
    byteArray = new Uint8Array(arrayBuffer)
    dataSet = dicomParser.parseDicom(byteArray)
    patientName = dataSet.string('x00100010')
    modality = dataSet.string('x00080060')
    studyDescription = dataSet.string('x00081030')
    seriesDescription=dataSet.string('x0008103e')
    studyDate = dataSet.string('x00080020')
    studyDate=studyDate.substr(0,4)+'/'+studyDate.substr(4,2)+'/'+studyDate.substr(6,2)
    studyUID = dataSet.string('x0020000d')
    seriesUID = dataSet.string('x0020000e')
    instanceUID = dataSet.string('x00080018')

    #series顺序号
    seriesNum=dataSet.string('x00200011')
    #instance顺序号
    instanceNum=dataSet.string('x00200013')
    # dicomStudy = Laniakea.Collection.DicomStudies.findOne {'pid': patient._id, 'stid': studyUID}
    # series = Laniakea.Collection.DicomStudies.findOne {'pid': patient._id, 'stid': studyUID, 'sl.seid': seriesUID}
    instanceII = 'dicom/' + studyUID + '/' + seriesUID + '/' + file2.name
    instance = Laniakea.Collection.DicomStudies.findOne {'pid': patient._id, 'stid': studyUID, 'sl.seid': seriesUID, 'sl.il.ii': instanceII}
    if instance
      #instance文件已存在
#     $(".dz-filename").append("<div>文件已存在</div>")
    else
      #所属的study不存在

      Meteor.call 'AliYun', (error, result)->
        if error or result != 'TRUE'
#          console.log 'error:' + error
          #阿里云上传失败则保存本地
          fs = Laniakea.Collection.DicomImages.insert file2, (err, fileObj) ->
            return
        else if result is 'TRUE'
          key = 'dicom/' + studyUID + '/' + seriesUID + '/' + file2.name
          successCallback = ->
            studyData =
              pn: patient.profile.name
              pid: patient._id
              stid: studyUID
              mod: modality
              des: studyDescription
              snum:1
              ni: 1
              sd:studyDate
              store: 'aliyun'
              sl: [
                {
                  seid: seriesUID
                  sd: seriesDescription
                  sn: seriesNum
                  il: [
                    {"ii": key,'num':instanceNum,png:instanceThumbnail}

                  ]
                }

              ]
            seriesData =
            {
              seid: seriesUID
              sd: seriesDescription
              sn: seriesNum
              il: [
                {"ii": key,'num':instanceNum,png:instanceThumbnail}

              ]
            }
            instanceData ={"ii": key,'num':instanceNum,png:instanceThumbnail}
            Meteor.call 'addDicomStudy',patient._id,studyUID,seriesUID,instanceUID,instanceII,studyData,seriesData,instanceData
          OSS.PostObject file2, key, successCallback
  reader.readAsArrayBuffer file

Template.uploadDicom.onRendered ->
  instance = Template.instance()
  patient = Template.currentData()
  instance.autorun ->
    instance.subscribe "dicomimages"
  if Meteor.isClient
    Dropzone.autoDiscover = false
    dropz = new Dropzone('form#dropzone', {
        url: '/dropzone/uploadDicom',
        maxFile: 200,
        maxFilesize: 512,
        uploadMultiple: true,
        autoProcessQueue: true,
        addRemoveLinks: true,
#        parallelUploads:10,
        dictDefaultMessage: '<h3>文件上传</h3>',
        dictRemoveFile: "删除文件",
        dictCancelUpload: "取消上传"
        accept:(file,done)->
          uploadDicomAliyun file,patient
          done()
          $(".dz-error-message").remove()
          $(".dz-success-mark").remove()
          $(".dz-error-mark").remove()
        queuecomplete:()->
          $(".dz-remove").html("上传成功")
      }
    )



