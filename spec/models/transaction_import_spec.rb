require "rails_helper"

RSpec.describe TransactionImport, type: :model do
  describe "validations" do
    it "is valid with a file attached" do
      transaction_import = build(:transaction_import)
      expect(transaction_import).to be_valid
    end

    it "is invalid without an attached file" do
      transaction_import = build(:transaction_import, order_file: nil)
      expect(transaction_import).to_not be_valid
      expect(transaction_import.errors[:order_file]).to include("can't be blank")
    end
  end

  describe "#filename" do
    it "returns the filename of the attached order_file" do
      transaction_import = create(:transaction_import)
      expect(transaction_import.filename).to eq("example_input.tab")
    end
  end

  describe "#update_file_total_income" do
    it "calculates and updates the file_total_income" do
      item = create(:item, price: 10.0)
      transaction_import = create(:transaction_import)
      create(:transaction, item: item, count: 2, transaction_import: transaction_import)
      create(:transaction, item: item, count: 3, transaction_import: transaction_import)

      transaction_import.update_file_total_income
      transaction_import.reload

      expect(transaction_import.file_total_income).to eq(50.0) # Adjust based on actual test data
    end
  end
end
