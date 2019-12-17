class AddUserAvatarToUser < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :avatar, :string, default: 'https://res.cloudinary.com/flask-image/image/upload/v1576546201/Upfamous/undefined_ava.jpg'
  end
end
