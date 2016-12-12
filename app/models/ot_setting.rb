class OtSetting < ApplicationRecord
  has_many :ot_detail_settings
  
  belongs_to :company
end
