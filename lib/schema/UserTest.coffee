@Laniakea.Seed.LargePatientsSeeding = (hos,deps,docs)->
  console.log("   seed  large patients :", "");
  unless hos?
    return
  unless deps?
    return
  unless docs?
    return
  pats = []
  pids = []
  i = 0
  while i < 1000
    console.log("   insert  i patient :====>>", i);
    pat =
      username:'PAbT'+i.toString()
      password:'123'
      roles:['patient']
      profile:
        name:'PAT'+i.toString()
        sex: '男'
        birthday:'1969-06-04'
        mobile:'13755689566'
        photo: "http://mimas-img.oss-cn-beijing.aliyuncs.com/avatar/6.jpg"
        patient:
          hosids:[hos?[0]._id,hos?[1]._id]
          prmdocid:docs?[0]._id
    pat._id = Accounts.createUser(pat)
    i++
    pats.push pat
    #  console.log "Seed Patient: " + p0.profile.name
    pids.push pat._id
