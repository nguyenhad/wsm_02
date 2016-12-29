$(function () {
  $('#user-list').searchable({
    searchField: '#user-list-search',
    selector: 'li',
    childSelector: '.col-xs-12',
    show: function(elem) {
      elem.slideDown(100);
    },
    hide: function(elem) {
      elem.slideUp(100);
    }
  });
});
