password = "123456"
User.create!(
  name:  "admin",
  email: "admin@gmail.com",
  password: password,
  password_confirmation: password,
  role: 0
)
User.create!(
  name:  "Manager",
  email: "manager@gmail.com",
  password: password,
  password_confirmation: password,
  role: 1
)
