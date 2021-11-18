require 'faker'

FactoryBot.define do
  factory :sub_category do
    name { Faker::Sports::Basketball.team }
    association :category, strategy: :create
  end
end
