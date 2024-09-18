require "rails_helper"

RSpec.describe TransactionImportDecorator, type: :model do
  let(:transaction_import) { create(:transaction_import, :with_valid_file) }
  let(:order_file) { double("ActiveStorage::Blob", filename: "example_file.tab") }

  subject { described_class.new(transaction_import) }

  before do
    allow(order_file).to receive(:filename).and_return("example_file.tab")
  end

  describe "#uploaded_at" do
    it "formats the uploaded_at date correctly" do
      formatted_time = transaction_import.uploaded_at.strftime("%d/%m/%Y at %H:%M")
      expect(subject.uploaded_at).to eq(formatted_time)
    end
  end

  describe "#file_total_income" do
    it "formats the file_total_income as currency" do
      expect(subject.file_total_income).to eq("<strong>$0.00</strong>")
    end
  end

  describe "#import_status" do
    context 'when status is "initializing"' do
      it "returns the correct badge HTML" do
        expect(subject.import_status).to eq(
          "<span class=\"bg-gray-100 text-gray-800 text-sm font-medium me-2 px-2.5 py-0.5 rounded dark:bg-gray-900 dark:text-gray-300\">INITIALIZING</span>"
        )
      end
    end

    context "when status is enqueued" do
      before do
        allow(transaction_import).to receive(:import_status).and_return("enqueued")
      end

      it "returns the correct badge HTML" do
        expect(subject.import_status).to eq(
          "<span class=\"bg-yellow-100 text-yellow-800 text-sm font-medium me-2 px-2.5 py-0.5 rounded dark:bg-yellow-900 dark:text-yellow-300\">ENQUEUED</span>"
        )
      end
    end

    context "when status is processing" do
      before do
        allow(transaction_import).to receive(:import_status).and_return("processing")
      end

      it "returns the correct badge HTML" do
        expect(subject.import_status).to eq(
          "<span class=\"bg-blue-100 text-blue-800 text-sm font-medium me-2 px-2.5 py-0.5 rounded dark:bg-blue-900 dark:text-blue-300\">PROCESSING</span>"
        )
      end
    end

    context "when status is finished" do
      before do
        allow(transaction_import).to receive(:import_status).and_return("finished")
      end

      it "returns the correct badge HTML" do
        expect(subject.import_status).to eq(
          "<span class=\"bg-green-100 text-green-800 text-sm font-medium me-2 px-2.5 py-0.5 rounded dark:bg-green-900 dark:text-green-300\">FINISHED</span>"
        )
      end
    end

    context "when status is error" do
      before do
        allow(transaction_import).to receive(:import_status).and_return("error")
      end

      it "returns the correct badge HTML" do
        expect(subject.import_status).to eq(
          "<span class=\"bg-red-100 text-red-800 text-sm font-medium me-2 px-2.5 py-0.5 rounded dark:bg-red-900 dark:text-red-300\">ERROR</span>"
        )
      end
    end

    describe "#download_link" do
      it "returns the correct download link HTML" do
        expect(subject.download_link).to eq("<span><a class=\"underline text-blue-500 pointer\" href=\"/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MSwicHVyIjoiYmxvYl9pZCJ9fQ==--061e17fe8f02d892a8dd5ba8e3902c8e7f80be97/example_input.tab\">example_input.tab</a></span>")
      end
    end

    describe "#actions" do
      it "returns the correct actions HTML" do
        expect(subject.actions).to eq("<a class=\"underline text-blue-500 pointer\" href=\"/transaction_imports/1\">Show</a> | <a class=\"underline text-blue-500 pointer\" href=\"/rails/active_storage/blobs/redirect/eyJfcmFpbHMiOnsiZGF0YSI6MSwicHVyIjoiYmxvYl9pZCJ9fQ==--061e17fe8f02d892a8dd5ba8e3902c8e7f80be97/example_input.tab\">Download File</a>")
      end
    end
  end
end
