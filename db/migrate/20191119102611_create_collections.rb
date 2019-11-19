class CreateCollections < ActiveRecord::Migration[6.0]
  def change
    create_table :collections do |t|
      t.string :name
      t.text :describe
      t.integer :user_id
      t.integer :status
      t.datetime :publish_at
      t.datetime :private_at
      t.timestamps
    end
  end
end
