Template.wlDoctorItem.helpers
  'photo':->
    if @.profile?.photo
        @.profile.photo
    else if @.profile?.sex == '女'
        '/img/user-girl-default.png'
    else
        '/img/user-boy-default.png'
Template.wlDoctorItem.events
  "click .photo":(event)->
    $('#wl_docid')?.val(@_id)
    $('#wl_edit_docid')?.val(@_id)
    $('#pat_wl_docid')?.val(@_id)
    $('.photo').removeClass('photo-checked')
    $(event.currentTarget).addClass('photo-checked')
