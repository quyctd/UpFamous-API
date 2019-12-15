class Collection < ApplicationRecord
  has_many :collection_items

  def feature_imgs
    ids = collection_items.active.pluck(:item_id)
    Item.where(id: ids).newest.take(3)
  end
end
