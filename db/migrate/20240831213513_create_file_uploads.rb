class CreateFileUploads < ActiveRecord::Migration[7.2]
  def change
    create_table :file_uploads do |t|
      t.datetime :uploaded_at

      t.timestamps
    end
  end
end
