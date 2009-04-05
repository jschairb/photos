class User < ActiveRecord::Base
  acts_as_authentic

  has_many :photos, :dependent => :destroy

  attr_accessible :login, :email, :password, :password_confirmation

  after_create :deliver_activation_instructions!

  def active?
    active
  end

  def activate!
    self.active = true
    save
  end

  private
  def deliver_activation_instructions!
    reset_perishable_token!
    AccountMaintenance.deliver_activation_instructions(self)
  end

end
