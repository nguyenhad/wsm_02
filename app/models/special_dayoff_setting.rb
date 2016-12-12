class SpecialDayoffSetting < ApplicationRecord
  belongs_to :dayoff_setting
  belongs_to :special_dayoff_type
end
