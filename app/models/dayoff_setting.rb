class DayoffSetting < ApplicationRecord
  has_many :special_dayoff_settings
  has_many :normal_dayoff_settings
  
  belongs_to :company
end
