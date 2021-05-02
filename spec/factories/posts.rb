FactoryBot.define do
  factory :post do
    title { Faker::Lorem.characters(number: 10) }
  end
end