class Company < ApplicationRecord
  acts_as_paranoid

  has_many :users, foreign_key: :company_id
  has_many :holidays
  has_many :dayoff_settings
  has_many :workspaces
  has_many :white_lists

  has_one :ot_setting
  has_one :leave_setting
  has_one :shift
  has_one :company_setting

  belongs_to :owner, class_name: User.name

  enum status: {pending: 0, active: 1, block: 2}

  delegate :timezone, to: :company_setting, prefix: :company_setting

  accepts_nested_attributes_for :company_setting

  scope :recent, ->{order created_at: :desc}

  scope :parent_company, ->user_id do
    where "id IN(select id from companies
      where parent_id = (select company_id from users where id = ?)
      or id = (select company_id from users where id = ?)
    )", user_id, user_id
  end
end
