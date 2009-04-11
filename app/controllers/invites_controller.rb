class InvitesController < ApplicationController
  before_filter :require_user, :only => :new

  def new
    @invite = current_user.sent_invites.build
  end

  def create
    attrs = params[:invite]
    @invite = current_user ? current_user.sent_invites.build(attrs) : Invite.new(attrs)
    if @invite.save
      path = @invite.sender.present? ? user_path(current_user) : root_path
      redirect_to path
    else
      render :action => "new"
    end
  end
end
