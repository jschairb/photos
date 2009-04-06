class PasswordResetsController < ApplicationController
  before_filter :require_no_user

  def new
    render
  end

  def create
    @user = User.find_by_email(params[:email])
    if @user
      @user.reset_password!
      redirect_to new_user_session_path
    else
      render :action => "new"
    end
  end

  def edit
    @user = User.find_using_perishable_token(params[:id], 1.hour)
    if @user
      render
    else
      redirect_to new_password_reset_path
    end
  end

  def update
    @user = User.find_using_perishable_token(params[:id], 1.day)
    # FIXME: multiple code branches hurt
    if @user
      @user.password = params[:user][:password]
      @user.password_confirmation = params[:user][:password_confirmation]
      if @user.save
        redirect_to account_url        
      else
        render :action => :edit
      end
    else
      render :action => :edit
    end
  end

end
