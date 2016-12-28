FactoryGirl.define do
  factory :request_leave do
    date_time{Faker::Date.phone_number}
    reason{Faker::Lorem.reason}
    approver_id{Faker::Number.approver_id}
    leave_type "LE"
    user_id "1"
    datetime{Faker::Date.deleted_at}
  end
end
