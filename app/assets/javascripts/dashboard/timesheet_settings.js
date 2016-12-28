$(document).ready(function(){
  load_event();
  $('.key').click(function(){
    toggle();
  });
  $('.layout_type').click(function(){
    get_layout_type(this);
  });
  $('.value_type').click(function(){
    get_value_type(this);
  });
});

function load_event(){
  toggle();
  if($('#timesheet_setting_value_type_serial').is(':checked')){
    value_type_serial();
  }else{
    value_type_title();
  }
  if($('#timesheet_setting_layout_type_horizontal').is(':checked')){
    layout_type_horizontal();
  }
}

function layout_type_horizontal(){
  $('#field_time_out').hide();
  $('#field_time_in').hide();
}

function get_layout_type(layout_type){
  if(layout_type.value === I18n.t("dashboard.form_timesheet_setting.horizontal")){
    layout_type_horizontal();
  }else{
    $('#field_time_out').show();
    $('#field_time_in').show();
  }
}

function value_type_serial() {
  add_content('number', 'col');
}

function value_type_title() {
  add_content('text', 'title');
}

function add_content(_type, _kind) {
  $('#employee_code_label').text(I18n.t('dashboard.form_timesheet_setting.' + _kind + '_employee_code'));
  $('#name_label').text(I18n.t('dashboard.form_timesheet_setting.' + _kind + '_name'));
  $('#date_label').text(I18n.t('dashboard.form_timesheet_setting.' + _kind + '_date'));
  $('#time_in_label').text(I18n.t('dashboard.form_timesheet_setting.' + _kind + '_time_in'));
  $('#time_out_label').text(I18n.t('dashboard.form_timesheet_setting.' + _kind + '_time_out'));
  $('#timesheet_setting_optional_settings_time_in').attr('type', _type);
  $('#timesheet_setting_optional_settings_time_out').attr('type', _type);
  $('#timesheet_setting_optional_settings_date').attr('type',_type);
  $('#timesheet_setting_optional_settings_employee_code').attr('type', _type);
  $('#timesheet_setting_optional_settings_name').attr('type',_type);
}

function get_value_type(value_type){
  if(value_type.value === I18n.t("dashboard.form_timesheet_setting.serial")){
    value_type_serial();
  }else{
    value_type_title();
  }
}

function toggle(){
  if($('#timesheet_setting_optional_settings_key_name').is(':checked')){
    $('.validate_name').show();
    $('.validate_employee_code').hide();
  }else if($('#timesheet_setting_optional_settings_key_employee_code').is(':checked')){
    $('.validate_name').hide();
    $('.validate_employee_code').show();
  }
  else{
    $('#timesheet_setting_optional_settings_key_employee_code').attr('checked', 'checked');
    $('.validate_name').hide();
  }
}
