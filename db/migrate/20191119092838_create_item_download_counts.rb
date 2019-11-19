class CreateItemDownloadCounts < ActiveRecord::Migration[6.0]
  def change
    create_table :item_download_counts do |t|
      t.integer :item_id
      t.integer :downloads, default: 0
      t.timestamps
    end
  end
end
