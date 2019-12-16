class CollectionTag < ApplicationRecord
  belongs_to :collection
  belongs_to :tag

  validates :tag_id, presence: true
  validates :collection_id, presence: true
  validates_uniqueness_of :tag_id, scope: :collection_id
end
