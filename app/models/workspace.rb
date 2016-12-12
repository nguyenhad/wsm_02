class Workspace < ApplicationRecord
  acts_as_paranoid

  has_many :user_workspaces, dependent: :destroy
  has_many :users, through: :user_workspaces
  has_many :sections

  belongs_to :user

  mount_uploader :image, WorkspaceImageUploader

  validates :name, presence: true,
    length: {maximum: Settings.validation.workspace.name_max_len}
  validates :description, presence: true,
    length: {maximum: Settings.validation.workspace.des_max_len}
  validates :user, presence: true

  after_create :build_user_workspaces

  protected
  def build_user_workspaces
    user_workspaces.create workspace_id: self.id, user_id: self.user_id,
      is_manager: true
  end
end
