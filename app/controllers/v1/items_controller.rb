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

    def show
      @item = Item.find(id: params[:item_id])
      if @item
        render :item, status: :ok
      else
        head(:unprocessable_entity)
      end
    end

    def endless_item
      @items = Item.all.newest
      render :endless_item, status: :ok
    end

    def following
      user = User.find(params[:user_id])
      if user
        @items = user.following_items
        render :following, status: :ok
      else
        head(:unprocessable_entity)
      end
    end
  end
end
