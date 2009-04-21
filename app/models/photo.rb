require 'open-uri'
class Photo < ActiveRecord::Base

  attr_accessor :picture_url

  belongs_to :user

  has_attached_file :picture,
                    :styles => { :thumb  => ["100x75>", :png],
                                 :tiny   => ["180x135", :png],
                                 :small  => ["240x180>", :png],
                                 :medium => ["500x375>", :png] },
                    :url => "/pictures/:id/:style",
                    :path => ":rails_root/data/:attachment/:id/:style/:basename.:extension"

  is_taggable :tags

  validates_attachment_presence :picture
  validates_presence_of :title, :user
  validates_presence_of :picture_remote_url, :if => :picture_url_provided?, 
                                             :message => 'is invalid or inaccessible'

  before_validation :set_title
  before_validation :download_remote_picture, :if => :picture_url_provided?

  after_picture_post_process :set_exif_data

  def exif_data
    ExifData.new(self.attributes.slice(*ExifData::ATTRIBUTES))
  end

  protected
  def set_exif_data
    imgfile = Magick::Image.read(self.picture.queued_for_write[:original].path).first
    return unless imgfile
    logger.info "Photo EXIF: " + imgfile.get_exif_by_entry().inspect

    self.date_time_original = imgfile.get_exif_by_entry('DateTimeOriginal')[0][1]
    self.create_date = imgfile.get_exif_by_entry('DateTime')[0][1]
    self.modify_date = imgfile.get_exif_by_entry('DateTimeDigitized')[0][1]
    self.exif_image_length = imgfile.get_exif_by_entry('ExifImageLength')[0][1]
    self.exif_image_width = imgfile.get_exif_by_entry('ExifImageWidth')[0][1]
    self.make = imgfile.get_exif_by_entry('Make')[0][1]
    self.aperture = imgfile.get_exif_by_entry('ApertureValue')[0][1]
    self.model = imgfile.get_exif_by_entry('Model')[0][1]
    self.flash = imgfile.get_exif_by_entry('Flash')[0][1]
    self.x_resolution = imgfile.get_exif_by_entry('XResolution')[0][1]
    self.y_resolution = imgfile.get_exif_by_entry('YResolution')[0][1]
    self.y_cb_cr_positioning = imgfile.get_exif_by_entry('YCbCrPositioning')[0][1]
    self.orientation = imgfile.get_exif_by_entry('Orientation')[0][1]
    self.shutter_speed = imgfile.get_exif_by_entry('ShutterSpeedValue')[0][1]
    self.exposure_time = imgfile.get_exif_by_entry('ExposureTime')[0][1]
    self.focal_length = imgfile.get_exif_by_entry('FocalLength')[0][1]
  end

  def set_title
    self.title = "untitled photo" if self.title.blank?
  end

private
 
  def picture_url_provided?
    !self.picture_url.blank?
  end
 
  def download_remote_picture
    self.picture = do_download_remote_picture
    self.picture_remote_url = picture_url
  end
 
  def do_download_remote_picture
    io = open(URI.parse(picture_url))
    def io.original_filename; base_uri.path.split('/').last; end
    io.original_filename.blank? ? nil : io
#  rescue # catch url errors with validations instead of exceptions (Errno::ENOENT, OpenURI::HTTPError, etc...)
  end

end
