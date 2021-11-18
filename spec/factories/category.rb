require 'faker'

FactoryBot.define do
  factory :category do
    name { Faker::WorldCup.city }
  end
end
