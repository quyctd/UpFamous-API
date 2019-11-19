class CreateItemLikeCounts < ActiveRecord::Migration[6.0]
  def change
    create_table :item_like_counts do |t|
      t.integer :item_id
      t.integer :likes, default: 0
      t.timestamps
    end
  end
end
