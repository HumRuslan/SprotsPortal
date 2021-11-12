require 'faker'

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email(domain: 'example') }
    password { Faker::Internet.password(min_length: 6) }

    trait :confirm do
      confirmed_at { DateTime.now }
    end
  end
end
