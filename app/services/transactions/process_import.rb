module Transactions
  class ProcessImport
    def initialize(order_file:)
      @order_file = order_file
    end

    def call
      transaction_control = true

      ActiveRecord::Base.transaction do
        transaction_import = TransactionImport.new(order_file: @order_file)
        transaction_import.uploaded_at = Time.now
        transaction_control &&= transaction_import.save

        transaction_control &&= FileProcessor.process(@order_file, transaction_import)

        raise ActiveRecord::Rollback unless transaction_control
        transaction_import.update_file_total_income
      end
    end
  end
end
