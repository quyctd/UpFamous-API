# frozen_string_literal: true

module V1
  class UploadsController < ApplicationController
    def create
      user_token = params[:auth_token]
      @user = User.where(authentication_token: user_token).first
      @items = []
      if @user
        uploads = params[:list_upload]
        uploads.each do |upload|
          item = Item.new(item_params(@user.id, upload))
          if item.save
            ItemUpload.create(item_id: item.id,
                              user_id: @user.id,
                              original_width: item.width,
                              original_height: item.height,
                              original_file_name: upload[:original_file_name])
            tag_result = Cloudinary::Api.update(upload[:cloudinary_id],
                                                categorization: 'aws_rek_tagging',
                                                auto_tagging: 0.7)
            tags = tag_result['tags']
            tags_info = tag_result['info']['categorization']['aws_rek_tagging']['data']
            create_item_count(item.id)
            create_item_tags(item.id, tags, tags_info)
            build_item_exif(item)
            @items.append(item)
          else
            puts item.errors.full_messages
          end
        end
        build_user_tags(@user)
        render :create, status: :created
      else
        head(:unprocessable_entity)
      end
    end

    def build_item_exif(item)
      results = Cloudinary::Api.resource(item.cloudinary_id, image_metadata: true)
      exif = results['image_metadata']
      item_exif = ItemExif.new(item_id: item.id)
      item_exif.camera_maker = exif['Make'] ? exif['Make'] : '--'
      item_exif.camera_model = exif['Model'] ? exif['Model'] : '--'
      item_exif.iso = exif['ISOSpeedRatings'] ? exif['ISOSpeedRatings'] : '--'
      item_exif.focus_length = exif['FocalLength'] ? exif['FocalLength'] : '--'
      item_exif.aperture = exif['ApertureValue'] ? exif['ApertureValue'] : '--'
      item_exif.shutter_speed = exif['ShutterSpeedValue'] ? exif['ShutterSpeedValue'] : '--'
      if item_exif.save
        puts "Created item exif for item #{item.id}"
      else
        puts item_exif.errors.full_messages
        head(:unprocessable_entity)
      end
    end

    def create_item_count(item_id)
      ItemLikeCount.create!(item_id: item_id)
      ItemViewCount.create!(item_id: item_id)
      ItemDownloadCount.create!(item_id: item_id)
    end

    def create_item_tags(item_id, tags, tags_info)
      tags.each do |t_name|
        tag = Tag.find_or_create_by(name: t_name)
        tags_info.each do |t_info|
          tag.confidence = t_info[:confidence] if t_info[:tag] == t_name
          break
        end
        tag.save
        # Create item tag map
        ItemTagMap.create(item_id: item_id, tag_id: tag.id)
      end
    end

    def build_user_tags(user)
      items = user.items
      return if items.empty?

      item_tags = ItemTagMap.where(item_id: items.pluck(:id).uniq)
      tag_ids = item_tags.pluck(:tag_id)
      tag_hash = score(tag_ids)
      tags = tag_hash.keys.take(5)

      ActiveRecord::Base.transaction do
        UserTag.where(user_id: user.id).destroy_all
        tags.each do |tag_id|
          UserTag.create!(user_id: user.id, tag_id: tag_id)
        end
      end
    end

    private

    def score(array)
      hash = Hash.new(0)
      array.each{ |key| hash[key] += 1 }
      hash.sort_by { |_key, value| value }.reverse!.to_h
    end

    def item_params(user_id, uparams)
      {
        user_id: user_id,
        content_type: 0,
        description: uparams[:description],
        status: 1,
        uploaded_at: uparams[:uploaded_at],
        width: uparams[:width],
        height: uparams[:height],
        deleted_flag: 0,
        cloudinary_id: uparams[:cloudinary_id],
        cloudinary_ver: uparams[:cloudinary_ver],
        format: uparams[:format],
        location: uparams[:location]
      }
    end
  end
end
