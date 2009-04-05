class User < ActiveRecord::Base
  acts_as_authentic

  has_many :photos, :dependent => :destroy

  attr_accessible :login, :email, :password, :password_confirmation

  def active?
    active
  end

  def activate!
    self.active = true
    save
  end

end
