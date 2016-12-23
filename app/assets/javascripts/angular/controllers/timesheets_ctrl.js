myApp.controller("TimesheetsCtrl", function($scope, $q, timesheetService) {
  $scope.retrieveTimesheet = timesheetService.index();

  var date = new Date();
  var current_month = date.getMonth();
  var current_year = date.getFullYear();
  function getDaysInMonth(month, year) {
    var date = new Date(year, month, 1);
    var days = [];
    while (date.getMonth() === month) {
      days.push(new Date(date));
      date.setDate(date.getDate() + 1);
    }
    return days;
  }

  $scope.days = getDaysInMonth(current_month, current_year);

  $scope.isEmpty = function (obj) {
    for (var i in obj) if (obj.hasOwnProperty(i)) return false;
    return true;
  };

  $scope.onTimeSet = function (newMonth) {
    month = newMonth.getMonth() + 1;
    year = newMonth.getFullYear();
    $scope.retrieveTimesheet = timesheetService.index({month: month, year: year});
  }
});
