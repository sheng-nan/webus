#console.log 'Loading Roles.coffee'


@Laniakea.Seed.RolesSeeding = ->
  #预添加四个角色
  _roles = ['admin','doctor','patient','qc']

  roles = Roles.getAllRoles().fetch()
  i = 0
  j = 0
  while i<_roles.length
    while j<roles.length
      exist = false
      if(_roles[i]==roles[j].name)
        exist = true
        break
      j++
    if(!exist)
      Roles.createRole(_roles[i])
    i++