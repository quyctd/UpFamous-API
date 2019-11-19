class CreateCollectionTags < ActiveRecord::Migration[6.0]
  def change
    create_table :collection_tags do |t|
      t.integer :collection_id
      t.integer :tag_id
      t.timestamps
    end
  end
end
