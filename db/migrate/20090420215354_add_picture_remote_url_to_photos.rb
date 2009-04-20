class AddPictureRemoteUrlToPhotos < ActiveRecord::Migration
  def self.up
    add_column :photos, :picture_remote_url, :string
  end

  def self.down
    remove_column :photos, :picture_remote_url
  end
end
