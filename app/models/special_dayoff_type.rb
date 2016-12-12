class SpecialDayoffType < ApplicationRecord
  acts_as_paranoid

  has_many :request_offs
end
