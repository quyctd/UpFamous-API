class CreatePhotos < ActiveRecord::Migration[6.0]
  def change
    create_table :photos do |t|
      t.references :item, foreign_key: true
      t.string :color
      t.timestamps
    end
  end
end
