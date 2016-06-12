
#console.log 'Loading fixture.coffee'

if Meteor.isServer
  if Laniakea.Collection.AddressChina.find({}).count() < 1
    @Laniakea.Seed.AddressChinaSeeding1()
    @Laniakea.Seed.AddressChinaSeeding2()
    @Laniakea.Seed.AddressChinaSeeding3()
    @Laniakea.Seed.AddressChinaSeeding4()

  @Laniakea.Seed.RolesSeeding()
  @Laniakea.Seed.GoodSeeding()
  @Laniakea.Seed.UsKnowledgesSeeding()

  hos =  @Laniakea.Seed.HospitalsSeeding()

  if hos?
    deps = @Laniakea.Seed.DepartmentsSeeding(hos)

    if deps?
      @Laniakea.Seed.AdminUsersSeeding(hos,deps)
      nurs = @Laniakea.Seed.NursesSeeding(hos,deps)
      docs = @Laniakea.Seed.DoctorsSeeding(hos,deps)
      pats = @Laniakea.Seed.PatientsSeeding(hos,deps,docs)
      #lagePatients = @Laniakea.Seed.LargePatienqtsSeeding(hos,deps,docs)
      report = @Laniakea.Seed.MedimgReportsSeeding(deps,docs,pats)

      dicom = @Laniakea.Seed.DicomStudiesSeeding pat for pat in pats

      tags = @Laniakea.Seed.TagsSeeding()

      for pat in pats
        omrs = @Laniakea.Seed.OutMedRecordsSeeding(docs,pat)
        @Laniakea.Seed.HealthRecordsSeeding report,dicom,omrs,pat,tags

      @Laniakea.Seed.ConsultationsSeeding pats,docs
      @Laniakea.Seed.WorklistsSeeding(deps,docs,pats)
      @Laniakea.Seed.UsKnowledgeTreesSeeding(docs)
      drugs = @Laniakea.Seed.DrugSeeding()
  @Laniakea.Seed.GoodSeeding()
  @Laniakea.Seed.GorderSeeding()


#      if drugs? && @Laniakea.Collection.Prescriptions.find().count() is 0
#        @Laniakea.Seed.PrescriptionsSeeding drugs,pat for pat in pats
