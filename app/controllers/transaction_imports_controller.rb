class TransactionImportsController < ApplicationController
  def index
    @transaction_imports = TransactionImport.all
  end

  def show
    transaction_import = TransactionImport.find(params[:id])
    @transaction_import = TransactionImportSerializer.new(transaction_import)
    @transactions = transaction_import.transactions
  end

  def new
    @transaction_import = TransactionImport.new
  end

  def create
    puts transaction_imports_params.to_h.symbolize_keys
    @transaction_import = Transactions::ProcessImport.new(**transaction_imports_params.to_h.symbolize_keys).call

    redirect_to action: :index
  end

  private

  def transaction_imports_params
    params.require(:transaction_import).permit(:order_file)
  end
end
