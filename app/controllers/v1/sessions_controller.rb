module V1
  class SessionsController < ApplicationController
    def show; end

    def create
      @user = User.where(email: params[:email]).first

      if @user&.valid_password?(params[:password])
        render :create, status: :created
      else
        head(:unauthorized)
      end
    end

    def destroy; end
  end
end
