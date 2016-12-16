FactoryGirl.define do
  factory :user do
    sequence(:name){|i| "User#{i}"}
    sequence(:email){|i| "email#{i}@framgia.com"}
    password "123456"
    password_confirmation "123456"
    sequence(:employee_code){|n| "Member#{n.to_s.rjust(4, '0')}"}
    role 2

    factory :manager, parent: :user do
      name "Manager"
      email "manager@example.com"
      role 1
      sequence(:employee_code){|n| "Manager#{n.to_s.rjust(4, '0')}"}
    end
  end
end
