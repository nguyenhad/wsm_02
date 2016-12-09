$(document).ready(function() {
  var Login = function() {
  return {
    init: function() {
      /* Login form - Initialize Validation */
      $('#new_user').validate({
        errorClass: 'help-block animation-slideDown', // You can change the animation class for a different entrance animation - check animations page
        errorElement: 'div',
        errorPlacement: function(error, e) {
          e.parents('.form-group > div').append(error);
        },
        highlight: function(e) {
          $(e).closest('.form-group').removeClass('has-success has-error').addClass('has-error');
          $(e).closest('.help-block').remove();
        },
        success: function(e) {
          e.closest('.form-group').removeClass('has-success has-error');
          e.closest('.help-block').remove();
        },
        rules: {
          'user[name]': {
            required: true,
            minlength: 2
          },
          'user[email]': {
            required: true,
            email: true
          },
          'user[employee_code]': {
            required: true,
            maxlength: 7
          },
          'user[password]': {
            required: true,
            minlength: 6
          },
          'user[password_confirmation]': {
            required: true,
            minlength: 6,
            equalTo: '#user_password'
            }
          }
        });
      }
    };
  }();

  Login.init();
});
