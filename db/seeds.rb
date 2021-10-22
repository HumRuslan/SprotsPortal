20.times do |n|
  if n.even?
    User.create!(
      first_name: "UserName #{n}",
      last_name: "UserLastName #{n}",
      email: "user#{n}@gmail.com",
      password: "Password@#{n}",
      password_confirmation: "Password@#{n}"
    )
  else
    User.create!(
      email: "user#{n}@gmail.com",
      password: "Password@#{n}",
      password_confirmation: "Password@#{n}"
    )
  end
end