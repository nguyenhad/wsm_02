FactoryGirl.define do
  factory :leave_setting do
    limit_times 5
    unit "minute"

    factory :leave_setting_woman1, parent: :leave_setting do
      amount 30
      limit_times 5
      description "Only woman, limit 5 times"
    end

    factory :leave_setting_woman2, parent: :leave_setting do
      amount 60
      limit_times 2
      description "Only woman, limit 2 times"
    end

    factory :leave_setting_woman3, parent: :leave_setting do
      amount 90
      limit_times 1
      description "Only woman, limit 1 times"
    end

    factory :leave_setting_woman4, parent: :leave_setting do
      amount 120
      limit_times 1
      description "Only woman, limit 1 times"
    end

    factory :leave_setting_woman5, parent: :leave_setting do
      amount 150
      limit_times 1
      description "Only woman, limit 1 times"
    end
  end
end
