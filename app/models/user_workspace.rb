class UserWorkspace < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :workspace
end
