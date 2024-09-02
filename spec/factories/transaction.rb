FactoryBot.define do
  factory :transaction do
    association :purchaser
    association :item
    association :merchant
    association :transaction_import
    count { 1 }
  end
end
