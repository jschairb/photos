class CreateBuckets < ActiveRecord::Migration
  def self.up
    create_table :buckets do |t|
      t.integer :user_id
      t.string  :title

      t.timestamps
    end

    add_column :photos, :bucket_id, :integer
  end

  def self.down
    drop_table :buckets
    remove_column :photos, :bucket_id
  end
end
