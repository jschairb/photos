class CreateBucketsPhotosJoinTable < ActiveRecord::Migration
  def self.up
    create_table :buckets_photos, :id => false do |t|
      t.integer :bucket_id
      t.integer :photo_id
    end

    remove_column :photos, :bucket_id
  end

  def self.down
    drop_table :buckets_photos
    add_column :photos, :bucket_id, :integer
  end
end
