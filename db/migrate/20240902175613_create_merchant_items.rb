class CreateMerchantItems < ActiveRecord::Migration[7.2]
  def change
    create_table :merchant_items do |t|
      t.references :item, null: false, foreign_key: true
      t.references :merchant, null: false, foreign_key: true

      t.timestamps
    end
  end
end
