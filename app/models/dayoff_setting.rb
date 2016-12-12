class DayoffSetting < ApplicationRecord
  acts_as_paranoid

  has_many :special_dayoff_settings
  has_many :normal_dayoff_settings

  belongs_to :company
end
