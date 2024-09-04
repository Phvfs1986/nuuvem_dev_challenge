require "rails_helper"

RSpec.describe TransactionProcessorJob, type: :job do
  subject { described_class.new }

  let(:transaction_import) { create(:transaction_import, :with_valid_file) }
  let(:transaction_import_id) { transaction_import.id }

  before do
    allow(TransactionImport).to receive(:find).with(transaction_import_id).and_return(transaction_import)
  end

  context "when the job runs successfully" do
    before do
      allow(Transactions::FileProcessor).to receive(:process).with(transaction_import)
      allow(transaction_import).to receive(:update_file_total_income)
    end

    it "changes the status to processing, processes the file, updates income, and changes the status to finished" do
      expect(transaction_import).to receive(:change_status).with(:processing).ordered
      expect(Transactions::FileProcessor).to receive(:process).with(transaction_import).ordered
      expect(transaction_import).to receive(:update_file_total_income).ordered
      expect(transaction_import).to receive(:change_status).with(:finished).ordered

      subject.perform(transaction_import_id)
    end
  end

  context "when an error occurs during processing" do
    let(:error) { StandardError.new("An error occurred") }

    before do
      allow(Transactions::FileProcessor).to receive(:process).with(transaction_import).and_raise(error)
    end

    it "changes the status to processing, raises an error, and changes the status to error" do
      expect(transaction_import).to receive(:change_status).with(:processing).ordered
      expect(Transactions::FileProcessor).to receive(:process).with(transaction_import).ordered
      expect(transaction_import).to receive(:change_status).with(:error).ordered

      expect { subject.perform(transaction_import_id) }.to raise_error(StandardError, "An error occurred")
    end
  end
end
