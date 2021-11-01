require 'factory_bot_rails'
admin = {
  first_name: "Admin",
  last_name: "Admin",
  email: "admin@gmail.com",
  password: "admin@gmail.com",
  role: 1,
  confirmed_at: Time.now
}

if Rails.env.production?
  User.create(admin)
end

if Rails.env.development?
  User.create(admin)
  20.times do
    FactoryBot.create :user
  end
end


