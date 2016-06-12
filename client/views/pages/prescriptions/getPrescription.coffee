Template.getPrescription.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    instance.subscribe 'singlePrescription',Session.get('selectedPrescriptionId')
Template.getPrescription.helpers
  'selectedPrescription':->
    Laniakea.Collection.Prescriptions.findOne Session.get('selectedPrescriptionId')
  'statePreClass': (state)->
    if state == '已收费'
      return 'prefee'
    if state == '已取药'
      return 'predrug'
Template.getPrescription.events
  "click .btn": (e)->
    if confirm('确认取药?')
      if Meteor.user().profile?
        peo = Meteor.user()?.profile
      else
        if Meteor.user().profile?
          peo = Meteor.user()?.profile
      preid = $('#prescription_id').val()
      if preid
        pre = Laniakea.Collection.Prescriptions.findOne preid
        pre.drugs.forEach (element) ->
          Session.set('DrugID', element._id)
          record =
            opeid: peo._id
            operator: peo.name
            ct: new Date()
            status: '出库'
            money: element.price
            did: element._id
            name: element.name
            df: element.df
            price: element.price
            amount: element.number
            du: element.du
            hosid: pre.hosid
          Meteor.call 'addDrugStockRecord',record, (error,result)->
            if error?
              toastr.error('添加失败')
            if result.success
              stock = Laniakea.Collection.DrugStocks.findOne element._id
              if stock
                total = Number(stock.total) - Number(element.number)
                if total < 0
                  alert('药房库存不足')
                else
                  Laniakea.Collection.DrugStocks.update({_id: stock._id}, {$set: {total: total}},(err,result ) ->
#                    console.log " update DrugStocks err: ", err , "result: ", result
                  )
                  Laniakea.Collection.Prescriptions.update({_id: preid}, {$set: { state: '已取药'}},(err,result ) ->
#                    console.log " update Prescriptions err: ", err , "result: ", result
                  )