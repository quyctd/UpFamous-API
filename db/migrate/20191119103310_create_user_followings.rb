class CreateUserFollowings < ActiveRecord::Migration[6.0]
  def change
    create_table :user_followings do |t|
      t.integer :source_user_id
      t.integer :target_user_id
      t.boolean :follow_flag
      t.datetime :following_time
      t.datetime :unfollow_time
      t.timestamps
    end
  end
end
