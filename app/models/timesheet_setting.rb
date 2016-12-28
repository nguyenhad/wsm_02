class TimesheetSetting < ApplicationRecord
  acts_as_paranoid
  serialize :optional_settings, Hash

  belongs_to :workspace

  enum layout_type: {horizontal: 0, vertical: 1}
  enum value_type: {title: 0, serial: 1}

  UNI_KEYS = {name: "name", employee_code: "employee_code"}.freeze

  validates :start_row_data, presence: true
  validates :optional_settings, presence: true, if: :valid_optional_settings

  scope :recent, ->{order created_at: :desc}
  scope :load_by_workspace, ->(workspace_id){where workspace_id: workspace_id}

  private
  def valid_optional_settings
    add_message_vertical_error if vertical?
    add_meassge_date_error if valid_date?
    add_meassge_error_optional_settings_key
  end

  def add_meassge_error_optional_settings_key
    add_meassge_employee_code_error if valid_employee_code?
    add_meassge_name_error if valid_name?
  end

  def add_message_vertical_error
    add_meassge_time_in_error if valid_time_in?
    add_meassge_time_out_error if valid_time_out?
  end

  def add_meassge_date_error
    errors.add(:optional_settings, :blank,
      message: I18n.t("dashboard.timesheet_settings.date_not_blank"))
  end

  def add_meassge_employee_code_error
    errors.add(:optional_settings, :blank,
      message: I18n.t("dashboard.timesheet_settings.employee_code_not_blank"))
  end

  def add_meassge_name_error
    errors.add(:optional_settings, :blank,
      message: I18n.t("dashboard.timesheet_settings.name_not_blank"))
  end

  def add_meassge_time_in_error
    errors.add(:optional_settings, :blank,
      message: I18n.t("dashboard.timesheet_settings.time_in_not_blank"))
  end

  def add_meassge_time_out_error
    errors.add(:optional_settings, :blank,
      message: I18n.t("dashboard.timesheet_settings.time_out_not_blank"))
  end

  def valid_date?
    optional_settings[:date].blank?
  end

  def valid_employee_code?
    optional_settings[:employee_code].blank? &&
      optional_settings[:key] == TimesheetSetting::UNI_KEYS[:employee_code]
  end

  def valid_name?
    optional_settings[:name].blank? &&
      optional_settings[:key] == TimesheetSetting::UNI_KEYS[:name]
  end

  def valid_time_in?
    optional_settings[:time_in].blank?
  end

  def valid_time_out?
    optional_settings[:time_out].blank?
  end
end
