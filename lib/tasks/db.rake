namespace :db do
  require "factory_girl_rails"
  desc "create database wsm"
  task remake_data: :environment do
    if Rails.env.production?
      puts "Not running in 'Production' task"
    else
      %w(db:drop db:create db:migrate db:seed db:test:prepare).each do |task|
        Rake::Task[task].invoke
      end

      puts "create companies"
      Company.create!(
        [
          {name: "Framgia Viet Nam",
           parent_id: nil,
           status: 1},

          {name: "Framgia Ha Noi",
           parent_id: 0,
           status: 1}
        ]
      )

      puts "create users"
      [
        "Nguyen Van Tran Anh B",
        "Nguyen Thi Huong",
        "Tran Duc Quoc",
        "Nguyen Thi Thu Ha D",
        "Nguyen Thi Phuong B",
        "Pham Van Chien",
        "Do Thi Diem Thao",
        "Nguyen Thi Hong",
        "Nguyen Huu Giap",
        "Le Quang Tin",
        "Nguyen Binh Dieu",
        "Hoang Nhac Trung",
        "Chu Anh Tuan",
        "Doan Thi Phuong Thao"
      ].each do |name|
        FactoryGirl.create :user, name: name,
          email: "#{name.split(' ').join('.').downcase}@framgia.com",
          company: Company.first
      end

      Shift.create company: Company.first, time_in: "8:00", time_out: "17:00"
      FactoryGirl.create(:manager)

      # puts "create workspace"
      # 5.times do |n|
      #   Workspace.create! name: "Workspace-#{n}",
      #     description: "nothing",
      #     status: 1,
      #     user_id: 1,
      #     created_at: Time.now,
      #     updated_at: Time.now
      # end

      # puts "create sections"
      # Workspace.all.each do |workspace|
      #   3.times do |n|
      #     w = workspace.sections.create! name: "Section #{workspace.id}-#{n}",
      #       pos_x: (rand(1..5) * 50),
      #       pos_y: (rand(1..5) * 50),
      #       width: (rand(1..5) * 50),
      #       height: (rand(1..5) * 50),
      #       section_key: "Sec-#{n}",
      #       created_at: Time.now,
      #       updated_at: Time.now
      #   end
      # end

      # puts "create location_types"
      # 3.times do |n|
      #   LocationType.create! name: "Type #{n}",
      #     color: Faker::Color.hex_color,
      #     created_at: Time.now,
      #     updated_at: Time.now
      # end

      puts "create leave_settings"
      Company.all.each do |company|
        LeaveSetting.create!(
          company_id: company.id,
          amount: 2,
          unit: "hour",
          limit_times: 5
        )
      end

      puts "create leave_types"
      LeaveType.create!(
        [
          {name: "IL (M)",
           code: "IL (M)",
           description: "Inlate morning"},

          {name: "LE",
           code: "LE",
           description: "Leave early"},

          {name: "LO",
           code: "LO",
           description: "Leave out"},

          {name: "IL (A)",
           code: "IL (A)",
           description: "Inlate afternoon"}
        ]
      )

      puts "create leave_settings"
      LeaveSetting.create!(
        company_id: 2,
        amount: 2,
        unit: "hour",
        limit_times: 5
      )

      puts "create dayoff_settings"
      DayoffSetting.create!(
        company_id: 2,
        limmit_loop_year: 1,
        limmit_loop_day: 20
      )

      puts "create normal_dayoff_settings"
      NormalDayoffSetting.create!(
        [
          {operator: 1,
           years: 1,
           count_day: 12,
           dayoff_setting_id: 1},

          {operator: 0,
           years: 5,
           count_day: 13,
           dayoff_setting_id: 1}
        ]
      )

      puts "create special_dayoff_types"
      SpecialDayoffType.create!(
        [
          {name: "Leave of absent",
           description: "This is leave yearly of every official staff over one year.
            This have paid leave, no allowances"},

          {name: "Married leave",
           description: "Married leave have three days, full salary"},

          {name: "Married of his children leave",
           description: "Married of his children leave, have 1 day full salary"},

          {name: "Antenatal care leave time off",
           description: "Antenatal care leave time off. The company not paid,
            Social security befenits"},

          {name: "Miscarriage leave",
           description: "Miscarriage leave. The company not paid, Social security befenits"},

          {name: "Maternity leave",
           description: "Maternity leave. The company not paid, Social security befenits"},

          {name: "Sick leave",
           description: "Sick leave. The company not paid, Social security befenits"},

          {name: "WO",
           description: "Woman only"}
        ]
      )
    end

    puts "create positions"
    Position.create!([{name: "CEO",
      description: "ceo"
      },

      {name: "DivisonManager",
      description: "dm"
      },

      {name: "SectionManager",
      description: "sm"
      },

      {name: "GroupLeader",
      description: "gl"
      },

      {name: "Leader",
      description: "l"
      },

      {name: "Staff",
      description: "s"}
    ])

    puts "create request_offs"
     RequestOff.create!([
      { phone_number: "01255060994",
        address_contact: "Wall stress",
        off_have_salary_from: "07/09/2016",
        off_have_salary_to: "06/10/2016",
        reason: "Tired",
        user_id: 5 },

      { phone_number: "01255060994",
        address_contact: "American stress",
        off_have_salary_from: "06/09/2016",
        off_have_salary_to: "09/10/2016",
        reason: "Tired",
        user_id: 5 },

      { phone_number: "01255060994",
        address_contact: "Newyork stress",
        off_have_salary_from: "15/09/2016",
        off_have_salary_to: "06/10/2016",
        reason: "Tired",
        user_id: 5 },

      { phone_number: "01255060994",
        address_contact: "ND stress",
        off_have_salary_from: "06/09/2016",
        off_have_salary_to: "06/10/2016",
        reason: "Tired",
        user_id: 1 },

      { phone_number: "01255060994",
        address_contact: "Framgia stress",
        off_have_salary_from: "06/09/2016",
        off_have_salary_to: "06/10/2016",
        reason: "Heache",
        user_id: 5 },

      { phone_number: "01255060994",
        address_contact: "Framgia stress",
        off_have_salary_from: "06/09/2016",
        off_have_salary_to: "06/10/2016",
        reason: "Sick",
        user_id: 5 },

      { phone_number: "01255060994",
        address_contact: "Framgia stress",
        off_have_salary_from: "06/09/2016",
        off_have_salary_to: "06/10/2016",
        reason: "So Tired",
        user_id: 5 }
    ])

    puts "create company_settings"
    Company.all.each do |company|
      CompanySetting.create!(
        company_id: company.id,
        cutoff_date: 5,
        timezone: "Hanoi"
      )
    end

    User.update_all company_id: Company.first.id

    puts "create timesheets"
    (10..12).each do |month|
      User.all.each do |user|
        30.times do |m|
          TimeSheet.create user_id: user.id , date: "#{m+1}/#{month}/2016", time_in: "8:00", time_out: "17:00", type: ""
        end
      end
    end
  end
end
