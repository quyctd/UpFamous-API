class CreateCollectionItems < ActiveRecord::Migration[6.0]
  def change
    create_table :collection_items do |t|
      t.integer :collection_id
      t.integer :item_id
      t.boolean :deleted_flag
      t.timestamps
    end
  end
end
