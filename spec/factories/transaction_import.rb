FactoryBot.define do
  factory :transaction_import do
    import_status { :initializing }
    file_total_income { 50.0 }
    uploaded_at { Time.current }

    trait :with_valid_file do
      after(:build) do |transaction_import|
        transaction_import.order_file.attach(
          io: File.open(Rails.root.join("spec/fixtures/files/example_input.tab")),
          filename: "example_input.tab",
          content_type: [:tab]
        )
      end
    end

    trait :with_invalid_file do
      after(:build) do |transaction_import|
        transaction_import.order_file.attach(
          io: File.open(Rails.root.join("spec/fixtures/files/sample.txt")),
          filename: "example.txt",
          content_type: "text/plain"
        )
      end
    end
  end
end
