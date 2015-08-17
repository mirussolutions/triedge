require 'faker'

FactoryGirl.define do
  factory :question do
    title {Faker::Lorem.words(5).join(" ")}
    
  end
end
