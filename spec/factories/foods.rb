FactoryBot.define do
  factory :food do
    name Faker::Food.ingredient
    calories ['100', '200', '2000', '324'].sample
  end
end
