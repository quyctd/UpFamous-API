class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :items
  has_many :received_follows, foreign_key: :target_user_id, class_name: 'UserFollowing'
  has_many :followers, through: :received_follows, source: :follower

  has_many :given_follows, foreign_key: :source_user_id, class_name: 'UserFollowing'
  has_many :followings, through: :given_follows, source: :followed_user
end
