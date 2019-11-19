class CreateItemExifs < ActiveRecord::Migration[6.0]
  def change
    create_table :item_exifs do |t|
      t.integer :item_id
      t.string :camera_maker
      t.string :camera_model
      t.integer :focus_length
      t.float :aperture
      t.integer :shutter_speed
      t.integer :iso
      t.timestamps
    end
  end
end
