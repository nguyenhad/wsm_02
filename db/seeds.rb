password = "123456"
User.create!(
  name:  "admin",
  email: "admin@gmail.com",
  password: password,
  employee_code: "E123456",
  role: 0
)
User.create!(
  name:  "Manager",
  email: "manager@gmail.com",
  password: password,
  employee_code: "E111111",
  role: 1
)

user = User.create! name: "Son Tran", email: "sontd.it@gmail.com",
  password: "123456", created_at: Time.now, updated_at: Time.now,
  employee_code: "E111112"
15.times do |n|
  User.create! name: "User #{n}", email: "user_#{n}@gmail.com",
    password: "123456", created_at: Time.now, updated_at: Time.now,
    employee_code: "MS#{n.to_s.rjust(4, '0')}"
end

5.times do |n|
  Workspace.create! name: "Workspace-#{n}",
    description: "nothing",
    status: 1,
    user_id: user.id,
    company_id: company.id,
    created_at: Time.now,
    updated_at: Time.now
end

Workspace.all.each do |workspace|
  3.times do |n|
    workspace.sections.create! name: "Section #{workspace.id}-#{n}",
      pos_x: (rand(1..5) * 50),
      pos_y: (rand(1..5) * 50),
      width: (rand(1..5) * 50),
      height: (rand(1..5) * 50),
      section_key: "Sec-#{n}",
      created_at: Time.now,
      updated_at: Time.now
  end
end

3.times do |n|
  LocationType.create! name: "Type #{n}",
    color: Faker::Color.hex_color,
    created_at: Time.now,
    updated_at: Time.now
end
