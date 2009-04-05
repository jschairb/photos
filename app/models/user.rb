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
    if save
      deliver_activation_completion!
    end
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
end
