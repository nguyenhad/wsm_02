class TimeSheet < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :employee_code, presence: true,
    length: {maximum: Settings.time_sheet.employee_code}
  validates :staff_name, presence: true,
    length: {maximum: Settings.time_sheet.staff_name}

  scope :order_date_desc, ->{order created_at: :desc}
  scope :search_staff_name,
    ->staff_name {where "staff_name LIKE ?", "%#{staff_name}%"}
  scope :search_employee_code,
    ->employee_code {where "employee_code LIKE ?", "#{employee_code}%"}
end
