FactoryBot.define do
  factory :message do
    association :room
    association :user

    body { Faker::Lorem.sentence }
  end
end
