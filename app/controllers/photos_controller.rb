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
    @photo = Photo.find params[:id]
    if @photo.update_attributes(params[:photo])
      redirect_to photo_path(@photo)
    else
      render :action => "edit"
    end
  end

  def show
    @photo = Photo.find params[:id]
  end

  def destroy
    @photo = Photo.find(params[:id]).destroy
    redirect_to photos_path
  end
end
