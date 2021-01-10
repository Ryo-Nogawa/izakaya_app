FactoryBot.define do
  factory :drink_comment do
    comment { Faker::Lorem.characters(number: 100) }
    association :user
    association :drink
  end
end
