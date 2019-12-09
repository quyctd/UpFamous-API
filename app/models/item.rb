class Item < ApplicationRecord
  belongs_to :user
  has_one :item_like_count
  has_one :item_download_count
  has_one :item_view_count
  has_one :item_location
  has_one :item_exif
  has_one :item_upload
  has_one :photo

  has_many :item_like_maps
  has_many :item_download_maps
  has_many :item_view_maps
  has_many :item_tag_maps
  has_many :collection_items

end
