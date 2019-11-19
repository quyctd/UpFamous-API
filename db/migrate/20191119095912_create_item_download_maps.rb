class CreateItemDownloadMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :item_download_maps do |t|
      t.integer :item_id
      t.integer :user_id
      t.datetime :download_time
      t.timestamps
    end
  end
end
