require "rails_helper"

RSpec.describe Transactions::FileProcessor, type: :service do
  let(:transaction_import) { create(:transaction_import, :with_valid_file) }

  before do
    @file_path = Rails.root.join("spec/fixtures/files/example_input.tab")
  end

  describe ".process" do
    context "with a valid file" do
      it "creates Purchasers, Items, Merchants, and Transactions" do
        expect {
          Transactions::FileProcessor.process(transaction_import)
        }.to change(Purchaser, :count).by(4)
          .and change(Item, :count).by(4)
          .and change(Merchant, :count).by(3)
          .and change(Transaction, :count).by(5)
      end

      it "associates items with merchants" do
        Transactions::FileProcessor.process(transaction_import)
        item = Item.first
        merchant = Merchant.first
        expect(merchant.items).to include(item)
      end
    end

    context "with file processing errors" do
      before do
        allow_any_instance_of(TransactionImport).to receive(:order_file).and_raise(Errno::ENOENT)
      end

      it "raises an error and handles it gracefully" do
        expect {
          Transactions::FileProcessor.process(transaction_import)
        }.to raise_error(Errno::ENOENT)
      end
    end
  end
end
