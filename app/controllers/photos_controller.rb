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
    @photo = Photo.find params[:id]
  end

  def update
  end

  def show
    @photo = Photo.find params[:id]
  end

  def destroy
  end

end
