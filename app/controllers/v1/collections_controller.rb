# frozen_string_literal: true

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

    def add
      collection_item = CollectionItem.where(item_id: params[:item_id],
                                             collection_id: params[:collection_id]).first
      collection_item ||= CollectionItem.new(item_id: params[:item_id],
                                             collection_id: params[:collection_id])
      collection_item.deleted_flag = false
      if collection_item.save
        @user = User.find(params[:user_id])
        render 'v1/users/create', status: :ok
      else
        head(:unprocessable_entity)
      end
    end

    def remove
      collection_item = CollectionItem.where(item_id: params[:item_id],
                                             collection_id: params[:collection_id]).first
      collection_item.deleted_flag = true
      if collection_item.save
        @user = User.find(params[:user_id])
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
