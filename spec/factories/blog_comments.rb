# frozen_string_literal: true

FactoryBot.define do
  factory :blog_comment do
    comment { Faker::Lorem.characters(number: 100) }
    association :user
    association :blog
  end
end
