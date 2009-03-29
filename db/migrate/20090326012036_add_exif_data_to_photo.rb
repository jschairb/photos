class AddExifDataToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :aperture, :string
    add_column :photos, :comment, :string
    add_column :photos, :create_date, :datetime
    add_column :photos, :date_time_original, :datetime
    add_column :photos, :device_attributes, :string
    add_column :photos, :exif_tool_version, :string
    add_column :photos, :exif_version, :string
    add_column :photos, :exposure_time, :string
    add_column :photos, :flash, :string
    add_column :photos, :focal_length, :string
    add_column :photos, :image_size, :string
    add_column :photos, :keywords, :string
    add_column :photos, :make, :string
    add_column :photos, :model, :string
    add_column :photos, :modify_date, :datetime
    add_column :photos, :orientation, :string
    add_column :photos, :shutter_speed, :string
  end

  def self.down
    remove_column :photos, :aperture
    remove_column :photos, :comment
    remove_column :photos, :create_date
    remove_column :photos, :date_time_original
    remove_column :photos, :device_attributes
    remove_column :photos, :exif_tool_version
    remove_column :photos, :exif_version
    remove_column :photos, :exposure_time
    remove_column :photos, :flash
    remove_column :photos, :focal_length
    remove_column :photos, :image_size
    remove_column :photos, :keywords
    remove_column :photos, :make
    remove_column :photos, :model
    remove_column :photos, :modify_date
    remove_column :photos, :orientation
    remove_column :photos, :shutter_speed
  end
end
