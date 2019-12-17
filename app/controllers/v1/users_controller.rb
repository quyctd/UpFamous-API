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

    def account_info
      @user = User.where(authentication_token: params[:token]).first
      if @user
        render :account_info, status: :ok
      else
        head(:unprocessable_entity)
      end
    end

    def update_account
      @user = User.where(authentication_token: params[:token]).first
      if @user
        @user.update(update_params)
        head(:ok)
      else
        head(:unprocessable_entity)
      end
    end

    def update_ava
      @user = User.where(authentication_token: params[:token]).first
      if @user
        @user.update(update_ava_params)
        head(:ok)
      else
        head(:unprocessable_entity)
      end
    end

    private

    def update_ava_params
      params.permit(:avatar)
    end

    def update_params
      params.permit(:username, :first_name, :last_name, :email, :location, :bio)
    end

    def user_params
      params.permit(:email, :first_name, :last_name, :username, :password)
    end
  end
end
