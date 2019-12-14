module V1
  class UsersController < ApplicationController
    def create
      @user = User.new(user_params)
      if @user.save
        render :create, status: :created
      else
        @errors = @user.errors.full_messages
        puts @errors
        render :'v1/errors/index', status: :unprocessable_entity
      end
    end

    def user_info
      @user = User.where(username: params[:username]).first
      if @user
        @photos = []
        @user.items.each do |item|
          photo = {
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
          @photos.append(photo)
        end
        render :user_info, status: :ok
      else
        head(:unprocessable_entity)
      end
    end

    def join_photo
      @item = Item.vertical_photo.random.take!
      if @item
        render :join_photo, status: :ok
      else
        head(:unprocessable_entity)
      end
    end

    private

    def user_params
      params.permit(:email, :first_name, :last_name, :username, :password)
    end
  end
end
