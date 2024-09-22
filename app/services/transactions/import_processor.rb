module Transactions
  class ImportProcessor
    def initialize(order_file)
      @order_file = order_file
    end

    def call
      transaction_import = TransactionImport.new(order_file: @order_file, uploaded_at: Time.now)

      if transaction_import.save
        handle_status_and_enqueue(transaction_import)
      else
        transaction_import.change_status(:error)
      end

      transaction_import
    end

    private

    def handle_status_and_enqueue(transaction_import)
      transaction_import.change_status(:initializing)

      TransactionProcessorJob.perform_async(transaction_import.id)

      transaction_import.change_status(:enqueued)
    end
  end
end
