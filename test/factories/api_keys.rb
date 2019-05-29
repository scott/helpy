FactoryBot.define do
  factory :api_key do
    name { "MyApiKey" }
    user

    trait :expired do
      date_expired { 1.month.ago }
    end
  end
end
