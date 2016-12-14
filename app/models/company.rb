class Company < ApplicationRecord
  acts_as_paranoid

  has_many :users
  has_many :holidays
  has_many :company_settings
  has_many :shifts
  has_many :dayoff_settings
  has_many :leave_settings

  has_one :ot_setting
  has_one :timesheet_settings

  enum status: {pending: 0, active: 1, block:2}
end
