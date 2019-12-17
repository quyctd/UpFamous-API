class Collection < ApplicationRecord
  has_many :collection_items
  belongs_to :user
  has_many :collection_tags

  scope :newest, -> { order('created_at DESC') }
  scope :not_private, -> { where(status: false) }

  def tags
    Tag.where(id: collection_tags.pluck(:tag_id))
  end

  def feature_imgs
    items.take(3)
  end

  def items
    ids = collection_items.active.pluck(:item_id)
    Item.where(id: ids).newest
  end

  def ids
    items.pluck(:id)
  end

  def img_count
    items.length
  end
end
