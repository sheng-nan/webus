Package.describe({
  name: 'laniakea:worklist',
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
  api.use("mrt:fancybox@0.5.0");

  api.imply("aldeed:collection2");
  api.imply("aldeed:simple-schema");
  api.imply("aldeed:autoform");
  api.imply("aldeed:template-extension");
  api.imply("iron:router");

  api.addFiles(
      [
        'client/worklists/wlDoctorItem.html',
        'client/worklists/wlDoctorItem.coffee',
        'client/worklists/wlExmItem.html',
        'client/worklists/wlExmItem.coffee',
        'client/worklists/worklistAdd.html',
        'client/worklists/worklistAdd.coffee',
        'client/worklists/worklistEdit.html',
        'client/worklists/worklistEdit.coffee',
        'client/worklists/worklistHead.html',
        'client/worklists/worklistHead.coffee',
        'client/worklists/worklistItem.html',
        'client/worklists/worklistItem.coffee',
        'client/worklists/worklists.html',
        'client/worklists/worklists.coffee',
        'stylesheets/worklist.less'
      ],["client"]
  )
});

Package.onTest(function(api) {
  api.use('tinytest');
  api.use('laniakea:worklist');
  api.addFiles('worklist-tests.js');
});
