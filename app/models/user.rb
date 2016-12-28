require "roo"
class User < ApplicationRecord
  acts_as_paranoid

  attr_accessor :validate_employee_code

  def initialize *args
    self.validate_employee_code ||= true
    super(*args)
  end

  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable

  belongs_to :company
  belongs_to :position

  has_many :time_sheets, through: :user_workspaces
  has_many :project_members, dependent: :destroy
  has_many :user_workspaces, dependent: :destroy
  has_many :workspaces, through: :user_workspaces
  has_many :sections, through: :locations
  has_many :owned_workspaces, class_name: Workspace.name,
    foreign_key: :user_id, dependent: :destroy
  has_many :user_groups
  has_many :request_ots
  has_many :user_leaves
  has_many :user_dayoffs
  has_many :request_offs
  has_many :request_leaves, class_name: RequestLeave.name
  has_many :personal_issues
  has_many :while_lists

  has_one :location

  enum gender: {female: 0, male: 1, other: 2}
  enum role: {admin: 0, manager: 1, staff: 2}

  mount_uploader :avatar, AvatarUploader

  validates :name, presence: true, length: {maximum: Settings.user.name}
  validates :employee_code, presence: true,
    uniqueness: {scope: :company_id, case_sensitive: false},
    if: :validate_employee_code

  scope :recent, ->{order created_at: :desc}
  scope :load_by_company, ->(company_id){where company_id: company_id}

  def is_user? user
    id == user.id
  end

  def is_owner? workspace
    id == workspace.user_id
  end

  class << self
    def import file
      spreadsheet = open_spreadsheet file
      return false unless spreadsheet
      header = spreadsheet.row(Settings.row_excel_header)
      (Settings.row_excel_data_first..spreadsheet.last_row).each do |i|
        row = Hash[[header, spreadsheet.row(i)].transpose]
        store_user row
      end
    end

    def random_password
      chars = (0..9).to_a + ("a".."z").to_a + ("A".."Z").to_a
      chars.sample(8).join
    end

    private
    def store_user data
      user = User.load_by_company(data["company_id"])
              .find_by(employee_code: data["employee_code"]) || User.new
      user.attributes = data.to_hash
      user.password = User.random_password
      user.save
    end
  end
end
