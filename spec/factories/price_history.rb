FactoryBot.define do
  factory :price_history do
    association :item # Assumes you have a factory for Item

    price { 10.0 }
    effective_at { Time.current }

    trait :with_past_date do
      effective_at { 1.month.ago }
    end

    trait :with_future_date do
      effective_at { 1.month.from_now }
    end

    trait :with_high_price do
      price { 100.0 }
    end

    trait :with_negative_price do
      price { -10.0 }
    end
  end
end
