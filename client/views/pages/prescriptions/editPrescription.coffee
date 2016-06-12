Template.editPrescription.onCreated ->
  instance = this
  instance.drugItem = new ReactiveVar()
  Session.set('drugs',[])

Template.editPrescription.onRendered ->
  instance = Template.instance()
  instance.autorun ->
    instance.subscribe 'singlePrescription',Session.get('selectedPrescriptionId')

AutoForm.hooks
  editPrescriptionForm:
    onError: (operation, error)->
#      console.log("添加失败" + error)
    onSuccess:(form,result)->
      $("#editPrescriptionModal").modal 'hide'
    onSubmit:(insertDoc,updateDoc,currentDoc)->
      drugs = Session.get('drugs')
      updateDoc.$set.drugs=drugs
      Laniakea.Collection.Prescriptions.update({_id:Session.get('selectedPrescriptionId')},updateDoc)
#      preid = Laniakea.Collection.Prescriptions.update({_id:Session.get('selectedPrescriptionId')},updateDoc)
#      if preid
#        pres =
#          _id:currentDoc._id
#          pat:currentDoc.pat
#          age:currentDoc.age
#          doc:currentDoc.doc
#        Laniakea.Collection.OutMedRecords.update({_id:Session.get('currentoutmedrecord')},{$push:{pres:pres}})
      this.done()

Template.editPrescription.helpers
  'selectedPrescription':->
    selectedpre = Laniakea.Collection.Prescriptions.findOne Session.get('selectedPrescriptionId')
    Session.set('drugs',selectedpre?.drugs)
    return selectedpre
  'drugs':->
    Session.get('drugs')

Template.editPrescription.events
  'input #edit_drug_input':(e,t)->
    e.preventDefault();
    sp = t.$('#edit_drug_input').val()
    Session.set('searchDrug', sp)
    Session.set('index', -1 )
  "click #search_drug":(e,t) ->
    t.$('#drugDiv .search_list').show()
  "keydown #edit_drug_input": (e,t)->
    #上下键获取焦点
    key = e.which
    if $.trim($('#edit_drug_input').val()).length == 0
      return
    text = Session.get('searchDrug')
    if text
      reg = new RegExp(text, 'i')
      hosLen = Laniakea.Collection.DrugStocks.find({'si':reg}).count()
    else
      hosLen = Laniakea.Collection.DrugStocks.find({'si':'&&&'}).count()
    t.$('#drugDiv .search_list').show()
    if key == 38
      ###向上按钮###
      Session.set('index', Session.get('index')-1)
      if Session.get('index') < 0
        Session.set('index', hosLen-1)
      #到顶了，
    else if key == 40
      ###向下按钮###
      Session.set('index', Session.get('index')+1)
      if Session.get('index') >= hosLen
        Session.set('index', 0 )
    #到底了
    if key == 13
      li = $('#drugDiv .search_list li:eq('+Session.get('index')+')')
      drugid = li.attr('selValue')
      t.$('#edit_drugId').val(drugid)
      patName = li[0].innerText
      arr = patName.split(',')
      drugItem={}
      drugItem._id=drugid
      drugItem.name=arr[0]
      drugItem.df=arr[1]
      drugItem.price=arr[2]
      Template.instance().drugItem.set(drugItem)
      t.$("#edit_price").val(arr[2])
      t.$("#drugUnit").val(arr[3])
      t.$('#drug_input').val(patName)
      t.$('.search_list').hide()
      e.preventDefault()
    li = $('#drugDiv .search_list li:eq('+Session.get('index')+')')
    li.css('background', '#f3f3f3').siblings().css 'background', ''
  'click #drugDiv .search_list li':(e,t)->
    drugid = $(e.target).attr('selValue')
    t.$('#edit_drugId').val(drugid)
    patName = $(e.target).text()
    arr = patName.split(',')
    drugItem={}
    drugItem._id=drugid
    drugItem.name=arr[0]
    drugItem.df=arr[1]
    drugItem.price=arr[2]
    Template.instance().drugItem.set(drugItem)
    t.$("#edit_price").val(arr[2])
    t.$("#edit_drugUnit").val(arr[3])
    $('#edit_drug_input').val($(e.target).text())
    $('.search_list').hide()
  'click #addDrugListBtn':(e,t)->
    if $.trim($('#edit_drugId').val()).length == 0

    else
    drugItem = Template.instance().drugItem.get()
    number = t.$("#edit_number").val()
    drugUnit = t.$("#edit_drugUnit").val()
    dosage = t.$("#edit_dosage").val()
    usage = t.$("#edit_usage").val()
    drugItem.number=number
    drugItem.du=drugUnit
    drugItem.dosage=dosage
    drugItem.usage=usage
    ischecked=$('#edit_skinTest').is(':checked');
    if ischecked
      drugItem.skt='是'
    else
      drugItem.skt='否'
    drugs = Session.get('drugs')
    drugs.push(drugItem)
    Session.set('drugs',drugs)
    newDrugs = Session.get('drugs')
    fee=0
    i=0
    while i<newDrugs.length
      fee=fee+Number(newDrugs[i].number)*Number(newDrugs[i].price)
      i++
    t.$('input[data-schema-key=fee]').val(fee)
    t.$("#edit_price").val('')
    t.$('#edit_drug_input').val('')
    t.$("#edit_number").val(1)
    t.$("#edit_drugUnit").val('')
    t.$("#edit_dosage").val('')
    t.$("#edit_usage").val('')
  'click .delDrugListBtn':(e,t)->
    drugs = Session.get('drugs')
    i=0
    while i < drugs.length
      if drugs[i]._id==@_id
        drugs.splice(i,1)
        break
      i++
    Session.set('drugs',drugs)
    newDrugs = Session.get('drugs')
    fee=0
    i=0
    while i<newDrugs.length
      fee=fee+Number(newDrugs[i].number)*Number(newDrugs[i].price)
      i++
    t.$('input[data-schema-key=fee]').val(fee)

