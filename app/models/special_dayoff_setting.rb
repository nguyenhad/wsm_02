class SpecialDayoffSetting < ApplicationRecord
  acts_as_paranoid

  belongs_to :dayoff_setting
  belongs_to :special_dayoff_type
end
