require "rails_helper"

RSpec.describe Transaction, type: :model do
  let(:transaction_import) { create(:transaction_import, :with_valid_file) }
  let(:purchaser) { create(:purchaser) }
  let(:item) { create(:item, price: 10.0) }
  let(:merchant) { create(:merchant) }

  context "associations" do
    it "belongs to a purchaser" do
      transaction = create(:transaction)
      expect(transaction.purchaser).to be_present
    end

    it "belongs to an item" do
      transaction = create(:transaction)
      expect(transaction.item).to be_present
    end

    it "belongs to a merchant" do
      transaction = create(:transaction)
      expect(transaction.merchant).to be_present
    end

    it "belongs to a transaction_import" do
      transaction = create(:transaction)
      expect(transaction.transaction_import).to be_present
    end
  end

  context "validations" do
    it "is valid with all required attributes" do
      transaction = build(:transaction, purchaser:, item:, merchant:, transaction_import:, count: 1)
      expect(transaction).to be_valid
    end

    it "is invalid without a purchaser" do
      transaction = build(:transaction, purchaser: nil)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:purchaser]).to include("must exist")
    end

    it "is invalid without an item" do
      transaction = build(:transaction, item: nil)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:item]).to include("must exist")
    end

    it "is invalid without a merchant" do
      transaction = build(:transaction, merchant: nil)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:merchant]).to include("must exist")
    end

    it "is invalid without a transaction_import" do
      transaction = build(:transaction, transaction_import: nil)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:transaction_import]).to include("must exist")
    end

    it "is invalid with a count less than 1" do
      transaction = build(:transaction, count: 0)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:count]).to include("must be greater than 0")
    end

    it "is invalid with a negative count" do
      transaction = build(:transaction, count: -1)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:count]).to include("must be greater than 0")
    end
  end

  context "calculations" do
    it "calculates the correct total income for multiple transactions" do
      item1 = create(:item, price: 10.0)
      item2 = create(:item, price: 20.0)
      create(:transaction, item: item1, count: 2, transaction_import:)
      create(:transaction, item: item2, count: 3, transaction_import:)

      expect(Transaction.all_time_total_income).to eq(10.0 * 2 + 20.0 * 3)
    end

    it "returns 0 if there are no transactions" do
      expect(Transaction.all_time_total_income).to eq(0.0)
    end
  end
end
