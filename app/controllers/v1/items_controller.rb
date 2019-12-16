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
      @item = Item.find(params[:item_id])
      user = User.find(params[:user_id])
      item_like = ItemLikeMap.where(item_id: @item.id, user_id: user.id).first
      item_like_count = ItemLikeCount.where(item_id: @item.id).first
      if item_like
        item_like.liked_flag = !item_like.liked_flag
        item_like_count.likes += item_like.liked_flag == true ? 1 : -1
      else
        ItemLikeMap.create!(item_id: @item.id, user_id: user.id, like_time: DateTime.now)
        item_like_count.likes += 1
      end

      if item_like.save && item_like_count.save
        render :like, status: :ok
      else
        head(:unprocessable_entity)
      end
    end

    def search
      query = params[:query]

      tags = Tag.where('name like ?', "%#{query}%")
      tag_ids = tags.ids

      item_tags = ItemTagMap.where(tag_id: tag_ids)
      photo_from_tags = Item.where(id: item_tags.pluck(:item_id).uniq)
      photo_from_description = Item.where('description like ?', "%#{query}%")

      @photos = (photo_from_tags + photo_from_description).uniq.reverse!

      clt_tags = CollectionTag.where(tag_id: tag_ids)
      clt_from_tags = Collection.not_private.where(id: clt_tags.pluck(:collection_id).uniq)
      clt_from_attrs = Collection.not_private.where('describe like ? OR name like ?', "%#{query}%", "%#{query}%")

      @collections = (clt_from_tags + clt_from_attrs).uniq.reverse!

      @users = User.where('first_name like ? OR last_name like ? OR username like ?',
                          "%#{query}%",
                          "%#{query}%",
                          "%#{query}%").newest

      @recommends = Tag.shuffle.take(12)

      render :search, status: :ok
    end
  end
end
