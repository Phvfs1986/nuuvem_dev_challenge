FactoryBot.define do
  factory :item do
    description { "Item" }

    trait :with_price_histories do
      after(:create) do |item|
        create(:price_history, item: item, price: 10.0, effective_at: 1.week.ago)
        create(:price_history, item: item, price: 15.0, effective_at: Time.now)
      end
    end
  end
end
