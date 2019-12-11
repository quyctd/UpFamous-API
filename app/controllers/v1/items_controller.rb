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
      @items = Item.all
      render :endless_item, status: :ok
    end
  end
end
