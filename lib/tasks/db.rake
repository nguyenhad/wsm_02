# encoding: utf-8
namespace :db do
  require "factory_girl_rails"
  desc "create database wsm"
  task remake_data: :environment do
    if Rails.env.production?
      puts "Not running in 'Production' task"
    else
      %w(db:drop db:create db:migrate db:test:prepare).each do |task|
        Rake::Task[task].invoke
      end


      puts "create companies"
      company = Company.create!(name: "Framgia Viet Nam", status: 1)
      manager_fr = User.create!({name: "Manager Framgia VN",
                                 company_id: company.id,
                                 employee_code: "B100000",
                                 role: 1,
                                 email: "manager@framgia.com",
                                 password: "123456"})
      company.update!(owner: manager_fr)

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
          company: company
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
      # Company.all.each do |company|
      #   LeaveSetting.create!(
      #     company_id: company.id,
      #     amount: 2,
      #     unit: "hour",
      #     limit_times: 5
      #   )
      # end
      [30, 60, 90, 120].each do |amount|
        FactoryGirl.create :leave_setting, company_id: company.id,
          amount: amount
      end
      FactoryGirl.create :leave_setting_woman1, company_id: company.id
      FactoryGirl.create :leave_setting_woman2, company_id: company.id
      FactoryGirl.create :leave_setting_woman3, company_id: company.id
      FactoryGirl.create :leave_setting_woman4, company_id: company.id
      FactoryGirl.create :leave_setting_woman5, company_id: company.id


      puts "create leave_types"
      LeaveType.create!(
        [
          {name: "IL (M)",
           code: "IL (M)",
           company_id: company.id,
           description: "Inlate morning"},

          {name: "LE",
           code: "LE",
           company_id: company.id,
           description: "Leave early"},

          {name: "LO",
           code: "LO",
           company_id: company.id,
           description: "Leave out"},

          {name: "IL (A)",
           code: "IL (A)",
           company_id: company.id,
           description: "Inlate afternoon"},

          {name: "WO",
           code: "WO",
           company_id: company.id,
           description: "Woman only"}
        ]
      )

      puts "create dayoff_settings"
      DayoffSetting.create!(
        company_id: company.id,
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
      user_id: 5},

     {phone_number: "0984977822",
      address_contact: "Framgia stress",
      off_have_salary_from: "09/09/2016",
      off_have_salary_to: "10/10/2016",
      reason: "Sick",
      user_id: 3},

     {phone_number: "01255060992",
      address_contact: "Framgia stress",
      off_have_salary_from: "06/06/2016",
      off_have_salary_to: "06/11/2016",
      reason: "tomache",
      user_id: 3},

     {phone_number: "01255060995",
      address_contact: "Framgia stress",
      off_have_salary_from: "06/09/2016",
      off_have_salary_to: "06/10/2016",
      reason: "Tired",
      user_id: 3}
    ])

    puts "create user manager of Framgia Ha Noi"
    User.create!([
                   {name: "Manager Framgia HN",
                    company_id: company.id,
                    employee_code: "B100001",
                    gender: 0,
                    birthday: "1990-01-01",
                    role: 1,
                    email: "manager.hn@framgia.com",
                    password: "123456"},

      {name: "User1 Framgia HN",
       company_id: company.id,
       employee_code: "B100002",
       gender: 0,
       birthday: "1990-02-02",
       role: 2,
       email: "user1.hn@framgia.com",
       password: "123456"},

      {name: "User2 Framgia HN",
       company_id: company.id,
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
       employee_code: "B200001",
       gender: 0,
       birthday: "1990-01-01",
       role: 1,
       email: "manager.toong@framgia.com",
       password: "123456"},

      {name: "Nguyễn Huy Hùng",
       company_id: company.id,
       employee_code: "B200002",
       gender: 0,
       birthday: "1990-02-02",
       role: 2,
       email: "user1@toong.com",
       password: "123456"},

      {name: "Nguyễn Thị Phương",
       company_id: company.id,
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
      employee_code: "B300001",
      gender: 0,
      birthday: "1990-01-01",
      role: 1,
      email: "manager.tkc@framgia.com",
      password: "123456"},

      {name: "TrungNT",
       company_id: company.id,
       employee_code: "B300002",
       gender: 0,
       birthday: "1990-02-02",
       role: 2,
       email: "user1@tkc.com",
       password: "123456"},

      {name: "HaTD",
       company_id: company.id,
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
      employee_code: "B400001",
      gender: 0,
      birthday: "1990-01-01",
      role: 1,
      email: "manager.hcm@framgia.com",
      password: "123456"},

      {name: "TrungNT",
       company_id: company.id,
       employee_code: "B400002",
       gender: 0,
       birthday: "1990-02-02",
       role: 2,
       email: "user1@hcm.com",
       password: "123456"},

      {name: "HaTD",
       company_id: company.id,
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
      company_id: company.id,
      employee_code: "B500001",
      gender: 0,
      birthday: "1990-01-01",
      role: 1,
      email: "manager.dn@framgia.com",
      password: "123456"},

     {name: "Pham Manh Hieu",
      company_id: company.id,
      employee_code: "B500002",
      gender: 0,
      birthday: "1990-02-02",
      role: 2,
      email: "user1@dn.com",
      password: "123456"},

     {name: "Nguyen Thi Quynh Mai",
      company_id: company.id,
      employee_code: "B500003",
      gender: 0,
      birthday: "1990-03-03",
      role: 2,
      email: "user2@dn.com",
      password: "123456"}
    ])

    manager_hn = User.find_by(email: "manager.hn@framgia.com") || company.owner
    manager_hcm = User.find_by(email: "manager.hcm@framgia.com") || company.owner
    manager_dn = User.find_by(email: "manager.dn@framgia.com") || company.owner
    manager_toong = User.find_by(email: "manager.toong@framgia.com") || company.owner
    manager_tkc = User.find_by(email: "manager.tkc@framgia.com") || company.owner
    manager_shibuya = User.find_by(email: "manager.shibuya@framgia.com") || company.owner

    puts "create workspaces"
    company.workspaces.create!(
      [{name: "Toong Office",
       description: "Toong Office",
       owner: manager_toong,
       status: 1},

      {name: "Tran Khat Chan",
       description: "Tran Khat Chan",
       owner: manager_tkc,
       status: 1},

      {name: "HCMC Office",
       description: "HCMC Office",
       owner: manager_hcm,
       status: 1},

      {name: "Da Nang Office",
       description: "Da Nang Office",
       owner: manager_dn,
       status: 1},

      {name: "Shibuya Office",
       description: "Shibuya Office",
       owner: manager_shibuya,
       status: 1},

      {name: "Hanoi Office",
       description: "Hanoi Office",
       owner: manager_hn,
       status: 1}]
    )

    hn_office = Workspace.find_by name: "Hanoi Office"
    toong_office = Workspace.find_by name: "Toong Office"
    tkc_office = Workspace.find_by name: "Tran Khat Chan"
    hcm_office = Workspace.find_by name: "HCMC Office"
    dn_office = Workspace.find_by name: "Da Nang Office"

    User.update_all company_id: company.id

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
        start_row_data: 2,
        date_format_type: month_day_year,
        workspace_id: hn_office.id},

        {layout_type: 1,
         value_type: 1,
         optional_settings: optional_serial_toong,
         start_row_data: 10,
         date_format_type: month_day_year,
         workspace_id: toong_office.id},

        {layout_type: 1,
         value_type: 1,
         optional_settings: optional_serial_hn,
         start_row_data: 2,
         date_format_type: day_month_year,
         workspace_id: tkc_office.id},

        {layout_type: 1,
         value_type: 1,
         optional_settings: optional_serial_hcm,
         start_row_data: 4,
         date_format_type: day_month_year,
         workspace_id: hcm_office.id},

        {layout_type: 0,
         value_type: 1,
         optional_settings: optional_serial_dn,
         start_row_data: 9,
         date_format_type: day_month_year,
         workspace_id: dn_office.id}]
    )

    puts "create company_settings"
    Company.all.each do |company|
      CompanySetting.create!(
        company_id: company.id,
        cutoff_date: 5,
        timezone: "Hanoi"
      )
      Shift.create company_id: company.id, time_in: "7:45", time_out: "16:45"
    end

    puts "create request_leaves"
    RequestLeave.create!([
      {leave_from: "2016-12-11 07:45:00", leave_to: "2016-12-11 08:15:00",
        reason: "I have been sick", approver_id: 1, leave_type_id: 1,
        user_id: 1},

      {leave_from: "2016-12-12 16:15:00", leave_to: "2016-12-12 16:45:00",
        reason: "Personal issue", approver_id: 1, leave_type_id: 2,
        user_id: 1},

      {leave_from: "2016-12-13 09:00:00", leave_to: "2016-12-13 09:30:00",
        reason: "Personal issue", approver_id: 1, leave_type_id: 3,
        user_id: 1},

      {leave_from: "2016-12-14 12:45:00", leave_to: "2016-12-14 13:15:00",
        reason: "Personal issue", approver_id: 1, leave_type_id: 4,
        user_id: 1}
      ])

    puts "create compensations"
    Compensation.create!([
      {from: "2016-12-11 16:45:00", to: "2016-12-11 17:15:00", request_leave_id: 1},
      {from: "2016-12-13 17:15:00", to: "2016-12-13 17:45:00", request_leave_id: 2},
      {from: "2016-12-13 16:45:00", to: "2016-12-13 17:15:00", request_leave_id: 3},
      {from: "2016-12-14 16:45:00", to: "2016-12-14 17:15:00", request_leave_id: 4}
    ])

    puts("create user_workspaces Hanoi Office")
    UserWorkspace.create!([
      {workspace_id: hn_office.id,
      user_id: User.find_by(employee_code: "B100001").id,
      is_manager: true},

      {workspace_id: hn_office.id,
      user_id: User.find_by(employee_code: "B100002").id},

      {workspace_id: hn_office.id,
      user_id: User.find_by(employee_code: "B100003").id},
    ])

    puts("create user_workspaces Toong Office")
    UserWorkspace.create!([
      {workspace_id: toong_office.id,
      user_id: User.find_by(employee_code: "B200001").id,
      is_manager: true},

      {workspace_id: toong_office.id,
      user_id: User.find_by(employee_code: "B200002").id},

      {workspace_id: toong_office.id,
      user_id: User.find_by(employee_code: "B200003").id},
    ])

    puts("create user_workspaces Tran Khat Chan")
    UserWorkspace.create!([
      {workspace_id: tkc_office.id,
      user_id: User.find_by(employee_code: "B300001").id,
      is_manager: true},

      {workspace_id: tkc_office.id,
      user_id: User.find_by(employee_code: "B300002").id},

      {workspace_id: tkc_office.id,
      user_id: User.find_by(employee_code: "B300003").id},
    ])

    puts("create user_workspaces HCMC Office")
    UserWorkspace.create!([
      {workspace_id: hcm_office.id,
      user_id: User.find_by(employee_code: "B400001").id,
      is_manager: true},

      {workspace_id: hcm_office.id,
      user_id: User.find_by(employee_code: "B400002").id},

      {workspace_id: hcm_office.id,
      user_id: User.find_by(employee_code: "B400003").id},
    ])

    puts("create user_workspaces Da Nang Office")
    UserWorkspace.create!([
      {workspace_id: dn_office.id,
      user_id: User.find_by(employee_code: "B500001").id,
      is_manager: true},

      {workspace_id: dn_office.id,
      user_id: User.find_by(employee_code: "B500002").id},

      {workspace_id: dn_office.id,
      user_id: User.find_by(employee_code: "B500003").id},
    ])

    # puts "create timesheets"
    # (10..12).each do |month|
    #   UserWorkspace.all.each do |user_workspace|
    #     30.times do |m|
    #       TimeSheet.create user_workspace_id: user_workspace.id , date: "#{m+1}/#{month}/2016", time_in: "8:00", time_out: "17:00", type: ""
    #     end
    #   end
    # end
  end
end
