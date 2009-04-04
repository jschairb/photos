class PicturesController < ApplicationController
  before_filter :require_user

  def show
    @photo = current_user.photos.find(params[:id])
    picture = @photo.picture.path
    send_file(picture, :type => @photo.picture_content_type, :dispostion => 'inline')
  end

end
