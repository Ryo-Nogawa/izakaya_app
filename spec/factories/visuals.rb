FactoryBot.define do
  factory :visual do
    visual_category_id { Faker::Number.between(from: 2, to: 3)}
    image {}
    association :user

    after(:build) do |item|
      item.image.attach(io: File.open('public/images/test_image.png'), filename: 'test_image.png')
    end
  end
end
