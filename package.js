Package.describe({
  name: 'hitchcott:paginator',
  summary: 'Super simple client-only cursor pagination + UI',
  version: '0.1.0',
  git: 'https://github.com/hitchcott/meteor-paginator'
});

Package.onUse(function(api) {

  api.versionsFrom('1.0.2.1');

  // tap:i18n init
  api.use([
    "tap:i18n@1.4.1"
  ], ['client', 'server'])

  api.addFiles("package-tap.i18n", ["client", "server"]);


  // package itself
  api.use([
    'templating',
    'reactive-var',
    'coffeescript'
  ], 'client')

  api.addFiles([
    'paginator.html',
    'paginator.coffee'
  ], 'client');


  // tap:i18n locales
  api.addFiles([
    "i18n/en.i18n.json",
    "i18n/ja.i18n.json"
  ], ["client", "server"]);



  api.export('Paginator');




});