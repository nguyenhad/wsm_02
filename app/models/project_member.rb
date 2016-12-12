class ProjectMember < ApplicationRecord
  acts_as_paranoid

  belongs_to :user
  belongs_to :project

  enum role_scrum: {product_owner: 0, master: 1, team: 2}

  validates :user, presence: true
  validates :project, presence: true
end
