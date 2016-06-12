Template.drugOption.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    selector={}
    selector=
      hosid:Meteor.user()?.profile?.doctor?.hosid
      total:{$gt:0}
    instance.subscribe 'drugStocks', selector,{}

Template.drugOption.helpers
  'drugStocks':->
    text=Session.get('searchDrug')
    if text
      reg = new RegExp(text, 'i')
      Laniakea.Collection.DrugStocks.find({'si':reg})
    else
      Laniakea.Collection.DrugStocks.find({})