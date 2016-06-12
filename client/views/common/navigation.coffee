Template.navigation.onRendered ->
  $('#side-menu').metisMenu();
Template.navigation.helpers
  'showQr':->
    if Roles.userIsInRole(Meteor.userId(),'doctor')
      Meteor.user()?.profile.doctor?.qr
    else if Roles.userIsInRole(Meteor.userId(),'nurse')
      hosid = Meteor.user()?.profile?.nurse?.hosid
      if hosid? and Meteor.subscribe('singleHospital',hosid).ready()
        Laniakea.Collection.Hospitals.findOne(hosid)?.qr
  'qrTitle':->
    if Roles.userIsInRole(Meteor.userId(),'doctor')
      '微信扫码添加主治医生'+Meteor.user()?.profile?.name
    else if Roles.userIsInRole(Meteor.userId(),'nurse')
      '微信扫描二维码注册患者'