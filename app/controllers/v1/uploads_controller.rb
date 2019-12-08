module V1
  class UploadsController < ApplicationController
    def create
      user_token = params[:auth_token]
      @user = User.where(authentication_token: user_token).first
      @items = []
      if @user
        uploads = params[:list_upload]
        uploads.each do |upload|
          item = Item.create(item_params(@user.id, upload))
          upload_item = ItemUpload.create(item_id: item.id,
                                          user_id: @user.id,
                                          original_width: item.width,
                                          original_height: item.height,
                                          original_file_name: upload[:original_file_name])
          tags = Cloudinary::Api.update(upload[:cloudinary_id], :categorization => "aws_rek_tagging", :auto_tagging => 0.7)
          create_item_tags(item.id, tags)
          @items.append(item)
        end
        render :create, status: :created
      else
        head(:unprocessable_entity)
      end
    end

    def create_item_tags(item_id, tags)

    end

    private

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
          format: uparams[:format]
      }
    end
  end
end