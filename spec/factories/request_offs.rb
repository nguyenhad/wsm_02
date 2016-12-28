FactoryGirl.define do
  factory :request_off do
    phone_number{Faker::PhoneNumber.phone_number}
    address_contact{Faker::AddressContact.address_contact}
    off_have_salary_from{Faker::OffHaveSalaryFrom.off_have_salary_from}
    off_have_salary_to{Faker::OffHaveSalaryTo.off_have_salary_to}
    reason{Faker::Reason.reason}
    user_id{Faker::UserId.user_id}
  end
end
