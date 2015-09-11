require 'faker'

FactoryGirl.define do
  factory :answer do
    title {Faker::Lorem.words(5).join(" ")}
    is_correct {true}
  end
end
