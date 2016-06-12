Template.addPrescription.onCreated ->
  instance = this
  instance.drugItem = new ReactiveVar()
  Session.set('drugs',[])

AutoForm.hooks
  addPrescriptionForm:
    onError: (operation, error)->
#      console.log("添加失败" + error)
    onSuccess:(form,result)->
#      console.log 'success'
      $("#addPrescriptionModal").modal 'hide'
    onSubmit:(insertDoc,updateDoc,currentDoc)->
#      console.log insertDoc
      drugs = Session.get('drugs')
      insertDoc.drugs=drugs
      preid = Laniakea.Collection.Prescriptions.insert(insertDoc)
      if preid
        pres =
          _id:preid
          pat:insertDoc.pat
          state:'开立'
          createdAt:insertDoc.createdAt
        Laniakea.Collection.OutMedRecords.update({_id:Session.get('currentoutmedrecord')},{$push:{pres:pres}})
      this.done()

Template.addPrescription.helpers
  'drugs':->
    Session.get('drugs')
  'currentoutmedrecord':->
    Laniakea.Collection.OutMedRecords.findOne Session.get('currentoutmedrecord')

Template.addPrescription.events
  'input #drug_input':(e,t)->
    e.preventDefault();
    sp = t.$('#drug_input').val()
    Session.set('searchDrug', sp)
    Session.set('index', -1 )
  "click #search_drug":(e,t) ->
    t.$('#drugDiv .search_list').show()
  "keydown #drug_input": (e,t)->
    #上下键获取焦点
    key = e.which
    if $.trim($('#drug_input').val()).length == 0
      return
    text = Session.get('searchDrug')
    if text
      reg = new RegExp(text, 'i')
      hosLen = Laniakea.Collection.DrugStocks.find({'si':reg}).count()
    else
      hosLen = Laniakea.Collection.DrugStocks.find().count()
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
      t.$('#drugId').val(drugid)
      patName = li[0].innerText
      arr = patName.split(',')
      drugItem={}
      drugItem._id=drugid
      drugItem.name=arr[0]
      drugItem.df=arr[1]
      drugItem.price=arr[2]
      Template.instance().drugItem.set(drugItem)
      t.$("#price").val(arr[2])
      t.$("#drugUnit").val(arr[3])
      t.$('#drug_input').val(patName)
      t.$('.search_list').hide()
      e.preventDefault()
    li = $('#drugDiv .search_list li:eq('+Session.get('index')+')')
    li.css('background', '#f3f3f3').siblings().css 'background', ''
  'click #drugDiv .search_list li':(e,t)->
    drugid = $(e.target).attr('selValue')
    t.$('#drugId').val(drugid)
    patName = $(e.target).text()
    arr = patName.split(',')
    drugItem={}
    drugItem._id=drugid
    drugItem.name=arr[0]
    drugItem.df=arr[1]
    drugItem.price=arr[2]
    Template.instance().drugItem.set(drugItem)
    t.$("#price").val(arr[2])
    t.$("#drugUnit").val(arr[3])
    $('#drug_input').val($(e.target).text())
    $('.search_list').hide()
  'click #addDrugListBtn':(e,t)->
    if $.trim($('#drugId').val()).length == 0

    else
    drugItem = Template.instance().drugItem.get()
    num = t.$("#number").val()
    if num == ''
      num = 0
    number = num
    drugUnit = t.$("#drugUnit").val()
    dosage = t.$("#dosage").val()
    usage = t.$("#usage").val()
    drugItem.number=number
    drugItem.du=drugUnit
    drugItem.dosage=dosage
    drugItem.usage=usage
    ischecked=$('#skinTest').is(':checked');
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
      num = newDrugs[i].number
      if num == ''
        num = 0
      fee=fee+Number(num)*Number(newDrugs[i].price)
      i++
    $('input[data-schema-key=fee]').val(fee)
    t.$("#price").val('')
    t.$('#drug_input').val('')
    t.$("#number").val(1)
    t.$("#drugUnit").val('')
    t.$("#dosage").val('')
    t.$("#usage").val('')
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
      num = newDrugs[i].number
      if num == ''
        num = 0
      fee=fee+Number(num)*Number(newDrugs[i].price)
      i++
    $('input[data-schema-key=fee]').val(fee)

