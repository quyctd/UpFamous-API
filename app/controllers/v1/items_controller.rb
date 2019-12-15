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
      @item = Item.find(params[:item_id])
      if @item
        render :show, status: :ok
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

    def like
      item = Item.find(params[:item_id])
      user = User.find(params[:user_id])
      @item_like = ItemLikeMap.where(item_id: item.id, user_id: user.id).first
      @item_like_count = ItemLikeCount.where(item_id: item.id).first
      if @item_like
        @item_like.liked_flag = !@item_like.liked_flag
        @item_like_count.count += @item_like.liked_flag == true ? 1 : -1
      else
        ItemLikeMap.create!(item_id: item.id, user_id: user.id, like_time: Date.now)
        @item_like_count.count += 1
      end

      if @item_like.save && @item_like_count.save
        render :like, status: :ok
      else
        head(:unprocessable_entity)
      end
    end
  end
end
