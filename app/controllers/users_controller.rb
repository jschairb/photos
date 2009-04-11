class UsersController < ApplicationController

  before_filter :require_no_user, :only => [:new, :create]
  before_filter :require_user, :only => [:show, :edit, :update]

  def new
    @user = User.new(:invite_token => params[:invite_token])
    @user.email = @user.invite.recipient_email
  end

  def create
    @user = User.new(params[:user])
    if @user.save_without_session_management
      redirect_to instructions_activations_path
    else
      render :action => "new"
    end
  end

  def show
    @user = @current_user
  end

  def edit
    @user = @current_user
  end

  def update
    @user = @current_user
    if @user.update_attributes(params[:user])
      redirect_to user_path(@user)
    else
      render :action => :edit
    end
  end
end
