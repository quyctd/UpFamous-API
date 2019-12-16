class CollectionTag < ApplicationRecord
  belongs_to :collection
  belongs_to :tag

  validate :tag_id, presence: true
  validate :collection_id, presence: true
  validates_uniqueness_of :tag_id, scope: :collection_id
end
