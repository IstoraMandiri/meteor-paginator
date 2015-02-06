Package.describe({
  name: 'hitchcott:paginator',
  summary: 'Super simple client-only cursor pagination + UI',
  version: '0.0.3',
  git: 'https://github.com/hitchcott/meteor-paginator'
});

Package.onUse(function(api) {

 api.versionsFrom('1.0.2.1');

  api.use([
    'templating',
    'reactive-var',
    'coffeescript'
  ], 'client')

  api.addFiles([
    'paginator.html',
    'paginator.coffee'
  ], 'client');

  api.export('Paginator');

});