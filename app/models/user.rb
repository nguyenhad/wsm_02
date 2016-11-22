class User < ApplicationRecord
  devise :database_authenticatable, :registerable, :recoverable, :rememberable,
    :trackable, :validatable

  has_many :time_sheets, dependent: :destroy
  has_many :project_members, dependent: :destroy

  enum gender: {female: 0, male: 1, other: 2}
  enum role: {admin: 0, manager: 1, staff: 2}

  validates :name, presence: true, length: {maximum: Settings.user.name}

  scope :order_date_desc, ->{order created_at: :desc}
end
