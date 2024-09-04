require "rails_helper"

RSpec.describe TransactionImport, type: :model do
  describe "validations" do
    context "with invalid file type" do
      it "is invalid and shows an error" do
        transaction_import = build(:transaction_import, :with_invalid_file)
        expect(transaction_import).to_not be_valid
        expect(transaction_import.errors[:order_file]).to include("has an invalid content type")
      end
    end

    context "with valid file type" do
      it "is valid" do
        transaction_import = build(:transaction_import, :with_valid_file)
        expect(transaction_import).to be_valid
      end
    end
  end

  describe "#filename" do
    it "returns the filename of the attached file" do
      transaction_import = create(:transaction_import, :with_valid_file)
      expect(transaction_import.filename).to eq("example_input.tab")
    end
  end

  describe "#update_file_total_income" do
    it "updates the file_total_income based on associated transactions" do
      transaction_import = create(:transaction_import, :with_valid_file)
      item = create(:item, price: 10.0)
      create(:transaction, item:, transaction_import:, count: 5)

      transaction_import.update_file_total_income
      expect(transaction_import.file_total_income).to eq(50.0)
    end
  end

  describe "#change_status" do
    context "with a valid status" do
      it "changes the status" do
        transaction_import = create(:transaction_import, :with_valid_file)
        transaction_import.change_status(:processing)
        expect(transaction_import.import_status).to eq("processing")
      end
    end

    context "with an invalid status" do
      it "does not change the status" do
        transaction_import = create(:transaction_import, :with_valid_file)
        transaction_import.change_status(:invalid_status)
        expect(transaction_import.import_status).to eq("initializing")
      end
    end
  end
end
