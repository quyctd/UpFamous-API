class CreateItemViewMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :item_view_maps do |t|
      t.integer :item_id
      t.string :view_ip
      t.datetime :view_time
      t.timestamps
    end
  end
end
