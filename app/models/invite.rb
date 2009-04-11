class Invite < ActiveRecord::Base

  belongs_to :sender, :class_name => "User"
  has_one :recipient, :class_name => "User"

  validates_presence_of :recipient_email
  validate :invite_has_not_been_accepted
  validate :sender_has_unused_invites

  before_create :generate_token
  after_create  :decrement_sender_invite_limit

  def has_been_accepted?
    return true if User.find_by_email(self.recipient_email)
  end

private

  def decrement_sender_invite_limit
    sender.decrement! :invite_limit
  end

  def generate_token
    self.token = Digest::SHA1.hexdigest([Time.now,rand].join)
  end

  def invite_has_not_been_accepted
    errors.add :recipient_email, 'is already registered' if has_been_accepted?
  end

  def sender_has_unused_invites
    errors.add_to_base "You have reached your limit of invites." unless sender.has_unused_invites?
  end
end
