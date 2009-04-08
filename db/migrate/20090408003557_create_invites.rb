class CreateInvites < ActiveRecord::Migration
  def self.up
    create_table :invites do |t|
      t.integer :sender_id
      t.string :recipient_email
      t.string :token
      t.datetime :sent_at

      t.timestamps
    end

    add_column :users, :invite_id, :integer
    add_column :users, :invite_limit, :integer
  end

  def self.down
    drop_table :invites
    remove_column :users, :invite_id
    remove_column :users, :invite_limit
  end
end
