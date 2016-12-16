class SpecialDayoffType < ApplicationRecord
  acts_as_paranoid

  has_many :request_offs
  has_many :special_dayoff_settings
end
