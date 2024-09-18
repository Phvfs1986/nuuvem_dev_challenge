class CreateTransactionImports < ActiveRecord::Migration[7.2]
  def change
    create_table :transaction_imports do |t|
      t.datetime :uploaded_at

      t.timestamps
    end
  end
end
