FactoryBot.define do
  factory :employee do
    name { Faker::Lorem.word }
    designation 'Software Engineer'
  end
end

