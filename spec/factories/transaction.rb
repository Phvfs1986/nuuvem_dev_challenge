FactoryBot.define do
  factory :transaction do
    association :purchaser
    association :item
    association :merchant
    association :transaction_import, factory: [:transaction_import, :with_valid_file]
    count { 1 }
  end
end
