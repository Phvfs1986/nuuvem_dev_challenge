require "rails_helper"

RSpec.describe TransactionImport, type: :model do
  describe "validations" do
    it "is invalid with an incorrect file type" do
      transaction_import = build(:transaction_import, :with_invalid_file)
      expect(transaction_import).to_not be_valid
      expect(transaction_import.errors[:order_file]).to include("has an invalid content type")
    end

    it "is valid with a correct file type" do
      transaction_import = build(:transaction_import, :with_valid_file)
      expect(transaction_import).to be_valid
    end

    it "is invalid with an incorrect file type" do
      invalid_file = Rack::Test::UploadedFile.new(Rails.root.join("spec/fixtures/files/sample.txt"), "text/plain")
      transaction_import = build(:transaction_import, order_file: invalid_file)
      expect(transaction_import).to_not be_valid
      expect(transaction_import.errors[:order_file]).to include("has an invalid content type")
    end
  end

  describe "#filename" do
    it "returns the filename of the attached file" do
      transaction_import = create(:transaction_import, :with_valid_file)
      expect(transaction_import.filename).to eq("example_input.tab")
    end
  end

  describe "#update_file_total_income" do
    it "updates the total income based on transactions" do
      transaction_import = create(:transaction_import, :with_valid_file)
      item = create(:item, price: 10.0)
      create(:transaction, item: item, transaction_import: transaction_import, count: 5)
      transaction_import.update_file_total_income
      expect(transaction_import.file_total_income).to eq(50.0)
    end
  end

  describe "#change_status" do
    it "changes status to a valid value" do
      transaction_import = create(:transaction_import, :with_valid_file)
      transaction_import.change_status(:processing)
      expect(transaction_import.import_status).to eq("processing")
    end

    it "does not change status to an invalid value" do
      transaction_import = create(:transaction_import, :with_valid_file)
      transaction_import.change_status(:invalid_status)
      expect(transaction_import.import_status).to eq("initializing")
    end
  end
end
