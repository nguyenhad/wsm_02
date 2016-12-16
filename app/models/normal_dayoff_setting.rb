class NormalDayoffSetting < ApplicationRecord
  acts_as_paranoid

  belongs_to :dayoff_setting

  enum operator: {under: 0, over: 1}
end
