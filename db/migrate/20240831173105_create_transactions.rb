class CreateTransactions < ActiveRecord::Migration[7.2]
  def change
    create_table :transactions do |t|
      t.integer :count
      t.references :purchaser, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.references :merchant, null: false, foreign_key: true
      t.references :file_upload, null: false, foreign_key: true

      t.timestamps
    end
  end
end
