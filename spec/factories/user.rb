require 'faker'

FactoryBot.define do
  factory :user do
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    email { Faker::Internet.email(domain: 'example') }
    password { Faker::Internet.password(min_length: 6) }
    avatar { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'image', 'not-photo.png')) }

    trait :confirm do
      current_sign_in_at { DateTime.now }
      confirmed_at { DateTime.now }
    end
  end
end
