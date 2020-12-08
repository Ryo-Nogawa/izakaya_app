FactoryBot.define do
  factory :food_comment do
    comment {Faker::Lorem.characters(number: 100)}
    association :user
    association :food
  end
end
