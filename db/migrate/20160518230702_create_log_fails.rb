class CreateLogFails < ActiveRecord::Migration
  def self.up
    create_table :log_fails do |t|
      t.integer :user_id
      t.string :password
      t.string :ip
      t.string :system_type
      t.string :browser_type

      t.timestamps
    end
  end

  def self.down
    drop_table :log_fails
  end
end
