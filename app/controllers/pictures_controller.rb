class PicturesController < ApplicationController
  before_filter :require_user

  def show
    style = params[:style] ? params[:style].intern : :original
    @photo = current_user.photos.find(params[:id])
    picture = @photo.picture.path
    send_file( picture, :type => @photo.picture_content_type, 
                        :dispostion => 'inline',
                        :x_sendfile => true )
  end

end
