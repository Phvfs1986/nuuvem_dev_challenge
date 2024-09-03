class TransactionProcessorJob
  include Sidekiq::Job

  def perform(transaction_import_id)
    transaction_import = TransactionImport.find(transaction_import_id)
    transaction_import.change_status(:processing)
    Transactions::FileProcessor.process(transaction_import)
    transaction_import.update_file_total_income
    transaction_import.change_status(:finished)
  rescue => e
    transaction_import.change_status(:error)
    raise e
  end
end
