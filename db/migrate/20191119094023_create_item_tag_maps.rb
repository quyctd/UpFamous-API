class CreateItemTagMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :item_tag_maps do |t|
      t.integer :item_id
      t.integer :tag_id
      t.timestamps
    end
  end
end
