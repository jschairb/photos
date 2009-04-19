class ExifData
  ATTRIBUTES = %w( aperture comment create_date date_time_original device_attributes 
                   exif_tool_version exif_version exposure_time flash focal_length 
                   image_size keywords make model modify_date orientation shutter_speed
                   exif_image_length exif_image_width x_resolution y_resolution 
                   y_cb_cr_positioning )

  attr_accessor *ATTRIBUTES

  attr_accessor :attributes

  def initialize(attrs)
    self.attributes = attrs
    attrs.each do |key, value|
      next unless ATTRIBUTES.include?(key.to_s)
      self.instance_variable_set("@#{key}".intern, value)
    end
  end

  def empty?
    attributes.values.all?(&:blank?)
  end

end
