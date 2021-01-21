# frozen_string_literal: true

FactoryBot.define do
  factory :message do
    content { Faker::Lorem.characters(number: 100) }
    association :user
  end
end
