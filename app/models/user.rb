class User < ActiveRecord::Base
  acts_as_authentic

  has_many :photos, :dependent => :destroy
end
