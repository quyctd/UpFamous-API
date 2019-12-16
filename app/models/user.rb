class User < ApplicationRecord
  acts_as_token_authenticatable
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :items
  has_many :received_follows, foreign_key: :target_user_id, class_name: 'UserFollowing'
  has_many :followers, through: :received_follows, source: :follower

  has_many :given_follows, foreign_key: :source_user_id, class_name: 'UserFollowing'
  has_many :followings, through: :given_follows, source: :followed_user

  has_many :item_like_maps
  has_many :collections

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :username, presence: true, length: {maximum: 64}
  validates :email, presence: true, uniqueness: true

  ROLE_NORMAL = 0
  ROLE_STAFF = 1
  ROLE_ADMIN = 2
  TYPE_INDIVIDUAL = 0
  TYPE_BRAND = 1

  scope :newest, -> { order('created_at DESC') }

  def full_name
    [first_name, last_name].reject(&:blank?).join(' ').titleize
  end

  def following_items
    Item.where(user_id: following_ids).newest
  end

  def like_items
    ids = item_like_maps.pluck(:item_id)
    Item.where(id: ids).newest
  end

  def feature_items
    items.newest.take(3)
  end
end
