FactoryBot.define do
  factory :user do
    gimei = Gimei.new
    nickname               { gimei.first.katakana }
    name                   { gimei.kanji }
    name_kana              { gimei.katakana }
    age                    { Faker::Number.between(from: 20, to: 99) }
    phone_number           { Faker::Number.number(digits: 10) }
    email                  { Faker::Internet.free_email }
    password               { 'test2020' }
    password_confirmation  { password }
  end
end
