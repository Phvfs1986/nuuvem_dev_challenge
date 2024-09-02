# spec/models/transaction_spec.rb
require "rails_helper"

RSpec.describe Transaction, type: :model do
  let(:purchaser) { Purchaser.create(name: "John Doe") }
  let(:item) { Item.create(description: "Item 1", price: 10.0) }
  let(:merchant) { Merchant.create(name: "Merchant 1", address: "123 Street") }
  let(:file_upload) { FileUpload.create(uploaded_at: Time.current) }

  it "is valid with a purchaser, item, merchant, file_upload, and count" do
    transaction = Transaction.new(
      purchaser:,
      item:,
      merchant:,
      file_upload:,
      count: 2
    )
    expect(transaction).to be_valid
  end

  it "is invalid without a purchaser" do
    transaction = Transaction.new(
      purchaser: nil,
      item:,
      merchant:,
      file_upload:,
      count: 2
    )
    expect(transaction).not_to be_valid
  end

  it "is invalid without an item" do
    transaction = Transaction.new(
      purchaser:,
      item: nil,
      merchant:,
      file_upload:,
      count: 2
    )
    expect(transaction).not_to be_valid
  end

  it "is invalid without a merchant" do
    transaction = Transaction.new(
      purchaser:,
      item:,
      merchant: nil,
      file_upload:,
      count: 2
    )
    expect(transaction).not_to be_valid
  end

  it "is invalid without a file_upload" do
    transaction = Transaction.new(
      purchaser:,
      item:,
      merchant:,
      file_upload: nil,
      count: 2
    )
    expect(transaction).not_to be_valid
  end

  it "is invalid without a count" do
    transaction = Transaction.new(
      purchaser:,
      item:,
      merchant:,
      file_upload:,
      count: nil
    )
    expect(transaction).not_to be_valid
  end

  it "is invalid with a count of 0 or less" do
    transaction = Transaction.new(
      purchaser:,
      item:,
      merchant:,
      file_upload:,
      count: 0
    )
    expect(transaction).not_to be_valid
    transaction.count = -1
    expect(transaction).not_to be_valid
  end

  it "calculates total income" do
    Transaction.create(purchaser:, item:, merchant:, file_upload:, count: 2)
    item2 = Item.create(description: "Item 2", price: 20.0)
    Transaction.create(purchaser:, item: item2, merchant:, file_upload:, count: 3)

    expect(Transaction.total_income).to eq(80.0)
  end
end
