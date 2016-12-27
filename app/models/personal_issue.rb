class PersonalIssue < ApplicationRecord
  belongs_to :user
  belongs_to :company

  enum unit: [:day, :month, :year]

  ATTR_PARAMS = [
    :division_name,
    :phone_number,
    :address_contact,
    :off_no_salary_from,
    :off_no_salary_to,
    :in_time,
    :unit,
    :reason,
    :user_id,
    :company_id,
    :user_handover,
    :part_handover,
    :work_handover
  ].freeze
end
