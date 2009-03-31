class UserSessionsController < ApplicationController

  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    if @user_session.save
      redirect_to root_path
    else
      render :action => "new"
    end
  end

  def destroy
    
  end

  # 1. add user crud
  # 2. add current_user functionality
  # 3. finish logout
  # 4. add filter functionality

end
