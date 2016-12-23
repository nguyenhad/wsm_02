myApp.factory('timesheetService', function ($resource) {
  return $resource('/dashboard/time_sheets/:id.json', {id: '@id', month: '@month', year: '@year'}, {
    index: { method: 'GET' },
  });
});
