class CreateItems < ActiveRecord::Migration[6.0]
  def change
    create_table :items do |t|
      t.references :user, foreign_key: true
      t.string :uuid
      t.integer :content_type
      t.text :description
      t.integer :status
      t.datetime :uploaded_at
      t.integer :width
      t.integer :height
      t.datetime :remove_at
      t.boolean :deleted_flag, default: false
      t.string :submit_thumbnail_url
      t.boolean :search_flag, default: false
      t.boolean :showing_flag, default: false
      t.timestamps
    end
  end
end
