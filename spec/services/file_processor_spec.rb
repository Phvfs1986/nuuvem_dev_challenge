require "rails_helper"

RSpec.describe Transactions::FileProcessor, type: :service do
  let(:transaction_import) { create(:transaction_import, :with_valid_file) }
  subject(:file_processor) { described_class.new(transaction_import) }

  it "processes the .tab file and creates transactions" do
    expect { subject.process }
      .to change { Purchaser.count }.by(4)
      .and change { Item.count }.by(3)
      .and change { Merchant.count }.by(3)
      .and change { Transaction.count }.by(5)

    transaction = Transaction.first
    expect(transaction.purchaser.name).to eq("João Silva")
    expect(transaction.item.description).to eq("Pepperoni Pizza Slice")
    expect(transaction.price).to eq(10.0)
    expect(transaction.count).to eq(2)
    expect(transaction.merchant.name).to eq("Bob's Pizza")
    expect(transaction.merchant.address).to eq("987 Fake St")
    expect(transaction.transaction_import).to eq(transaction_import)

    transaction = Transaction.second
    expect(transaction.purchaser.name).to eq("Amy Pond")
    expect(transaction.item.description).to eq("Cute T-Shirt")
    expect(transaction.price).to eq(10.0)
    expect(transaction.count).to eq(5)
    expect(transaction.merchant.name).to eq("Tom's Awesome Shop")
    expect(transaction.merchant.address).to eq("456 Unreal Rd")
    expect(transaction.transaction_import).to eq(transaction_import)
  end

  context "when an error occurs" do
    before do
      allow(subject).to receive(:process_row).and_raise(StandardError, "Something went wrong")
    end

    it "logs the error and sets the transaction import status to error" do
      expect { file_processor.process }.to raise_error(StandardError)
      expect(transaction_import.reload.import_status).to eq("error")
    end
  end
end
