# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20160520061909) do

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.string   "title_en"
    t.string   "intro"
    t.text     "content_md"
    t.text     "content"
    t.integer  "cat_id"
    t.integer  "read_count",  :default => 0
    t.integer  "user_id"
    t.string   "seo_title"
    t.string   "seo_keyword"
    t.string   "seo_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "cats", :force => true do |t|
    t.string   "cat_name"
    t.string   "cat_name_en"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "comments", :force => true do |t|
    t.integer  "blog_id"
    t.string   "email"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "log_fails", :force => true do |t|
    t.integer  "user_id"
    t.string   "password"
    t.string   "ip"
    t.string   "system_type"
    t.string   "browser_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_infos", :force => true do |t|
    t.string   "user_name"
    t.string   "password"
    t.string   "salt"
    t.integer  "status",       :default => 1
    t.datetime "last_logtime"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
