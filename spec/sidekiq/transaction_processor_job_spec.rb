require "rails_helper"

RSpec.describe TransactionProcessorJob, type: :job do
  let(:transaction_import) { create(:transaction_import, :with_valid_file) }
  let(:file_processor) { instance_double(Transactions::FileProcessor) }
  let(:transaction_import_id) { transaction_import.id }

  subject { described_class.new }

  before do
    allow(Transactions::FileProcessor).to receive(:new).with(transaction_import).and_return(file_processor)
    allow(file_processor).to receive(:process)
    allow(TransactionImport).to receive(:find).with(transaction_import_id).and_return(transaction_import)
  end

  describe "#perform" do
    context "when the job is successful" do
      it "processes the file and updates status to finished" do
        expect(transaction_import).to receive(:change_status).with(:processing).ordered
        expect(transaction_import).to receive(:change_status).with(:finished).ordered

        subject.perform(transaction_import_id)

        expect(file_processor).to have_received(:process)
      end
    end

    context "when an error occurs" do
      before do
        allow(file_processor).to receive(:process).and_raise(StandardError, "Processing error")
      end

      it "updates the status to error and raises the error" do
        expect(transaction_import).to receive(:change_status).with(:processing).ordered
        expect(transaction_import).to receive(:change_status).with(:error).ordered

        expect { subject.perform(transaction_import_id) }.to raise_error(StandardError, "Processing error")
      end
    end
  end
end
