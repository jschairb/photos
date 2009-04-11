class InvitesController < ApplicationController
  before_filter :require_user

  def new
    @invite = current_user.sent_invites.build
  end

  def create
    @invite = current_user.sent_invites.build(params[:invite])
    if @invite.save
      redirect_to user_path(current_user)
    else
      render :action => "new"
    end
  end

end
