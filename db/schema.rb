# encoding: UTF-8
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

ActiveRecord::Schema.define(:version => 20130501000401) do

  create_table "categories", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "comments", :force => true do |t|
    t.text     "comment"
    t.integer  "user_id"
    t.integer  "post_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.boolean  "is_published"
    t.boolean  "is_validated"
  end

  create_table "images", :force => true do |t|
    t.string   "name"
    t.string   "media"
    t.integer  "user_id"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "menus", :force => true do |t|
    t.string   "name"
    t.integer  "page_id"
    t.boolean  "is_active"
    t.integer  "menu_id"
    t.integer  "menu_type"
    t.integer  "menu_order"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "menus", ["page_id"], :name => "index_menus_on_page_id"

  create_table "pages", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "is_published"
    t.integer  "category_id"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  add_index "pages", ["category_id"], :name => "index_pages_on_category_id"
  add_index "pages", ["user_id"], :name => "index_pages_on_user_id"

  create_table "parameters", :force => true do |t|
    t.string   "name"
    t.string   "value"
    t.text     "description"
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
    t.string   "group"
  end

  create_table "posts", :force => true do |t|
    t.string   "title"
    t.text     "content"
    t.boolean  "is_published"
    t.integer  "user_id"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.integer  "category_id"
    t.text     "preview"
  end

  create_table "tag_groups", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "tags", :force => true do |t|
    t.integer  "tag_group_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.datetime "created_at",    :null => false
    t.datetime "updated_at",    :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "name"
    t.string   "login"
    t.string   "email"
    t.string   "password_hash"
    t.string   "password_salt"
    t.boolean  "is_admin"
    t.boolean  "is_active"
    t.integer  "wrong_login_attempts"
    t.integer  "created_by"
    t.integer  "updated_by"
    t.datetime "created_at",           :null => false
    t.datetime "updated_at",           :null => false
  end

  create_table "versions", :force => true do |t|
    t.string   "item_type",  :null => false
    t.integer  "item_id",    :null => false
    t.string   "event",      :null => false
    t.string   "whodunnit"
    t.text     "object"
    t.datetime "created_at"
  end

  add_index "versions", ["item_type", "item_id"], :name => "index_versions_on_item_type_and_item_id"

end
