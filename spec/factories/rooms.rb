FactoryBot.define do
  factory :room do
    name       { Faker::Lorem.word }
    is_private { false }
  end
end
