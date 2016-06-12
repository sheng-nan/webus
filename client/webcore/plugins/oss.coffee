@OSS =
  PostObject: (file,key,successCallback)->
    Meteor.call 'OssConfig',(error,result)->
      if error?
        throw new Error('获取阿里云配置失败')
      policy_base64 = result.policy_base64
      sign = result.signature
      keyID = result.access_key_id
      fd = new FormData()
      fd.append('key',key)
      fd.append('Content-Type',file?.type)
      fd.append('OSSAccessKeyId',keyID)
      fd.append('policy',policy_base64)
      fd.append('Signature',sign)
      fd.append('file',file)
      $.ajax({
        type:'POST'
        processData: false
        contentType:false
        url:OSS.config.Endpoint
        data: fd
        success:->
          successCallback()
        error:->
          throw new Meteor.Error('图片上传阿里云失败')
        complete:->

      })
@OSS.config =
  Endpoint:'http://laniakea.oss-cn-beijing.aliyuncs.com'

@dataURItoBlob=(dataURI) ->
  binary = atob(dataURI.split(',')[1]);
  array = [];
  i = 0
  while i < binary.length
    array.push binary.charCodeAt(i)
    i++
  return new Blob([new Uint8Array(array)], {type: 'image/jpeg'});