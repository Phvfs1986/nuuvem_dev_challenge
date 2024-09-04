require "rails_helper"

RSpec.describe Transactions::FileProcessor, type: :service do
  let(:transaction_import) { create(:transaction_import, :with_valid_file) }

  it "processes the .tab file and creates transactions" do
    expect { described_class.process(transaction_import) }
      .to change { Purchaser.count }.by(4)
      .and change { Item.count }.by(4)
      .and change { Merchant.count }.by(3)
      .and change { Transaction.count }.by(5)

    transaction = Transaction.first
    expect(transaction.purchaser.name).to eq("João Silva")
    expect(transaction.item.description).to eq("Pepperoni Pizza Slice")
    expect(transaction.item.price).to eq(10.0)
    expect(transaction.count).to eq(2)
    expect(transaction.merchant.name).to eq("Bob's Pizza")
    expect(transaction.merchant.address).to eq("987 Fake St")
    expect(transaction.transaction_import).to eq(transaction_import)

    transaction = Transaction.second
    expect(transaction.purchaser.name).to eq("Amy Pond")
    expect(transaction.item.description).to eq("Cute T-Shirt")
    expect(transaction.item.price).to eq(10.0)
    expect(transaction.count).to eq(5)
    expect(transaction.merchant.name).to eq("Tom's Awesome Shop")
    expect(transaction.merchant.address).to eq("456 Unreal Rd")
    expect(transaction.transaction_import).to eq(transaction_import)
  end

  context "when the merchant already has the item" do
    let(:merchant) { create(:merchant, name: "Merchant", address: "987 Fake St") }
    let(:item) { create(:item, description: "Item", price: 10.0) }

    before do
      merchant.items << item
    end

    it "does not duplicate the item for the merchant" do
      expect { described_class.process(transaction_import) }.to change { Transaction.count }.by(5)
      expect(merchant.items.count).to eq(1)
    end
  end
end
