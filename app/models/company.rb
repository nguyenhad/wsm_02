class Company < ApplicationRecord
  acts_as_paranoid

  has_many :users
  has_many :holidays
  has_many :company_settings
  has_many :shifts
  has_many :dayoff_settings
  has_many :leave_settings
  has_many :leave_types

  has_one :ot_setting
  has_one :timesheet_settings
end
