# frozen_string_literal: true

FactoryBot.define do
  factory :blog do
    title { Faker::Lorem.characters(number: 50) }
    text  { Faker::Lorem.characters(number: 100) }
    image {}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
