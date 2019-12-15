class CollectionItem < ApplicationRecord
  belongs_to :collection
  belongs_to :item

  scope :active, -> { where(deleted_flag: false) }
end
