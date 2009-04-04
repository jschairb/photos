class PicturesController < ApplicationController
  before_filter :require_user

  def show
#     @photo = current_user.photos.find(params[:id])
#     picture = @photo.picture.path(params[:size])
#     send_file(picture, :type => @photo.picture_content_type, :x_sendfile => true)
  end

end
