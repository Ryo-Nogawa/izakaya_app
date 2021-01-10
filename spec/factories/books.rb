FactoryBot.define do
  factory :book do
    reserve_date        { Faker::Date.between(from: 1.day.from_now, to: 1.year.from_now) }
    reserve_time        { '17:00' }
    number_reserve      { Faker::Number.between(from: 2, to: 20) }
    reserve_category_id { Faker::Number.between(from: 2, to: 4) }
    association :user
  end
end
