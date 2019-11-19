class CreateItemViewCounts < ActiveRecord::Migration[6.0]
  def change
    create_table :item_view_counts do |t|
      t.integer :item_id
      t.integer :views, default: 0
      t.timestamps
    end
  end
end
