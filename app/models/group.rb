class Group < ApplicationRecord
  acts_as_paranoid

  has_many :user_groups
  has_many :permissions
end
