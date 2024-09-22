class TransactionImportsController < ApplicationController
  def index
    @pagy, @transaction_imports = pagy(TransactionImport.all.order("uploaded_at"), items: 20)
  end

  def show
    transaction_import = TransactionImport.find(params[:id])
    @transaction_import = TransactionImportDecorator.new(transaction_import)

    @pagy, @transactions = pagy(transaction_import.transactions.includes(:purchaser, :merchant), limit: 20)
  end

  def new
    @transaction_import = TransactionImport.new
  end

  def create
    @transaction_import = Transactions::ImportProcessor.new(transaction_imports_params[:order_file]).call

    if @transaction_import.persisted?
      flash[:notice] = "Your file is being processed. Please check the status later."
      redirect_to action: :index
    else
      flash.now[:alert] = "Failed to process the file: #{@transaction_import.errors.full_messages.join(", ")}"
      render :new, status: :bad_request
    end
  end

  private

  def transaction_imports_params
    params.require(:transaction_import).permit(:order_file)
  end
end
