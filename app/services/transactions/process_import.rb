module Transactions
  class ProcessImport
    def initialize(order_file:)
      @order_file = order_file
    end

    def call
      transaction_import = TransactionImport.create(order_file: @order_file, uploaded_at: Time.now)

      return transaction_import if transaction_import.errors.any?

      transaction_import.change_status(:initializing)

      TransactionProcessorJob.perform_async(transaction_import.id)
      transaction_import.change_status(:enqueued)
      transaction_import
    end
  end
end
