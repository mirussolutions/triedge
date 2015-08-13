require 'faker'

FactoryGirl.define do
  factory :video do
    title {Faker::Name.title}
    description {Faker::Lorem.paragraph}
    video_url {Faker::Name.title}
  end
end
