Template.consultation.onRendered ->
  servers =
    iceServers: [
      {url:"stun:stun.anyfirewall.com:3478"}
      {
        url: 'turn:turn.anyfirewall.com:443?transport=tcp'
        credential: 'webrtc'
        username: 'webrtc'
      }
      {
        url: 'turn:turn.bistri.com:80',
        credential: 'homeo',
        username: 'homeo'
      }

    ]
  webrtc = new SimpleWebRTC(
    localVideoEl: 'localStream'
    remoteVideosEl: 'remoteStream'
    autoRequestMedia: true
    peerConnectionConfig:servers
    url:"http://dev.viicare.com:8888"
  )
  roomName=this.data._id
  webrtc.on 'readyToCall', ->
    webrtc.joinRoom roomName
