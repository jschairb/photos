class AddMoreExifFieldsToPhoto < ActiveRecord::Migration
  def self.up
    add_column :photos, :exif_image_length, :string
    add_column :photos, :exif_image_width, :string
    add_column :photos, :x_resolution, :string
    add_column :photos, :y_resolution, :string
    add_column :photos, :y_cb_cr_positioning, :string
  end

  def self.down
    remove_column :photos, :exif_image_length
    remove_column :photos, :exif_image_width
    remove_column :photos, :x_resolution
    remove_column :photos, :y_resolution
    remove_column :photos, :y_cb_cr_positioning
  end
end
