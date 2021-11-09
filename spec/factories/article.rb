require 'faker'

FactoryBot.define do
  factory :article do
    picture { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'support', 'image', 'photo.jpeg')) }
    headline { Faker::Sports::Basketball.team }
    caption { Faker::Lorem.paragraph(sentence_count: 3) }
    alt_picture { Faker::Subscription.subscription_term }
    content { Faker::Lorem.sentence(word_count: 300) }
  end
end
