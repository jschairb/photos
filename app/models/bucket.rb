class Bucket < ActiveRecord::Base

  has_many :photos, :dependent => :nullify
  belongs_to :user

  validates_presence_of :title, :user

  before_validation :set_title

  def set_title
    self.title = "untitled bucket" if self.title.blank?
  end

end
