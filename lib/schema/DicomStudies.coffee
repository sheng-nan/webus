@Laniakea.Collection.DicomStudies = new Mongo.Collection "dicomStudies"

@Laniakea.Collection.DicomImages = new FS.Collection('dicomimages',
  stores: [
#    new FS.Store.FileSystem('dicomimages', path: '/dfs/lan')
    new FS.Store.FileSystem('dicomThumbs'
      beforeWrite: (fileObj) ->
        {
        extension: 'png'
        type: 'image/png'
        }
      transformWrite: (fileObj, readStream, writeStream) ->
        gm(readStream).resize(60).stream('PNG').pipe writeStream
      ,path: '/dfs/lan/dicom'

    )
  ]
)
#instance
@Laniakea.Schema.DicomInstanceItem = new SimpleSchema
  ii:
    type: String
    label: "InstancesId"#InstancesId
  num:
    type: Number
    label: 'Instances序列号'
  png:
    type: String
    label: 'instance缩略图,DicomImages表的Id'
    optional: true
#Series
@Laniakea.Schema.DicomSeriesItem = new SimpleSchema

  seid:
    type: String
    label: 'id'#seriesId
    optional: true

  sd:
    type: String
    label: '描述' #seriesDescription
    optional: true

  sn:
    type: String
    label: '序列号' #seriesNumber
    optional: true

  il:
    type: [Laniakea.Schema.DicomInstanceItem]
    label: "instanceList" #instanceList


#Studies
@Laniakea.Schema.DicomStudies = new SimpleSchema
  pn:
    type: String
    label: '患者姓名' #patientName
    optional: false

  stid:
    type: String
    label: '序列编号' #studyId
    optional: true

  pid:
    type: String
    label: '患者编号' #patientId
    optional: false

  sd:
    type: Date
    label: '检查日期' #studyDate
    optional: true


  mod:
    type: String
    optional: false
    label: '模态'
    autoform:
      allowedValues: ['US', 'CT', 'MR', 'XR']
      options: ->
        US: 'US'
        CT: 'CT'
        MR: 'MR'
        XR: 'XR'

  des:
    type: String
    label: '检查描述' #studyDescription
    optional: true
  snum:
    type: Number
    label: 'series个数'
    optional: true
  ni:
    type: Number
    label: '图像数' #instance总个数
    optional: true
  sl:
    type: [Laniakea.Schema.DicomSeriesItem]
    label: '序列'#seriesList
  store:
    type: String
    label: '存储位置'
    allowedValues: ["aliyun", "orthanc"]


@Laniakea.Collection.DicomStudies.attachSchema Laniakea.Schema.DicomStudies

# PUBLISH
if Meteor.isServer
  Meteor.publish 'dicomList', (patientid)->
    Laniakea.Collection.DicomStudies.find {'pid': patientid}
  Meteor.publish 'singleDicom', (_id)->
    Laniakea.Collection.DicomStudies.find {'_id': _id}
  Meteor.publish 'dicomimages', (_id) ->
    Laniakea.Collection.DicomImages.find {'_id': _id}

Laniakea.Collection.DicomStudies.allow
  'insert': ->
    if Meteor.userId()
      true
  'update': ->
    if Meteor.userId()
      true
  'remove': ->
    if Meteor.userId()
      true


Laniakea.Collection.DicomImages.allow
  'insert': (userId, project)->
    true
  'update': (userId, project)->
    if Meteor.userId()
      true
  'remove': (userId, project)->
    if Meteor.userId()
      true
  'download': ->
    true
