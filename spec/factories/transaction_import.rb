FactoryBot.define do
  factory :transaction_import do
    after(:build) do |transaction_import|
      transaction_import.order_file.attach(
        io: File.open(Rails.root.join("spec", "fixtures", "files", "example_input.tab")),
        filename: "example_input.tab",
        content_type: "text/tab-separated-values"
      )
    end
  end
end
