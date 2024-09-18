require "rails_helper"

RSpec.describe Transactions::ImportProcessor, type: :service do
  describe "#call" do
    let(:order_file) { fixture_file_upload(Rails.root.join("spec/fixtures/files/example_input.tab")) }
    let(:invalid_order_file) { nil }

    subject { described_class.new(order_file) }

    context "when the order file is valid" do
      let(:transaction_import) { subject.call }

      before do
        allow(TransactionProcessorJob).to receive(:perform_async)
      end

      it "creates a new TransactionImport record with the correct attributes" do
        expect(transaction_import.uploaded_at).to be_within(1.second).of(Time.now)
      end

      it "does not return errors" do
        expect(transaction_import.errors).to be_empty
      end

      it "changes the status to :initializing" do
        expect(transaction_import.import_status).to eq("initializing").or eq("enqueued")
      end

      it "enqueues a TransactionProcessorJob with the correct arguments" do
        expect(TransactionProcessorJob).to have_received(:perform_async).with(transaction_import.id)
      end

      it "changes the status to :enqueued after job is enqueued" do
        expect(transaction_import.import_status).to eq("enqueued")
      end
    end

    context "when the order file is invalid" do
      subject { described_class.new(invalid_order_file) }
      let(:transaction_import) { subject.call }

      it "creates a TransactionImport record with errors" do
        expect(transaction_import.errors).not_to be_empty
        expect(transaction_import).to be_a(TransactionImport)
      end

      it "returns immediately without changing status or enqueuing a job" do
        expect(TransactionProcessorJob).not_to receive(:perform_async)

        expect(transaction_import.import_status).to eq("error")
        expect(transaction_import.errors).not_to be_empty
      end
    end
  end
end
