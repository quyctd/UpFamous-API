# frozen_string_literal: true

module V1
  class CollectionsController < ApplicationController
    def all
      @collections = Collection.all.newest
      render :all, status: :ok
    end

    def create
      collection = Collection.new(collection_params)
      if collection.save
        user = User.find(collection_params[:user_id])
        @collections = user.collections
        render :collections, status: :ok
      else
        head(:unprocessable_entity)
      end
    end

    def user
      user = User.find(params[:user_id])
      @collections = user.collections
      render :collections, status: :ok
    end

    def add
      collection_item = CollectionItem.where(item_id: params[:item_id],
                                             collection_id: params[:collection_id]).first
      collection_item ||= CollectionItem.new(item_id: params[:item_id],
                                             collection_id: params[:collection_id])
      collection_item.deleted_flag = false
      if collection_item.save
        build_clt_tags(collection_item.collection)
        user = User.find(params[:user_id])
        @collections = user.collections
        render :collections, status: :ok
      else
        head(:unprocessable_entity)
      end
    end

    def remove
      collection_item = CollectionItem.where(item_id: params[:item_id],
                                             collection_id: params[:collection_id]).first
      collection_item.deleted_flag = true
      if collection_item.save
        user = User.find(params[:user_id])
        @collections = user.collections
        render :collections, status: :ok
      else
        head(:unprocessable_entity)
      end
    end

    def show
      @clt = Collection.find(params[:id])
      if @clt
        render :show, status: :ok
      else
        head(:unprocessable_entity)
      end
    end

    def build_clt_tags(clt)
      items = clt.items
      return if items.empty?

      item_tags = ItemTagMap.where(item_id: items.pluck(:id).uniq)
      tag_ids = item_tags.pluck(:tag_id)
      tag_hash = score(tag_ids)
      tags = tag_hash.keys.take(3)

      ActiveRecord::Base.transaction do
        tags.each do |tag_id|
          next unless CollectionTag.where(collection_id: clt.id, tag_id: tag_id).empty?
          CollectionTag.create!(collection_id: clt.id, tag_id: tag_id)
        end
      end
    end

    private

    def score(array)
      hash = Hash.new(0)
      array.each{ |key| hash[key] += 1 }
      hash.sort_by { |_key, value| value }.reverse!.to_h
    end

    def collection_params
      params.require(:collection).permit(:name, :describe, :user_id, :status)
    end
  end
end
