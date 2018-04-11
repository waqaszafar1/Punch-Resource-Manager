FactoryBot.define do
  factory :client do
    name { Faker::Lorem.word }
  end
end