class Collection < ApplicationRecord
  has_many :collection_items

  def feature_imgs
    items.take(3)
  end

  def items
    ids = collection_items.active.pluck(:item_id)
    Item.where(id: ids).newest
  end

  def img_count
    items.length
  end
end
