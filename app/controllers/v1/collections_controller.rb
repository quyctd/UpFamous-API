module V1
  class CollectionsController < ApplicationController
    def create
      collection = Collection.new(collection_params)
      if collection.save
        @user = User.find(collection_params[:user_id])
        render 'v1/users/create', status: :ok
      else
        head(:unprocessable_entity)
      end
    end

    private

    def collection_params
      params.require(:collection).permit(:name, :describe, :user_id, :status)
    end
  end
end
