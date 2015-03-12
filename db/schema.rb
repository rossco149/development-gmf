# This file is auto-generated from the current state of the database. Instead of editing this file, 
# please use the migrations feature of Active Record to incrementally modify your database, and
# then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your database schema. If you need
# to create the application database on another system, you should be using db:schema:load, not running
# all the migrations from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20121031140104) do

  create_table "collections", :force => true do |t|
    t.string  "name",              :null => false
    t.boolean "show_on_site"
    t.string  "description"
    t.integer "master_collection"
    t.integer "nav_order"
  end

  create_table "collections_products", :id => false, :force => true do |t|
    t.integer "collection_id"
    t.integer "product_id"
  end

  create_table "contacts", :force => true do |t|
    t.string   "name",                               :null => false
    t.string   "address"
    t.string   "enquiry"
    t.string   "phone"
    t.string   "email",                              :null => false
    t.string   "fire_type"
    t.string   "callback_method"
    t.boolean  "viewed",          :default => false
    t.datetime "created",                            :null => false
  end

  create_table "homebanners", :force => true do |t|
    t.string   "name",               :null => false
    t.string   "description",        :null => false
    t.string   "image"
    t.boolean  "show_on_site"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "products", :force => true do |t|
    t.string   "name",                                  :null => false
    t.string   "description",                           :null => false
    t.string   "available_materials"
    t.boolean  "featured"
    t.boolean  "show_on_site",        :default => true
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
  end

  create_table "quotes", :force => true do |t|
    t.string  "quote_type",    :limit => 10, :default => "private"
    t.string  "customer_name",                                      :null => false
    t.string  "quote_text"
    t.boolean "show_on_site",                :default => true
  end

  create_table "users", :force => true do |t|
    t.string   "username",                      :null => false
    t.string   "password",                      :null => false
    t.datetime "last_login"
    t.boolean  "super",      :default => false
  end

end
