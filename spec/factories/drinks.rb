# frozen_string_literal: true

FactoryBot.define do
  factory :drink do
    drink_category_id { Faker::Number.between(from: 2, to: 11) }
    title             { Faker::Lorem.characters(number: 10) }
    detail            { Faker::Lorem.characters(number: 100) }
    price             { Faker::Number.between(from: 1, to: 9_999_999) }
    image             {}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
