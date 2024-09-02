require "rails_helper"

RSpec.describe Transaction, type: :model do
  describe "associations" do
    it "belongs to a purchaser" do
      association = described_class.reflect_on_association(:purchaser)
      expect(association.macro).to eq :belongs_to
    end

    it "belongs to an item" do
      association = described_class.reflect_on_association(:item)
      expect(association.macro).to eq :belongs_to
    end

    it "belongs to a merchant" do
      association = described_class.reflect_on_association(:merchant)
      expect(association.macro).to eq :belongs_to
    end

    it "belongs to a transaction_import" do
      association = described_class.reflect_on_association(:transaction_import)
      expect(association.macro).to eq :belongs_to
    end
  end

  describe "validations" do
    let(:transaction) { create(:transaction) }

    it "is valid with all required attributes" do
      expect(transaction).to be_valid
    end

    it "is invalid without purchaser" do
      transaction = build(:transaction, purchaser: nil)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:purchaser]).to include("can't be blank")
    end

    it "is invalid without item" do
      transaction = build(:transaction, item: nil)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:item]).to include("can't be blank")
    end

    it "is invalid without merchant" do
      transaction = build(:transaction, merchant: nil)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:merchant]).to include("can't be blank")
    end

    it "is invalid without transaction_import" do
      transaction = build(:transaction, transaction_import: nil)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:transaction_import]).to include("can't be blank")
    end

    it "is invalid without count" do
      transaction = build(:transaction, count: nil)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:count]).to include("can't be blank")
    end

    it "is invalid with non-numeric count" do
      transaction = build(:transaction, count: "banana")
      expect(transaction).to_not be_valid
      expect(transaction.errors[:count]).to include("is not a number")
    end

    it "is invalid with count less than or equal to 0" do
      transaction = build(:transaction, count: 0)
      expect(transaction).to_not be_valid
      expect(transaction.errors[:count]).to include("must be greater than 0")
    end
  end

  describe ".all_time_total_income" do
    let!(:item1) { create(:item, description: "First", price: 15.0) }
    let!(:item2) { create(:item, description: "Second", price: 30.0) }
    let!(:transaction_import) { create(:transaction_import) }
    let!(:transaction1) { create(:transaction, item: item1, count: 2, transaction_import:) }
    let!(:transaction2) { create(:transaction, item: item2, count: 3, transaction_import:) }

    it "calculates the correct total income" do
      expect(Transaction.all_time_total_income).to eq(120.0)
    end
  end
end
