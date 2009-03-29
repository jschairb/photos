class PhotosController < ApplicationController
  def index
    @photos = Photo.find(:all)
  end

  def new
    @photo = Photo.new
  end

  def create
    @photo = Photo.new(params[:photo])
    if @photo.save
      redirect_to photo_path(@photo)
    else
      render :action => "new"
    end
  end

  def edit
  end

  def update
  end

  def show
  end

  def destroy
  end

end
