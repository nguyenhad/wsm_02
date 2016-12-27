class Workspace < ApplicationRecord
  acts_as_paranoid

  has_many :user_workspaces, dependent: :destroy
  has_many :users, through: :user_workspaces
  has_many :sections

  belongs_to :user
  belongs_to :company

  has_one :timesheet_setting

  mount_uploader :image, WorkspaceImageUploader

  validates :name, presence: true,
    length: {maximum: Settings.validation.workspace.name_max_len}

  validates :description, presence: true,
    length: {maximum: Settings.validation.workspace.des_max_len}
  validates :user, presence: true

  validates :company, presence: true

  validates :name, uniqueness: true, if: :is_present_in_company?

  after_create :build_user_workspaces

  scope :by_company, ->company_id{where company_id: company_id}
  scope :alphabe_name, ->{order name: :asc}

  protected
  def build_user_workspaces
    user_workspaces.create workspace_id: id, user_id: user_id, is_manager: true
  end

  def is_present_in_company?
    workspaces = Workspace.by_company company_id
    return false if workspaces.blank?
    workspaces.pluck(:name).include? name
  end
end
