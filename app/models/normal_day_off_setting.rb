class NormalDayOffSetting < ApplicationRecord
  acts_as_paranoid

  belongs_to :dayoff_setting
end
