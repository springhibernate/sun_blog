class CreateBlogs < ActiveRecord::Migration
  def self.up
    create_table :blogs do |t|
      t.string :title
      t.string :title_en
      t.string :intro
      t.text :content_md
      t.text :content
      t.integer :cat_id
      t.integer :read_count,:default=>0
      t.integer :user_id
      t.string :seo_title
      t.string :seo_keyword
      t.string :seo_desc

      t.timestamps
    end
  end

  def self.down
    drop_table :blogs
  end
end
