class CreateCats < ActiveRecord::Migration
  def self.up
    create_table :cats do |t|
      t.string :cat_name
      t.string :cat_name_en

      t.timestamps
    end
  end

  def self.down
    drop_table :cats
  end
end
