class Company < ApplicationRecord
  has_many :users
  has_many :holidays
  has_many :company_settings
  has_many :shifts
  has_many :dayoff_settings
  
  has_one :ot_setting
end
