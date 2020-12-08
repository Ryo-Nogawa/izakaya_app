FactoryBot.define do
  factory :blog do
    title {Faker::Lorem.characters(number: 50)}
    text  {Faker::Lorem.characters(number: 100)}
    image {Faker::Avatar.image(size: '50x50')}
    association :user

    
  end
end
