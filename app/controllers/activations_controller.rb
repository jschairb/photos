class ActivationsController < ApplicationController
  before_filter :require_no_user, :only => [:new, :create, :instructions]
  
  def new
    @user = User.find_using_perishable_token(params[:activation_code], 1.week)
  end

  def create
    @user = User.find(params[:id])
    if !@user.active? && @user.activate!
      redirect_to account_url
    else
      render :action => :new
    end
  end

  def instructions
  end

end
