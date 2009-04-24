class User < ActiveRecord::Base
  DEFAULT_INVITE_LIMIT = 5

  acts_as_authentic

  validates_presence_of :invite_id, :message => "is required"
  validates_uniqueness_of :invite_id, :message => "has already been registered"

  has_many :buckets, :dependent => :destroy
  has_many :photos, :dependent => :destroy
  has_many :sent_invites, :class_name => "Invite", :foreign_key => "sender_id"
  belongs_to :invite

  attr_accessible :login, :email, :invite_token, :password, :password_confirmation

  after_create :deliver_activation_instructions!
  before_create :set_invite_limit

  def active?
    active
  end

  def activate!
    self.active = true
    if save
      deliver_activation_completion!
    end
  end

  def has_unused_invites?
    return true if invite_limit > 0
  end

  def invite_token
    invite.token if invite
  end

  def invite_token=(token)
    self.invite = Invite.find_by_token(token)
  end

  def reset_password!
    reset_perishable_token!
    AccountMaintenance.deliver_password_reset_instructions(self)
  end

  private
  def deliver_activation_instructions!
    reset_perishable_token!
    AccountMaintenance.deliver_activation_instructions(self)
  end

  def deliver_activation_completion!
    reset_perishable_token!
    AccountMaintenance.deliver_activation_completion(self)
  end

  def set_invite_limit
    self.invite_limit = DEFAULT_INVITE_LIMIT
  end
end
