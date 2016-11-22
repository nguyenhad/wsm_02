class Project < ApplicationRecord
  has_many :project_members, dependent: :destroy

  validates :name, presence: true, length: {maximum: Settings.project.name}
end
