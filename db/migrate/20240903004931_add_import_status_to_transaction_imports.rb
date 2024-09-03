class AddImportStatusToTransactionImports < ActiveRecord::Migration[7.2]
  def change
    add_column :transaction_imports, :import_status, :string
  end
end
