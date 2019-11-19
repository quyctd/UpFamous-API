class CreateItemUploads < ActiveRecord::Migration[6.0]
  def change
    create_table :item_uploads do |t|
      t.integer :item_id
      t.string :original_file_name
      t.string :upload_status
      t.string :upload_host
      t.string :upload_ip
      t.references :user, primary_key: true
      t.integer :original_width
      t.integer :original_height
      t.timestamps
    end
  end
end
