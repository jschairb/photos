class BucketsController < ApplicationController
  before_filter :require_user

  def index
    @buckets = current_user.buckets
  end

  def new
    @bucket = current_user.buckets.build
  end

  def create
    @bucket = current_user.buckets.build(params[:bucket])
    if @bucket.save
      redirect_to bucket_path(@bucket)
    else
      render :action => "new"
    end
  end

  def edit
    @bucket = current_user.buckets.find params[:id]
  end

  def update
    @bucket = current_user.buckets.find params[:id]
    if @bucket.update_attributes(params[:bucket])
      redirect_to bucket_path(@bucket)
    else
      render :action => "edit"
    end
  end

  def show
    @bucket = current_user.buckets.find params[:id]
  end

  def destroy
    @bucket = current_user.buckets.find(params[:id]).destroy
    redirect_to buckets_path
  end
end
