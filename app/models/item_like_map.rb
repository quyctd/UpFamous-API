class ItemLikeMap < ApplicationRecord
  belongs_to :item
  belongs_to :liker, foreign_key: :user_id, class_name: 'User'
end
