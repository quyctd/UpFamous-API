class CreateItemLocations < ActiveRecord::Migration[6.0]
  def change
    create_table :item_locations do |t|
      t.integer :item_id
      t.string :name
      t.string :city
      t.string :country
      t.float :latitude
      t.float :longitude

      t.timestamps
    end
  end
end
