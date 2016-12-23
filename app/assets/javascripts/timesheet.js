$(document).ready(function() {
  $('#confirm-import').click(function(e) {
    e.preventDefault();
    warnBeforeRedirect();
  });

  function warnBeforeRedirect() {
    swal({
      title: I18n.t("are_you_sure"),
      text: I18n.t("confirm_import"),
      type: 'warning',
      showCancelButton: true
    }, function() {
      document.getElementById('import-form').submit();
    });
  }
});
