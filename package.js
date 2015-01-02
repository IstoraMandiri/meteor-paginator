Package.describe({
  name: 'hitchcott:paginator',
  summary: 'Simple, client-only cursor pagination',
  version: '0.0.1',
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
});