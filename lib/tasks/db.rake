# encoding: utf-8
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
                       description: "ceo"},

      {name: "DivisonManager",
       description: "dm"},

      {name: "SectionManager",
       description: "sm"},

      {name: "GroupLeader",
       description: "gl"},

      {name: "Leader",
       description: "l"},

      {name: "Staff",
       description: "s"}])

    puts "create request_offs"
    RequestOff.create!([
                         {phone_number: "01255060994",
                          address_contact: "Wall stress",
                          off_have_salary_from: "07/09/2016",
                          off_have_salary_to: "06/10/2016",
                          reason: "Tired",
                          user_id: 5},

     {phone_number: "01255060994",
      address_contact: "American stress",
      off_have_salary_from: "06/09/2016",
      off_have_salary_to: "09/10/2016",
      reason: "Tired",
      user_id: 1},

     {phone_number: "01255060994",
      address_contact: "Newyork stress",
      off_have_salary_from: "15/09/2016",
      off_have_salary_to: "06/10/2016",
      reason: "Tired",
      user_id: 1},

     {phone_number: "01255060994",
      address_contact: "ND stress",
      off_have_salary_from: "06/09/2016",
      off_have_salary_to: "06/10/2016",
      reason: "Tired",
      user_id: 1},

     {phone_number: "01255060994",
      address_contact: "Framgia stress",
      off_have_salary_from: "06/09/2016",
      off_have_salary_to: "06/10/2016",
      reason: "Heache",
      user_id: 5},

     {phone_number: "01255060994",
      address_contact: "Framgia stress",
      off_have_salary_from: "06/09/2016",
      off_have_salary_to: "06/10/2016",
      reason: "Sick",
      user_id: 5},

     {phone_number: "01255060994",
      address_contact: "Framgia stress",
      off_have_salary_from: "06/09/2016",
      off_have_salary_to: "06/10/2016",
      reason: "So Tired",
      user_id: 5}
                       ])

    User.update_all company_id: Company.first.id

    puts "create companies"
    Company.create!(
      [{name: "Framgia Toong",
       parent_id: 7,
       status: 1},

      {name: "Framgia TKC",
       parent_id: 7,
       status: 1},

      {name: "Framgia HCM",
       parent_id: 7,
       status: 1},

      {name: "Framgia DN",
       parent_id: 7,
       status: 1},

      {name: "Framgia HN",
       parent_id: nil,
       status: 1}]
    )

    company_hn = Company.find_by name: "Framgia HN"
    company_toong = Company.find_by name: "Framgia Toong"
    company_tkc = Company.find_by name: "Framgia TKC"
    company_hcm = Company.find_by name: "Framgia HCM"
    company_dn = Company.find_by name: "Framgia DN"

    day_month_year = "%d/%m/%Y"
    month_day_year = "%m/%d/%Y"

    optional_title_hn = {date: "Date", time_in: "Clock In", time_out: "Clock Out",
                         employee_code: "No.", key: "employee_code"}
    optional_serial_hn = {date: 6, time_in: 10, time_out: 11,
                          employee_code: 3, key: "employee_code"}

    optional_title_toong = {date: "Ngày QT", time_in: "Giờ vào",
                            time_out: "Giờ ra", name: "Họ và Tên", key: "name"}
    optional_serial_toong = {date: 2, time_in: 6, time_out: 7,
                             name: 4, key: "name"}

    optional_title_hcm = {date: "Ngày", time_in: "Giờ vào", time_out: "Giờ ra",
                          employee_code: "Mã NV", key: "employee_code"}
    optional_serial_hcm = {date: 5, time_in: 7, time_out: 8,
                           employee_code: 2, key: "employee_code"}

    optional_title_dn = {date: "NGÀY TRONG THÁNG", employee_code: "MÃ NHÂN VIÊN",
                         key: "employee_code"}
    optional_serial_dn = {date: 5, employee_code: 2, key: "employee_code"}

    puts "create timesheet_setting"
    TimesheetSetting.create!(
      [{layout_type: 1,
        value_type: 1,
        optional_settings: optional_serial_hn,
        start_date: "2016-11-26",
        end_date: "2016-12-25",
        start_row_data: 2,
        date_format_type: month_day_year,
        company_id: company_hn.id},

        {layout_type: 1,
         value_type: 1,
         optional_settings: optional_serial_toong,
         start_date: "2016-11-26",
         end_date: "2016-12-25",
         start_row_data: 10,
         date_format_type: month_day_year,
         company_id: company_toong.id},

        {layout_type: 1,
         value_type: 1,
         optional_settings: optional_serial_hn,
         start_date: "2016-11-26",
         end_date: "2016-12-25",
         start_row_data: 2,
         date_format_type: day_month_year,
         company_id: company_tkc.id},

        {layout_type: 1,
         value_type: 1,
         optional_settings: optional_serial_hcm,
         start_date: "2016-11-26",
         end_date: "2016-12-25",
         start_row_data: 4,
         date_format_type: day_month_year,
         company_id: company_hcm.id},

        {layout_type: 0,
         value_type: 1,
         optional_settings: optional_serial_dn,
         start_date: "2016-11-28",
         end_date: "2016-12-14",
         start_row_data: 9,
         date_format_type: day_month_year,
         company_id: company_dn.id}]
    )

    puts "create user manager of Framgia Ha Noi"
    User.create!([
                   {name: "Manager Framgia HN",
                    company_id: company_hn.id,
                    employee_code: "B100001",
                    gender: 0,
                    birthday: "1990-01-01",
                    role: 1,
                    email: "manager.hn@framgia.com",
                    password: "123456"},

      {name: "User1 Framgia HN",
       company_id: company_hn.id,
       employee_code: "B100002",
       gender: 0,
       birthday: "1990-02-02",
       role: 2,
       email: "user1.hn@framgia.com",
       password: "123456"},

      {name: "User2 Framgia HN",
       company_id: company_hn.id,
       employee_code: "B100003",
       gender: 0,
       birthday: "1990-03-03",
       role: 2,
       email: "user2.hn@framgia.com",
       password: "123456"}
                 ])

    puts "create user manager of Framgia Toong"
    User.create!([
                   {name: "Văn Phú Điệp",
                    company_id: company_toong.id,
                    employee_code: "B200001",
                    gender: 0,
                    birthday: "1990-01-01",
                    role: 1,
                    email: "manager@toong.com",
                    password: "123456"},

      {name: "Nguyễn Huy Hùng",
       company_id: company_toong.id,
       employee_code: "B200002",
       gender: 0,
       birthday: "1990-02-02",
       role: 2,
       email: "user1@toong.com",
       password: "123456"},

      {name: "Nguyễn Thị Phương",
       company_id: company_toong.id,
       employee_code: "B200003",
       gender: 0,
       birthday: "1990-03-03",
       role: 2,
       email: "user2@toong.com",
       password: "123456"}
                 ])

    puts "create user manager of Framgia TKC"
    User.create!([
                   {name: "DuongNT",
                    company_id: company_tkc.id,
                    employee_code: "B300001",
                    gender: 0,
                    birthday: "1990-01-01",
                    role: 1,
                    email: "manager@tkc.com",
                    password: "123456"},

      {name: "TrungNT",
       company_id: company_tkc.id,
       employee_code: "B300002",
       gender: 0,
       birthday: "1990-02-02",
       role: 2,
       email: "user1@tkc.com",
       password: "123456"},

      {name: "HaTD",
       company_id: company_tkc.id,
       employee_code: "B300003",
       gender: 0,
       birthday: "1990-03-03",
       role: 2,
       email: "user2@tkc.com",
       password: "123456"}
                 ])

    puts "create user manager of Framgia HCM"
    User.create!([
                   {name: "DuongNT",
                    company_id: company_hcm.id,
                    employee_code: "B400001",
                    gender: 0,
                    birthday: "1990-01-01",
                    role: 1,
                    email: "manager@hcm.com",
                    password: "123456"},

      {name: "TrungNT",
       company_id: company_hcm.id,
       employee_code: "B400002",
       gender: 0,
       birthday: "1990-02-02",
       role: 2,
       email: "user1@hcm.com",
       password: "123456"},

      {name: "HaTD",
       company_id: company_hcm.id,
       employee_code: "B400003",
       gender: 0,
       birthday: "1990-03-03",
       role: 2,
       email: "user2@hcm.com",
       password: "123456"}
                 ])

    puts "create user manager of Framgia DN"
    User.create!([
     {name: "Le Thi Hong Thuy",
      company_id: company_dn.id,
      employee_code: "B500001",
      gender: 0,
      birthday: "1990-01-01",
      role: 1,
      email: "manager@dn.com",
      password: "123456"},

     {name: "Pham Manh Hieu",
      company_id: company_dn.id,
      employee_code: "B500002",
      gender: 0,
      birthday: "1990-02-02",
      role: 2,
      email: "user1@dn.com",
      password: "123456"},

     {name: "Nguyen Thi Quynh Mai",
      company_id: company_dn.id,
      employee_code: "B500003",
      gender: 0,
      birthday: "1990-03-03",
      role: 2,
      email: "user2@dn.com",
      password: "123456"}
    ])

    puts "create timesheets"
    (10..12).each do |month|
      User.all.each do |user|
        30.times do |m|
          TimeSheet.create user_id: user.id , date: "#{m+1}/#{month}/2016", time_in: "8:00", time_out: "17:00", type: ""
        end
      end
    end

    puts "create company_settings"
    Company.all.each do |company|
      CompanySetting.create!(
        company_id: company.id,
        cutoff_date: 5,
        timezone: "Hanoi"
      )
      Shift.create company_id: company.id, time_in: "7:45", time_out: "16:45"
    end

    # puts "create timesheets"
    # (10..12).each do |month|
    #   User.all.each do |user|
    #     30.times do |m|
    #       TimeSheet.create user_id: user.id , date: "#{m+1}/#{month}/2016", time_in: "8:00", time_out: "17:00", type: ""
    #     end
    #   end
    # end
  end
end
