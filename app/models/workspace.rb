class Workspace < ApplicationRecord

  has_many :user_workspaces, dependent: :destroy
  has_many :users, through: :user_workspaces
  has_many :sections
  belongs_to :user

  mount_uploader :image, WorkspaceImageUploader

  validates :name, presence: true, length: {maximum: 50}
  validates :description, length: {maximum: 100 }

  after_create :build_user_workspaces

  protected
  def build_user_workspaces
    user_workspaces.create workspace_id: self.id, user_id: self.user_id,
      is_manager: true
  end
end
