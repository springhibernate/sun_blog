class CreateUserInfos < ActiveRecord::Migration
  def self.up
    create_table :user_infos do |t|
      t.string :user_name
      t.string :password
      t.string :salt
      t.integer :status ,:default=>1
      t.datetime :last_logtime

      t.timestamps
    end
  end

  def self.down
    drop_table :user_infos
  end
end
