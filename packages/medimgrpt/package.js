Package.describe({
  name: 'laniakea:medimgrpt',
  version: '0.0.1',
  // Brief, one-line summary of the package.
  summary: '',
  // URL to the Git repository containing the source code for this package.
  git: '',
  // By default, Meteor will default to using README.md for documentation.
  // To avoid submitting documentation, set this field to null.
  documentation: 'README.md'
});

Package.onUse(function(api) {
    api.versionsFrom('1.1.0.3');
    api.use("meteor-platform");
    api.use("accounts-base");
    api.use("accounts-ui-unstyled");
    api.use("less");
    api.use("http");
    api.use("coffeescript");
    api.use("underscore");
    api.use("blaze");
    api.use("jquery");
    api.use("aldeed:autoform@5.3.2");
    api.use("aldeed:collection2@2.3.3");
    api.use("aldeed:simple-schema@1.3.3");
    api.use("iron:router@1.0.9");
    api.use("natestrauser:videojs@4.10.0");
    api.use("mrt:fancybox@0.5.0");

    api.imply("aldeed:collection2");
    api.imply("aldeed:simple-schema");
    api.imply("aldeed:autoform");
    api.imply("aldeed:template-extension");
    api.imply("iron:router");

    api.addFiles(
      [
          'client/medimgreports/auditMedimgReportList.html',
          'client/medimgreports/auditMedimgReportList.coffee',

          'client/medimgreports/cameraCapture.html',
          'client/medimgreports/cameraCapture.coffee',

          'client/medimgreports/captureImgList.html',
          'client/medimgreports/captureImgList.coffee',
          'client/medimgreports/captureImgList.less',

          'client/medimgreports/medimgReportDetail.html',
          'client/medimgreports/medimgReportDetail.coffee',

          'client/medimgreports/medimgReportEdit.html',
          'client/medimgreports/medimgReportEdit.coffee',

          'client/medimgreports/medimgReportEditForm.html',
          'client/medimgreports/medimgReportEditForm.coffee',

          'client/medimgreports/medimgReportItem.html',
          'client/medimgreports/medimgReportitem.coffee',

          'client/medimgreports/medimgReportLogForm.html',
          'client/medimgreports/medimgReportLogForm.coffee',

          'client/medimgreports/medimgReportLogList.html',
          'client/medimgreports/medimgReportLogList.coffee',

          'client/medimgreports/medimgReports.html',
          'client/medimgreports/medimgReports.coffee',
          'client/medimgreports/medimgReports.less',

          'client/medimgreports/modifyMedimgReportList.html',
          'client/medimgreports/modifyMedimgReportList.coffee',

          'client/medimgreports/modifySingleReport.html',
          'client/medimgreports/modifySingleReport.coffee',

          'client/medimgreports/operationMedimgReportItem.html',
          'client/medimgreports/operationMedimgReportItem.coffee',

          'client/medimgreports/printMedimgReportList.html',
          'client/medimgreports/printMedimgReportList.coffee',

          'client/medimgreports/reportPreview.html',
          'client/medimgreports/reportPreview.coffee',
          'client/medimgreports/reportPreview.less',

          'client/medimgreports/uscapture.html',
          'client/medimgreports/uscapture.coffee',
          'client/medimgreports/uscapture.less',

          'client/medimgreports/usKnowledgeNode.html',
          'client/medimgreports/usKnowledgeNode.coffee',

          'client/medimgreports/usKnowledgeNodeCard.html',
          'client/medimgreports/usKnowledgeNodeCard.coffee',

          'client/medimgreports/usReportImage.html',
          'client/medimgreports/usReportImage.coffee',

          'client/medimgreports/usReportImages.html',
          'client/medimgreports/usReportImages.coffee',
          'client/medimgreports/usReportImages.less'

      ],["client"]
    );
    //api.addFiles([
    //    "lib/router.coffee"
    //], ["client", "server"]);
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('laniakea:medimgrpt');
  api.addFiles('medimgrpt-tests.js');
});
