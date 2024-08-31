class CreatePurchasers < ActiveRecord::Migration[7.2]
  def change
    create_table :purchasers do |t|
      t.string :name

      t.timestamps
    end
  end
end
