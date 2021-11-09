require 'faker'

FactoryBot.define do
  factory :article do
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'image', 'log.png')) }
    headline { Faker::Sports::Basketball.team }
    caption { Faker::Team.sport }
    alt_picture { Faker::Subscription.subscription_term }
    content { Faker::Lorem.sentence(word_count: 120) }
  end
end
