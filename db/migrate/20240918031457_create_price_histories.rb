class CreatePriceHistories < ActiveRecord::Migration[6.1]
  def change
    create_table :price_histories do |t|
      t.references :item, null: false, foreign_key: true
      t.decimal :price, precision: 8, scale: 2, null: false
      t.datetime :effective_at, null: false

      t.timestamps
    end

    add_index :price_histories, [:item_id, :effective_at], unique: true
  end
end
