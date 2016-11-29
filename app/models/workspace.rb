class Workspace < ApplicationRecord
  has_many :user_workspaces, dependent: :destroy
  has_many :users, through: :user_workspaces
  has_many :sections
  belongs_to :user
end
