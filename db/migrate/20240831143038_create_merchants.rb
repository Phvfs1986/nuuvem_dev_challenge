class CreateMerchants < ActiveRecord::Migration[7.2]
  def change
    create_table :merchants do |t|
      t.string :name
      t.text :address

      t.timestamps
    end
  end
end
