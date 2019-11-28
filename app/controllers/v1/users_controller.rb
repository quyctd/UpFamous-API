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

    private

    def user_params
      params.permit(:email, :first_name, :last_name, :username, :password)
    end
  end
end
