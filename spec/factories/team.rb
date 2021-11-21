require 'faker'

FactoryBot.define do
  factory :team do
    name { Faker::WorldCup.team }
    association :sub_category, strategy: :create
  end
end
