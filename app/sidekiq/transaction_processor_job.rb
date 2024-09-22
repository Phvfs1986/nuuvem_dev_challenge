class TransactionProcessorJob
  include Sidekiq::Job

  def perform(transaction_import_id)
    transaction_import = TransactionImport.find(transaction_import_id)

    transaction_import.change_status(:processing)

    process_file(transaction_import)

    transaction_import.change_status(:finished)
  rescue => e
    transaction_import.change_status(:error)
    raise e
  end

  private

  def process_file(transaction_import)
    Transactions::FileProcessor.new(transaction_import).process
  end
end
