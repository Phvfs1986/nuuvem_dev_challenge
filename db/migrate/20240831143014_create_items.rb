class CreateItems < ActiveRecord::Migration[7.2]
  def change
    create_table :items do |t|
      t.text :description

      t.timestamps
    end
  end
end
