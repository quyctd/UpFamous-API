module V1
  class ItemsController < ApplicationController
    def homepage_thumbnail
      @item = Item.horizontal_photo.order('RANDOM()').limit(1).take!
      if @item
        render :homepage_thumbnail, status: :ok
      else
        head(:unprocessable_entity)
      end
    end

    def endless_item
      items = Item.all
      @ret = []
      items.each do |item|
        ret_item = {
          width: item.width,
          height: item.height,
          cloudinary_ver: item.cloudinary_ver,
          cloudinary_id: item.cloudinary_id,
          format: item.format,
          user: item.user,
          user_fullname: item.user.full_name,
          likes: item.item_like_maps,
          collections: item.collection_items
        }
        @ret.append(ret_item)
      end
      render :endless_item, status: :ok
    end
  end
end
