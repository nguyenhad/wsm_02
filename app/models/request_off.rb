class RequestOff < ApplicationRecord
  acts_as_paranoid

  belongs_to :special_dayoff_type
  belongs_to :user
end
