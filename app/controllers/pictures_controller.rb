class PicturesController < ApplicationController
  before_filter :require_user

  def show
    style = params[:style] ? params[:style].intern : :original
    @photo = current_user.photos.find_by_token(params[:id])
    picture = @photo.picture.path(style)
    send_file( picture, 
               :type => @photo.picture_content_type, 
               :dispostion => 'inline' )
  end

end
