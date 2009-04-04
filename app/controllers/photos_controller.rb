class PhotosController < ApplicationController
  before_filter :require_user

  def index
    @photos = current_user.photos.find(:all)
  end

  def new
    @photo = current_user.photos.build
  end

  def create
    @photo = current_user.photos.build(params[:photo])
    if @photo.save
      redirect_to photo_path(@photo)
    else
      render :action => "new"
    end
  end

  def edit
    @photo = current_user.photos.find params[:id]
  end

  def update
    @photo = current_user.photos.find params[:id]
    if @photo.update_attributes(params[:photo])
      redirect_to photo_path(@photo)
    else
      render :action => "edit"
    end
  end

  def show
    @photo = current_user.photos.find params[:id]
  end

  def destroy
    @photo = current_user.photos.find(params[:id]).destroy
    redirect_to photos_path
  end
end
