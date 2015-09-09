require 'faker'

FactoryGirl.define do
  factory :quiz do
    title { Faker::Lorem.words(5).join(" ") }
  end
end
