class TimesheetSetting < ApplicationRecord
  acts_as_paranoid
  serialize :optional_settings, Hash

  belongs_to :workspace

  enum layout_type: {horizontal: 0, vertical: 1}
  enum value_type: {title: 0, serial: 1}
end
