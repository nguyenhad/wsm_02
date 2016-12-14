FactoryGirl.define do
  factory :user do
    sequence :name do |i|
      "User#{i}"
    end
    sequence :email do |i|
      "email#{i}@framgia.com"
    end
    password "123456"
    password_confirmation "123456"
    sequence :employee_code do |n|
      "MS#{n.to_s.rjust(4, '0')}"
    end
    role 2

    factory :admin, parent: :user do
      name "Admin"
      email "admin@example.com"
      role 0
    end

    factory :manager, parent: :user do
      name "Manager"
      email "manager@example.com"
      role 1
    end
  end
end
