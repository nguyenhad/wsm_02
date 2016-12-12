class OtDetailSetting < ApplicationRecord
  acts_as_paranoid

  belongs_to :ot_setting
end
