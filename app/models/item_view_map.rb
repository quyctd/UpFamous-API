class ItemViewMap < ApplicationRecord
  belongs_to :item
  belongs_to :viewer, foreign_key: user_id, class_name: 'User'
end
