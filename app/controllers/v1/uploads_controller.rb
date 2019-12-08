module V1
  class UploadsController < ApplicationController
    def create
      user_token = upload_params[:auth_token]
      @user = User.where(authentication_token: user_token).first
      if @user
        uploads = upload_params[:list_upload]
        uploads.each do |upload|
          item = create_item(upload)
        end
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

  def upload_params
    params.permit(:auth_token, :list_upload)
  end
end