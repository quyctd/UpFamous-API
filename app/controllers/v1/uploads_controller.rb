module V1
  class UploadsController < ApplicationController
    def create
      user_token = params[:auth_token]
      @user = User.where(authentication_token: user_token).first
      @ret = []
      @items = []
      if @user
        uploads = params[:list_upload]
        uploads.each do |upload|
          item = create_item(upload)
          upload_item = ItemUpload.create(item_id: item.id,
                                          user_id: @user.id,
                                          original_width: item.width,
                                          original_height: item.height,
                                          original_file_name: upload[:original_file_name])
          tags = Cloudinary::Api.update(item[:cloudinary_id], categorization: "imagga_tagging", auto_tagging: 0.7)
          puts tags
          @items.append(item)
          @ret.append(tags)
        end
        render :create, status: :created
      else
        head(:unprocessable_entity)
      end
    end
  end

  private

  def create_item(upload_params)
    @item = Item.new(item_params(upload_params))
  end

  def item_params(uparams)
    {
      user_id: params[:user_id],
      content_type: 0,
      description: uparams[:description],
      status: 1,
      uploaded_at: uparams[:uploaded_at],
      width: uparams[:width],
      height: uparams[:height],
      deleted_flag: 0,
      cloudinary_id: params[:cloudinary_id],
      cloudinary_ver: params[:cloudinary_ver],
      format: params[:format]
    }
  end

end