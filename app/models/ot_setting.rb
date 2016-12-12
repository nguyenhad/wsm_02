class OtSetting < ApplicationRecord
  acts_as_paranoid

  has_many :ot_detail_settings

  belongs_to :company
end
