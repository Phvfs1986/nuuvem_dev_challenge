FactoryBot.define do
  factory :merchant_item do
    association :merchant
    association :item
  end
end
