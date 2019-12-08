class ModifyColumnOfItem < ActiveRecord::Migration[6.0]
  def change
    remove_column :items, :submit_thumbnail_url
    add_column :items, :cloudinary_id, :string
    add_column :items, :cloudinary_ver, :string
    add_column :items, :format, :string
  end
end
