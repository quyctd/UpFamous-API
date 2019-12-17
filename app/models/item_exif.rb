class ItemExif < ApplicationRecord
  belongs_to :item

  validates :item_id, presence: true
  validates_uniqueness_of :item_id
end
