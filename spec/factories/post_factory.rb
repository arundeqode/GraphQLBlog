FactoryBot.define do
  factory :post do
    title { Faker::Name.unique.name }
    body { Faker::Internet.email }
  end
end
