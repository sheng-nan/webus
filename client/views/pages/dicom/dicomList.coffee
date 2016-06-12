Template.dicomList.helpers
  'dicomList':->
    Laniakea.Collection.DicomStudies.find({pid:this._id})


