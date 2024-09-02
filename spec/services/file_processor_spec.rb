# spec/services/file_processor_spec.rb
require "rails_helper"

RSpec.describe Transactions::FileProcessor, type: :service do
  describe ".process" do
    let(:file) { fixture_file_upload("example_input.tab", "text/tab-separated-values") }

    before do
      Transactions::FileProcessor.process(file)
    end

    it "creates transactions" do
      file_upload = FileUpload.last
      transactions = file_upload.transactions
      expect(transactions).to be_present
    end

    it "matches the total income" do
      file_upload = FileUpload.last
      transactions = file_upload.transactions
      total_income = transactions.sum { |t| t.count * t.item.price }
      expect(total_income).to eq(Transaction.total_income)
    end
  end
end
