myApp.directive('timesheetDirective', function() {
  return {
    restrict : 'E',
    scope : {
      data : '='
    },
    link : function(scope, element) {
      scope.$watch('data', function(data) {
        if(data){
          $('.content-timesheet').css('opacity', 1);
          $('.loader').addClass("hide");
          $('#table-timesheet').tableHeadFixer({'left' : 1, 'head': true});
        }else{
          $('.content-timesheet').css('opacity', 0.5);
          $('.loader').removeClass("hide");
        }
      }, true);
    }
  }
});
