class Invite < ActiveRecord::Base
  belongs_to :sender, :class_name => "User"
  has_one :recipient, :class_name => "User"

end
