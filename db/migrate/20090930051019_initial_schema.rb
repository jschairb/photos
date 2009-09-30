class InitialSchema < ActiveRecord::Migration
  def self.up
    create_table :buckets do |t|
      t.integer :user_id
      t.string  :title

      t.timestamps
    end

    create_table :buckets_photos, :id => false do |t|
      t.integer :bucket_id
      t.integer :photo_id
    end

    create_table :invites do |t|
      t.integer :sender_id
      t.string :recipient_email
      t.string :token
      t.datetime :sent_at

      t.timestamps
    end

    create_table :photos do |t|
      t.string   :title
      t.text     :description
      # paperclip
      t.string   :picture_file_name
      t.string   :picture_content_type
      t.integer  :picture_file_size
      t.datetime :picture_updated_at
      t.string   :picture_remote_url
      # exif
      t.string   :aperture
      t.string   :comment
      t.string   :create_date
      t.string   :date_time_original
      t.string   :device_attributes
      t.string   :exif_tool_version
      t.string   :exif_version
      t.string   :exposure_time
      t.string   :flash
      t.string   :focal_length
      t.string   :image_size
      t.string   :keywords
      t.string   :make
      t.string   :model
      t.string   :modify_date
      t.string   :orientation
      t.string   :shutter_speed
      t.string   :exif_image_length, :string
      t.string   :exif_image_width, :string
      t.string   :x_resolution, :string
      t.string   :y_resolution, :string
      t.string   :y_cb_cr_positioning, :string

      # user
      t.integer  :user_id

      t.timestamps
    end
    create_table :users do |t|
      t.string    :login,               :null => false                
      t.string    :email,               :null => false                
      t.boolean   :active, :default => false, :null => false
      t.string    :crypted_password,    :null => false               
      t.string    :password_salt,       :null => false                
      t.string    :persistence_token,   :null => false                
      t.string    :single_access_token, :null => false  
      t.string    :perishable_token,    :null => false  
      t.integer   :login_count,         :null => false, :default => 0 
      t.integer   :failed_login_count,  :null => false, :default => 0 
      t.datetime  :last_request_at                                    
      t.datetime  :current_login_at                                   
      t.datetime  :last_login_at                                      
      t.string    :current_login_ip                                   
      t.string    :last_login_ip                                      
      
      # invites
      t.integer  :invite_id
      t.integer  :invite_limit
            
      t.timestamps
    end

    create_table :tags do |t|
      t.string :name, :default => ''
      t.string :kind, :default => '' 
    end

    create_table :taggings do |t|
      t.integer :tag_id

      t.string  :taggable_type, :default => ''
      t.integer :taggable_id
    end
    
    add_index :tags,     [:name, :kind]
    add_index :taggings, :tag_id
    add_index :taggings, [:taggable_id, :taggable_type]

  end

  def self.down
    drop_table :buckets
    drop_table :buckets_photos
    drop_table :invites
    drop_table :photos
    drop_table :taggings
    drop_table :tags
    drop_table :users
  end
end
