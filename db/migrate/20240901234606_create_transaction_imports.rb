class CreateTransactionImports < ActiveRecord::Migration[7.2]
  def change
    create_table :transaction_imports do |t|
      t.datetime :uploaded_at
      t.decimal :file_total_income

      t.timestamps
    end
  end
end
