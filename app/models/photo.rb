require 'mini_exiftool'
class Photo < ActiveRecord::Base

  validates_presence_of :title

  has_attached_file :picture,
                    :styles => { :thumb  => ["100x75>", :png],
                                 :tiny   => ["180x135", :png],
                                 :small  => ["240x180>", :png],
                                 :medium => ["500x375>", :png] }

  before_validation :set_title

# FIXME: set_exif_data grabs wrong path
#  after_create :set_exif_data

  def exif_data
    ExifData.new(self.attributes.slice(*ExifData::ATTRIBUTES))
  end

  def set_exif_data
    file = self.picture.path(:original)
    if File.exists?(file)
      @photo_file = MiniExiftool.new(file)
      exif_data_hash = { }
      ExifData::ATTRIBUTES.each do |field|
        exif_field = @photo_file[field]
        next if exif_field.nil?
        exif_data_hash[field.intern] = exif_field
      end
      update_attributes!(exif_data_hash)
    end
  end

  protected
  def set_title
    self.title = "untitled photo" if self.title.nil?
  end
end
