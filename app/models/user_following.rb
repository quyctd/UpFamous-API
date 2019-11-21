class UserFollowing < ApplicationRecord
  belongs_to :follower, class_name: 'User', foreign_key: :source_user_id
  belongs_to :followed_user, class_name: 'User', foreign_key: :target_user_id
end
