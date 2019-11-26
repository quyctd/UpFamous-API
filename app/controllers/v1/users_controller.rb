module V1
  class UsersController < ApplicationController
    def create
      @user = User.new(user_params)
      if @user.save
        render :create, status: :created
      else
        head(:unprocessable_entity)
      end
    end

    private

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :username, :password)
    end
  end
end
