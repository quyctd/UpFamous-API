class CreateItemLikeMaps < ActiveRecord::Migration[6.0]
  def change
    create_table :item_like_maps do |t|
      t.integer :item_id
      t.integer :user_id
      t.datetime :like_time
      t.boolean :liked_flag, default: true
      t.timestamps
    end
  end
end
