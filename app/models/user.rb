class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable

  has_many :time_sheets, primary_key: :employee_code,
    foreign_key: :employee_code, dependent: :destroy
  has_many :project_members, dependent: :destroy
  has_many :user_workspaces, dependent: :destroy
  has_many :workspaces, through: :user_workspaces
  has_many :sections, through: :positions
  has_many :owned_workspaces, class_name: Workspace.name,
    foreign_key: :user_id, dependent: :destroy
  has_many :user_groups
  has_many :request_ots

  has_one :position
  
  belongs_to :company

  enum gender: {female: 0, male: 1, other: 2}
  enum role: {admin: 0, manager: 1, staff: 2}

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: {maximum: Settings.user.name}
  validates :employee_code, presence: true, uniqueness: {case_sensitive: false}

  scope :order_date_desc, ->{order created_at: :desc}

  def is_user? user
    self.id == user.id
  end

  def is_owner? workspace
    self.id == workspace.user_id
  end
end
