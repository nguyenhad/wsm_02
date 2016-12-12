class RequestOff < ApplicationRecord
  acts_as_paranoid

  has_many :compensations

  belongs_to :special_dayoff_type
end
