myApp.factory('timesheetService', function ($resource) {
  return $resource('/dashboard/time_sheets/:id.json', {id: '@id'}, {
    index: { method: 'GET' }
  });
});
