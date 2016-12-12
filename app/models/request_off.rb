class RequestOff < ApplicationRecord
  has_many :compensations
  
  belongs_to :special_dayoff_type
end