# SEED
@Laniakea.Seed.DicomStudiesSeeding = (pat) ->
  if Laniakea.Collection.DicomStudies.find({}).count() is 0
    console.log '@Laniakea.Seed.DicomStudies...'

  ds =
    pn: pat?.profile.name
    pid: pat?._id
    stid: 'a07e0ed3-18e1d49a-847ff001-dee5d85e-00ebb960'
    mod: 'CT'
    des: 'Pacs'
    snum: 1
    ni: 6
    store: 'orthanc'
    sl: [
      {
        seid: "af87aa07-4f8813a9-bc09b47d-9103ae15-269bb6a4"
        sd: "seriesCT"
        sn: '2'
        il: [
          {"ii": "6c6b0d66-d31e7805-49adaef6-8b79e06f-b8a6e695", 'num': 81},
          {"ii": "9926bde6-719c3707-5ad6468a-329c3ad3-c9efc53d", 'num': 82},
          {"ii": "e21c174b-f6bb4d2a-a97cd2d0-169db202-435904f8", 'num': 83},
          {"ii": "86fae928-35978c48-a11a5b6e-d1e9c9ad-594dd4c6", 'num': 84},
          {"ii": "78e611fa-6530418d-54bba50e-f8c01494-295bbc61", 'num': 85},
          {"ii": "c15f060e-073debb9-887461bb-e2106d2f-cab2d31b", 'num': 86}
        ]
      }

    ]
  ds2 =
    pn: pat?.profile.name
    pid: pat?._id
    stid: '1b8951ec-27e35834-052501a0-8458d58f-098106a5'
    mod: 'CT'
    des: 'Pacs'
    snum: 2
    ni: 12
    store: 'orthanc'
    sl: [
      {
        seid: "3f881bda-fc7de95d-161bac80-79f42665-f43903f2"
        sd: "seriesCT"
        sn: '1'
        il: [
          {"ii": "480ab0f1-a447f5af-00dfc8cc-eb010803-51c026af", 'num': 8},
          {"ii": "f5434103-8ab1cf3f-3ce2f370-59774190-ff043b53", 'num': 9},
          {"ii": "58dd80d8-54b7b901-ea358ac0-dc870e86-bfeb972b", 'num': 10},
          {"ii": "1267d631-4fcf464b-469d1b19-15b404d3-fd0573a1", 'num': 11},
          {"ii": "c3ec5993-88c9a3f7-e7743c3b-4de34769-73d07064", 'num': 12},
          {"ii": "e8bed428-acf06b0d-b4e39383-dce9a830-5bd2ba6b", 'num': 13}
        ]
      },
      {
        seid: "79bd92ea-deadf7ea-939a8f2a-4b983c76-97c6220b"
        sd: "seriesCT"
        sn: '2'
        il: [
          {"ii": "58a506fd-f3dc8cd9-6437152a-583056cc-19566802", 'num': 1},
          {"ii": "a06b6072-1e27656e-3e568608-6c0cc7f9-d3b454e8", 'num': 2},
          {"ii": "83b8d498-0826c27d-f140f4d7-488c921c-5e8b9de6", 'num': 3},
          {"ii": "96ecda1c-0454f236-7912333f-44aee47a-00c5c4b9", 'num': 4},
          {"ii": "6684c99d-d848936f-e44f5d16-c65e85f6-17ee23e2", 'num': 5},
          {"ii": "ca0a28a7-6fdab39a-0636563d-6535279f-04117f81", 'num': 6}
        ]
      }

    ]
  ds3 =
    pn: pat?.profile.name
    pid: pat?._id
    stid: ''
    mod: 'CT'
    des: '云存储'
    snum: 1
    ni: 5
    store: 'aliyun'
    sl: [
      {
        seid: ""
        sd: "seriesCT"
        sn: '2'
        il: [
          {"ii": "dicom/se0/IM0", 'num': 1},
          {"ii": "dicom/se0/IM2", 'num': 6},
          {"ii": "dicom/se0/IM3", 'num': 3},
          {"ii": "dicom/se0/IM4", 'num': 8},
          {"ii": "dicom/se0/IM5", 'num': 5}
        ]
      }

    ]
  ds._id = Laniakea.Collection.DicomStudies.insert(ds)
  ds2._id = Laniakea.Collection.DicomStudies.insert(ds2)
  ds3._id = Laniakea.Collection.DicomStudies.insert(ds3)

  return ds
