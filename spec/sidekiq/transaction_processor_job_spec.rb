require "rails_helper"

RSpec.describe TransactionProcessorJob, type: :job do
  let!(:transaction_import) { create(:transaction_import, :with_valid_file) }

  it "enqueues the job" do
    expect {
      TransactionProcessorJob.perform_async(transaction_import.id)
    }.to change(TransactionProcessorJob.jobs, :size).by(1)
  end

  context "when processing is successful" do
    before do
      Sidekiq::Testing.inline!
    end
    it "changes the status to processing, finished" do
      allow_any_instance_of(TransactionImport).to receive(:change_status)

      expect_any_instance_of(TransactionImport).to receive(:change_status).with(:processing)
      expect_any_instance_of(TransactionImport).to receive(:change_status).with(:finished)

      TransactionProcessorJob.perform_async(transaction_import.id)
    end

    it "updates the total income" do
      allow_any_instance_of(TransactionImport).to receive(:update_file_total_income)

      expect_any_instance_of(TransactionImport).to receive(:update_file_total_income)

      TransactionProcessorJob.perform_async(transaction_import.id)
    end

    it "processes the file" do
      allow(Transactions::FileProcessor).to receive(:process).with(transaction_import)

      TransactionProcessorJob.perform_async(transaction_import.id)

      expect(Transactions::FileProcessor).to have_received(:process).with(transaction_import)
    end
  end

  # context "when processing fails" do
  #   before do
  #     allow(Transactions::FileProcessor).to receive(:process).and_raise(StandardError)
  #   end

  #   it "sets status to error if processing fails" do
  #     allow(Transactions::FileProcessor).to receive(:process).and_raise(StandardError)

  #     expect(transaction_import).to receive(:change_status).with(:processing)
  #     expect(transaction_import).to receive(:change_status).with(:error)

  #     expect {
  #       TransactionProcessorJob.perform_async(transaction_import.id)
  #     }.to raise_error(StandardError)
  #   end
  # end
end
