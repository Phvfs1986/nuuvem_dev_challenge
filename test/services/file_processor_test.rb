require "test_helper"

class FileProcessorTest < ActiveSupport::TestCase
  setup do
    @file = Rack::Test::UploadedFile.new(
      Rails.root.join("test", "fixtures", "files", "example_input.tab"),
      "text/tab-separated-values"
    )
  end

  test "processes a file and creates transactions" do
    assert_difference "Transaction.count", 5 do
      total_income = FileProcessor.process(@file)
      assert_in_delta 95.95, total_income, 0.01
    end

    assert Purchaser.exists?(name: "João Silva")
    assert Item.exists?(description: "Pepperoni Pizza Slice")
    assert Merchant.exists?(name: "Bob's Pizza", address: "987 Fake St")

    transaction = Transaction.find_by(purchaser: Purchaser.find_by(name: "João Silva"))
    assert_equal "Pepperoni Pizza Slice", transaction.item.description
    assert_equal "Bob's Pizza", transaction.merchant.name
  end
end
